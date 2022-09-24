/*
 *  wmJNIc.c:    Library routines for client-side C/C++.
 *
 * Copyright (C) 1996-1999, webMethods, Inc. All Rights Reserved.
 */

#include "wmJNIc.h"

#define JAVA2

/* -- Forward decls for private functions -- */
jint			isClientContext(WmContext *cc);
JNIEnv *		attachThread();
void			detachThread(WmContext *cc);

/* --------- Globals ----------- */

JavaVM *		wm_jvm=0;			/* singleton (per process) Java VM */
JNIEnv * 		wm_jvm_env=0;		/* main thread JNI context */
void *		 	wm_jvm_args=0;		/* jvm parameters */
void *			wm_thr_args=0;		/* thread attach - dummy arg */
WmContext *		wm_context=0;		/* convenience wrapper for env */
char			jvm_classpath[4096];

static jclass	cCContext=0;		/* client context */
static jclass   cTContext=0;		/* transactional context */
static jclass   cAContext=0;		/* invoke thread */
static jclass   cEContext=0;		/* enumeration */

/* Context class methods */
static jmethodID mCC=0;
static jmethodID mCCconnectUserPass=0;
static jmethodID mCCconnectCertBytes=0;
static jmethodID mCCconnectCertString=0;
static jmethodID mCCdisconnect=0;

static jmethodID mCCgetCert=0;
static jmethodID mCCisConnected=0;
static jmethodID mCCisSecure=0;

static jmethodID mCCsetSecure=0;
static jmethodID mCCsetFixedUri=0;
static jmethodID mCCsetProxy=0;
static jmethodID mCCsetRPCType=0;
static jmethodID mCCsetCertificates=0;
static jmethodID mCCsetSecureProxy=0;

static jmethodID mCCinvokeSync=0;
static jmethodID mCCinvokeAsync=0;

/* TContext methods */

static jmethodID mTCinit=0;
static jmethodID mTCinitWithArgs=0;
static jmethodID mTCshutdown=0;

static jmethodID mTCreset=0;
static jmethodID mTCresetWithArgs=0;
static jmethodID mTCresetLog=0;
static jmethodID mTCresetLogWithArgs=0;

static jmethodID mTC=0;
static jmethodID mTCconnectUserPass=0;
static jmethodID mTCconnectCertBytes=0;
static jmethodID mTCconnectCertString=0;
static jmethodID mTCdisconnect=0;

static jmethodID mTCstartTx=0;
static jmethodID mTCstartTxTtl=0;
static jmethodID mTCstartTxRetries=0;
static jmethodID mTCrestartTx=0;
static jmethodID mTCendTx=0;

static jmethodID mTCchainTx=0;
static jmethodID mTCchainTxTtl=0;
static jmethodID mTCchainTxRetries=0;

static jmethodID mTCsubmitTx=0;
static jmethodID mTCretrieveTx=0;
static jmethodID mTCinvokeTx=0;

static jmethodID mTCgetTxIds=0;
static jmethodID mTCgetTxStatus=0;
static jmethodID mTCgetTxStatusVal=0;
static jmethodID mTCgetTxRmtId=0;
static jmethodID mTCgetTxChainId=0;

/* methods for invoke thread */
static jmethodID mACgetData=0;

/* methods for enumeration */
static jmethodID mEChasMoreElements=0;
static jmethodID mECnextElement=0;

/* ---------------- setup ------------------------ */

/*
 * Init JDK1.1 (VM-specific) initialization args (global).
 * Alternatively, initialize your own directly.
 * Set all init arg values before calling initWmClient().
 *
 * Takes a zero-terminated array of strings in "name=value" form
 * to set up environment vars to pass as properties into jvm.
 * Sets Classpath separately from environment variable
 * CLASSPATH.
 */
jint
initJVM1_1Args(char ** properties)
{
#ifndef JAVA2

	jint res;
	JDK1_1InitArgs	*args;

	/* make sure we're not already initialized */
	if (wm_jvm_args != 0)
		return 1;

	wm_jvm_args = malloc(sizeof(JDK1_1InitArgs));
	wm_thr_args = malloc(sizeof(JDK1_1AttachArgs));
	if (wm_jvm_args == 0 || wm_thr_args == 0) {
		fprintf(stderr, "Out of Memory on vm args\n");
		return 0;
	}

	/* get JVM Args */
	args = (JDK1_1InitArgs *)wm_jvm_args;
	args->version = 0x00010001;
	res = JNI_GetDefaultJavaVMInitArgs(args);
	if (res < 0) {
		fprintf(stderr, "JNI Version not supported\n");
		return 0;
	}

	/* set classpath from environment - user can augment or replace */
	args->classpath = getenv("CLASSPATH");

	/* setup properties */
	args->properties = properties;

	/* These are left up to the user to tune...
	args->checkSource = (jint)
	args->nativeStackSize = (jint)
	args->javaStackSize = (jint)
	args->minHeapSize = (jint)
	args->maxHeapSize = (jint)
	args->verifyMode = (jint 0=none, 1-remote, 2-all)
	args->classpath = (const char *) */
	args->enableClassGC = 1;
	args->enableVerboseGC = 1;
	args->disableAsyncGC = 0;
	/*args->exit = (void (*exit)(jint code))
	args->abort = (void (*abort)())
	args->vfprintf = (jint (*vrfrintf)(FILE *fp, const char*format, va_list args))
	*/

#else

	int numUserOptions = 0;
	int numOptions = 0;
	int i = 0;
	JavaVMInitArgs *vm_args;
	JavaVMOption *options;

	while(properties && properties[numUserOptions])
		numUserOptions++;
	numOptions = 1 + numUserOptions;

	wm_jvm_args = malloc(sizeof(JavaVMInitArgs));
	vm_args = (JavaVMInitArgs*)wm_jvm_args;

	sprintf(&jvm_classpath[0],"-Djava.class.path=%s",getenv("CLASSPATH"));
	options = malloc(sizeof(JavaVMOption)*numOptions);
	options[0].optionString = jvm_classpath; /* user classes */

	for(i=0;i<numUserOptions && i<8;i++)
		strcpy(options[1+i].optionString,properties[i]);

	vm_args->version = JNI_VERSION_1_2;
	vm_args->options = options;
	vm_args->nOptions = numOptions;
	vm_args->ignoreUnrecognized = JNI_FALSE;

#endif

	return 1;
}

jint
initWmClient()
{
	jint	res;
	jobject oTmp;

	/* make sure we're not already initialized */
	if (wm_jvm != 0) {
		fprintf(stderr, "Already initialized");
		return 1;
	}

	/* init JVM args if not done by user */
	if (!initJVM1_1Args(0))
		return 0;

	/* create JVM */
#ifdef JAVA2
	res = JNI_CreateJavaVM(&wm_jvm, (void **)&wm_jvm_env, wm_jvm_args);
	free ( ((JavaVMInitArgs *)wm_jvm_args)->options );
#else
	res = JNI_CreateJavaVM(&wm_jvm, &wm_jvm_env, wm_jvm_args);
#endif
	if (res < 0) {
		fprintf(stderr, "Can't create Java VM\n");
		return 0;
	}

	//res = (*wm_jvm)->AttachCurrentThread(wm_jvm, (void **)&wm_jvm_env, wm_thr_args);

	/* initialize record api */
	wm_context = makeContext(wm_jvm_env, WM_SVR_CONTEXT, 0);
	if (wm_context == 0)
		return 0;
	if (!WmRecInit(wm_context))
		return 0;

	/* initialize class objects */
    oTmp = (*wm_jvm_env)->FindClass(wm_jvm_env, "com/wm/app/b2b/client/Context");
    if (oTmp == 0) {
        setError(wm_context, "Unable to initialize Context class reference");
        return 0;
    }
    cCContext = (*wm_jvm_env)->NewGlobalRef(wm_jvm_env, oTmp);

	(*wm_jvm_env)->DeleteLocalRef(wm_jvm_env, oTmp);

    if (cCContext == 0) {
        setError(wm_context, "Unable to get global reference to Context class");
        return 0;
    }


    oTmp = (*wm_jvm_env)->FindClass(wm_jvm_env, "com/wm/app/b2b/client/TContext");
    if (oTmp == 0) {
        setError(wm_context, "Unable to initialize TContext class reference");
        return 0;
    }
    cTContext = (*wm_jvm_env)->NewGlobalRef(wm_jvm_env, oTmp);

	(*wm_jvm_env)->DeleteLocalRef(wm_jvm_env, oTmp);

    if (cTContext == 0) {
        setError(wm_context, "Unable to get global reference to TContext class");
        return 0;
    }

    oTmp = (*wm_jvm_env)->FindClass(wm_jvm_env, "com/wm/app/b2b/client/InvokeThread");
    if (oTmp == 0) {
        setError(wm_context, "Unable to initialize InvokeThread class reference");
        return 0;
    }
    cAContext = (*wm_jvm_env)->NewGlobalRef(wm_jvm_env, oTmp);

	(*wm_jvm_env)->DeleteLocalRef(wm_jvm_env, oTmp);

    if (cAContext == 0) {
        setError(wm_context, "Unable to get global reference to InvokeThread class");
        return 0;
    }

	oTmp = (*wm_jvm_env)->FindClass(wm_jvm_env, "java/util/Enumeration");
    if (oTmp == 0) {
        setError(wm_context, "Unable to initialize Enumeration class reference");
        return 0;
    }
    cEContext = (*wm_jvm_env)->NewGlobalRef(wm_jvm_env, oTmp);

	(*wm_jvm_env)->DeleteLocalRef(wm_jvm_env, oTmp);

    if (cEContext == 0) {
        setError(wm_context, "Unable to get global reference to Enumeration class");
        return 0;
    }

	/* initialize method ids for Context */
    mCC = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cCContext, "<init>", "()V");
    if (mCC == 0) {
        setError(wm_context, "Unable to initialize Context class constructor");
        return 0;
    }

    mCCconnectUserPass = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cCContext, "connect",
			"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V");
    if (mCCconnectUserPass == 0) {
        setError(wm_context, "Unable to initialize Context.connect(UserPass)");
        return 0;
    }

    mCCconnectCertBytes = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cCContext, "connect",
			"(Ljava/lang/String;[B)V");
    if (mCCconnectCertBytes == 0) {
        setError(wm_context, "Unable to initialize Context.connect(CertBytes)");
        return 0;
    }

    mCCconnectCertString = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cCContext, "connect",
			"(Ljava/lang/String;Ljava/lang/String;)V");
    if (mCCconnectCertString == 0) {
        setError(wm_context, "Unable to initialize Context.connect(CertString)");
        return 0;
    }

    mCCdisconnect = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cCContext, "disconnect", "()V");
    if (mCCdisconnect == 0) {
        setError(wm_context, "Unable to initialize Context.disconnect");
        return 0;
    }

    mCCgetCert = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cCContext, "getCertificate",
			"(Ljava/lang/String;)[B");
    if (mCCgetCert == 0) {
        setError(wm_context, "Unable to initialize Context.getCertificate");
        return 0;
    }

    mCCisConnected = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cCContext, "isConnected", "()Z");
    if (mCCisConnected == 0) {
        setError(wm_context, "Unable to initialize Context.isConnected");
        return 0;
    }

    mCCisSecure = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cCContext, "isSecure", "()Z");
    if (mCCisSecure == 0) {
        setError(wm_context, "Unable to initialize Context.isSecure");
        return 0;
    }

    mCCsetSecure = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cCContext, "setSecure", "(Z)V");
    if (mCCsetSecure == 0) {
        setError(wm_context, "Unable to initialize Context.setSecure");
        return 0;
    }

    mCCsetFixedUri = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cCContext, "setFixedUri",
						"(Ljava/lang/String;)V");
    if (mCCsetFixedUri == 0) {
        setError(wm_context, "Unable to initialize Context.setFixedUri");
        return 0;
    }

    mCCsetProxy = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cCContext, "setProxy",
						"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V");
    if (mCCsetProxy == 0) {
        setError(wm_context, "Unable to initialize Context.setProxy");
        return 0;
    }

    mCCsetRPCType = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cCContext, "setRPCType", "(I)V");
    if (mCCsetRPCType == 0) {
        setError(wm_context, "Unable to initialize Context.setRPCType");
        return 0;
    }

    mCCsetCertificates = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cCContext,
			"setSSLCertificates",
			"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V");
    if (mCCsetCertificates == 0) {
        setError(wm_context, "Unable to initialize Context.setSSLCertificates");
        return 0;
    }

    mCCsetSecureProxy = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cCContext, "setSecureProxy",
							"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V");
    if (mCCsetSecureProxy == 0) {
        setError(wm_context, "Unable to initialize Context.setSecureProxy");
        return 0;
    }

    mCCinvokeSync = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cCContext, "invoke",
		"(Ljava/lang/String;Ljava/lang/String;Lcom/wm/util/Values;)Lcom/wm/util/Values;");
    if (mCCinvokeSync == 0) {
        setError(wm_context, "Unable to initialize Context.invoke");
        return 0;
    }

    mCCinvokeAsync = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cCContext, "invokeThreaded",
	  "(Ljava/lang/String;Ljava/lang/String;Lcom/wm/util/Values;)Lcom/wm/app/b2b/client/InvokeThread;");
    if (mCCinvokeAsync == 0) {
        setError(wm_context, "Unable to initialize Context.invokeThreaded");
        return 0;
    }

	/* initialize method ids for TContext */
    mTCinit = (*wm_jvm_env)->GetStaticMethodID(wm_jvm_env, cTContext, "init", "()V");
    if (mTCinit == 0) {
        setError(wm_context, "Unable to initialize TContext.init");
        return 0;
    }

    mTCinitWithArgs = (*wm_jvm_env)->GetStaticMethodID(wm_jvm_env, cTContext, "init",
		"(Ljava/lang/String;Ljava/lang/String;)V");
    if (mTCinitWithArgs == 0) {
        setError(wm_context, "Unable to initialize TContext.initWithArgs");
        return 0;
    }

    mTCshutdown = (*wm_jvm_env)->GetStaticMethodID(wm_jvm_env, cTContext, "shutdown",
		"(Z)V");
    if (mTCshutdown == 0) {
        setError(wm_context, "Unable to initialize TContext.shutdown");
        return 0;
    }

    mTCreset = (*wm_jvm_env)->GetStaticMethodID(wm_jvm_env, cTContext, "resetJobMgr",
		"()V");
    if (mTCreset == 0) {
        setError(wm_context, "Unable to initialize TContext.resetJobMgr");
        return 0;
    }

    mTCresetWithArgs = (*wm_jvm_env)->GetStaticMethodID(wm_jvm_env, cTContext,
		"resetJobMgr", "(Ljava/lang/String;Ljava/lang/String;)V");
    if (mTCresetWithArgs == 0) {
        setError(wm_context, "Unable to initialize TContext.resetJobMgrWithArgs");
        return 0;
    }

    mTCresetLog = (*wm_jvm_env)->GetStaticMethodID(wm_jvm_env, cTContext, "resetLogFile",
		"()V");
    if (mTCresetLog == 0) {
        setError(wm_context, "Unable to initialize TContext.resetLogFile");
        return 0;
    }

    mTCresetLogWithArgs = (*wm_jvm_env)->GetStaticMethodID(wm_jvm_env, cTContext,
		"resetLogFile", "(Ljava/lang/String;)V");
    if (mTCresetLogWithArgs == 0) {
        setError(wm_context, "Unable to initialize TContext.resetLogFileWithArgs");
        return 0;
    }

    mTC = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "<init>", "()V");
    if (mTC == 0) {
        setError(wm_context, "Unable to initialize TContext.");
        return 0;
    }

    mTCconnectUserPass = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "connect",
		"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V");
    if (mTCconnectUserPass == 0) {
        setError(wm_context, "Unable to initialize TContext.connectUserPass");
        return 0;
    }

    mTCconnectCertBytes = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "connect",
		"(Ljava/lang/String;[B)V");
    if (mTCconnectCertBytes == 0) {
        setError(wm_context, "Unable to initialize TContext.connectCertBytes");
        return 0;
    }

    mTCconnectCertString = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "connect",
		"(Ljava/lang/String;Ljava/lang/String;)V");
    if (mTCconnectCertString == 0) {
        setError(wm_context, "Unable to initialize TContext.connectCertString");
        return 0;
    }

    mTCdisconnect = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "disconnect",
		"()V");
    if (mTCdisconnect == 0) {
        setError(wm_context, "Unable to initialize TContext.disconnect");
        return 0;
    }

    mTCstartTx = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "startTx",
		"()Ljava/lang/String;");
    if (mTCstartTx == 0) {
        setError(wm_context, "Unable to initialize TContext.startTx");
        return 0;
    }

    mTCstartTxTtl = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "startTx",
		"(J)Ljava/lang/String;");
    if (mTCstartTxTtl == 0) {
        setError(wm_context, "Unable to initialize TContext.startTxTtl");
        return 0;
    }

    mTCstartTxRetries = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "startTx",
		"(JI)Ljava/lang/String;");
    if (mTCstartTxRetries == 0) {
        setError(wm_context, "Unable to initialize TContext.startTxRetries");
        return 0;
    }

    mTCrestartTx = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "restartTx",
		"(Ljava/lang/String;)V");
    if (mTCrestartTx == 0) {
        setError(wm_context, "Unable to initialize TContext.restartTx");
        return 0;
    }

    mTCendTx = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "endTx",
		"(Ljava/lang/String;)V");
    if (mTCendTx == 0) {
        setError(wm_context, "Unable to initialize TContext.endTx");
        return 0;
    }

    mTCchainTx = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "startTx",
		"(Ljava/lang/String;)Ljava/lang/String;");
    if (mTCchainTx == 0) {
        setError(wm_context, "Unable to initialize TContext.chainTx");
        return 0;
    }

    mTCchainTxTtl = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "startTx",
		"(Ljava/lang/String;J)Ljava/lang/String;");
    if (mTCchainTxTtl == 0) {
        setError(wm_context, "Unable to initialize TContext.chainTxTtl");
        return 0;
    }

    mTCchainTxRetries = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "startTx",
		"(Ljava/lang/String;JI)Ljava/lang/String;");
    if (mTCchainTxRetries == 0) {
        setError(wm_context, "Unable to initialize TContext.chainTxRetries");
        return 0;
    }

    mTCsubmitTx = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "submitTx",
		"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/wm/util/Values;)V");
    if (mTCsubmitTx == 0) {
        setError(wm_context, "Unable to initialize TContext.submitTx");
        return 0;
    }

    mTCretrieveTx = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "retrieveTx",
		"(Ljava/lang/String;Z)Lcom/wm/util/Values;");
    if (mTCretrieveTx == 0) {
        setError(wm_context, "Unable to initialize TContext.retrieveTx");
        return 0;
    }

    mTCinvokeTx = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "invokeTx",
		"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/wm/util/Values;)Lcom/wm/util/Values;");
    if (mTCinvokeTx == 0) {
        setError(wm_context, "Unable to initialize TContext.invokeTx");
        return 0;
    }

    mTCgetTxIds = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "getTxIds",
		"()Ljava/util/Enumeration;");
    if (mTCgetTxIds == 0) {
        setError(wm_context, "Unable to initialize TContext.getTxIds");
        return 0;
    }

    mTCgetTxStatus = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "getTxStatus",
		"(Ljava/lang/String;)Ljava/lang/String;");
    if (mTCgetTxStatus == 0) {
        setError(wm_context, "Unable to initialize TContext.getTxStatus");
        return 0;
    }

    mTCgetTxStatusVal = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "getTxStatusVal",
		"(Ljava/lang/String;)I");
    if (mTCgetTxStatusVal == 0) {
        setError(wm_context, "Unable to initialize TContext.getTxStatusVal");
        return 0;
    }

	mTCgetTxRmtId = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "getRemoteTxId",
		"(Ljava/lang/String;)Ljava/lang/String;");
    if (mTCgetTxRmtId == 0) {
        setError(wm_context, "Unable to initialize TContext.getRemoteTxId");
        return 0;
    }

	mTCgetTxChainId = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cTContext, "getChainedTxId",
		"(Ljava/lang/String;)Ljava/lang/String;");
    if (mTCgetTxChainId == 0) {
        setError(wm_context, "Unable to initialize TContext.getChainedTxId");
        return 0;
    }

	/* initialize method ids for InvokeThread */
	mACgetData = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cAContext, "getData",
					"()Lcom/wm/util/Values;");
	if (mACgetData == 0) {
		setError(wm_context, "Unable to initialize InvokeThread.getData");
		return 0;
	}

	/* enum methods */
	mEChasMoreElements = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cEContext,
					"hasMoreElements", "()Z");
	if (mEChasMoreElements == 0) {
		setError(wm_context, "Unable to initialize Enumeration.hasMoreElements");
		return 0;
	}

	mECnextElement = (*wm_jvm_env)->GetMethodID(wm_jvm_env, cEContext, "nextElement",
					"()Ljava/lang/Object;");
	if (mECnextElement == 0) {
		setError(wm_context, "Unable to initialize Enumeration.nextElement");
		return 0;
	}

	return 1;

}

void
shutdownWmClient()
{
	/* release global context */
	freeWmContext(&wm_context);

	/* cleanup globals */
	free(wm_jvm_args);
	free(wm_thr_args);

	/* ignore errors - pro forma in 1.1 or 1.2 */
	(*wm_jvm)->DestroyJavaVM(wm_jvm);
}

jint
initWmTContext()
{
	JNIEnv *env = wm_jvm_env;

	(*env)->CallStaticVoidMethod(env, cTContext, mTCinit);
	return clearException(wm_context);

}

jint
initWmTContextWithArgs(
	const char *jobdir,
	const char *logpath)
{
	JNIEnv *env = wm_jvm_env;
	jstring sJobdir, sLogpath;

    sJobdir = (*env)->NewStringUTF(env, jobdir);
	sLogpath = (*env)->NewStringUTF(env, logpath);
    if (sJobdir == 0 || sLogpath == 0) {
		if (sJobdir != 0) {
			(*env)->DeleteLocalRef(env, sJobdir);
		}
		if (sLogpath != 0) {
			(*env)->DeleteLocalRef(env, sLogpath);
		}
        setError(wm_context, "Out of memory on initWmTContextWithArgs");
        return 0;
    }

	(*env)->CallStaticVoidMethod(env, cTContext, mTCinitWithArgs,
		sJobdir, sLogpath);

	(*env)->DeleteLocalRef(env, sJobdir);
	(*env)->DeleteLocalRef(env, sLogpath);

	return clearException(wm_context);
}

jint
shutdownWmTContext(
	jint force)
{
	JNIEnv *env = wm_jvm_env;

	(*env)->CallStaticVoidMethod(env, cTContext, mTCshutdown, force);
	return clearException(wm_context);
}

jint
resetWmTContext()
{
	JNIEnv *env = wm_jvm_env;

	(*env)->CallStaticVoidMethod(env, cTContext, mTCreset);
	return clearException(wm_context);
}

jint
resetWmTContextWithArgs(
	const char *jobdir,
	const char *logpath)
{
	JNIEnv *env = wm_jvm_env;
	jstring sJobdir, sLogpath;

    sJobdir = (*env)->NewStringUTF(env, jobdir);
	sLogpath = (*env)->NewStringUTF(env, logpath);
    if (sJobdir == 0 || sLogpath == 0) {
        setError(wm_context, "Out of memory on resetWmTContextWithArgs");
        return 0;
    }

	(*env)->CallStaticVoidMethod(env, cTContext, mTCresetWithArgs,
		sJobdir, sLogpath);

	(*env)->DeleteLocalRef(env, sJobdir);
	(*env)->DeleteLocalRef(env, sLogpath);

	return clearException(wm_context);
}

jint
resetWmTContextLog()
{
	JNIEnv *env = wm_jvm_env;

	(*env)->CallStaticVoidMethod(env, cTContext, mTCresetLog);
	return clearException(wm_context);
}

jint
resetWmTContextLogWithArgs(
	const char *logpath)
{
	JNIEnv *env = wm_jvm_env;
	jstring sLogpath;

	sLogpath = (*env)->NewStringUTF(env, logpath);
    if (sLogpath == 0) {
        setError(wm_context, "Out of memory on resetWmTContextLogWithArgs");
        return 0;
    }

	(*env)->CallStaticVoidMethod(env, cTContext, mTCresetLogWithArgs,
		sLogpath);

	(*env)->DeleteLocalRef(env, sLogpath);
	return clearException(wm_context);
}

WmContext *
newWmClientContext()
{
	JNIEnv *env = attachThread();
	jobject ref;
	WmContext *cc;

	/* construct object - default constructor only */
	ref = (*env)->NewObject(env, cCContext, mCC);
	if (ref == 0) {
		setError(wm_context, "Unable to construct Context object");
		return 0;
	}

	cc = makeContext(env, WM_SYNC_CONTEXT, ref);
	(*env)->DeleteLocalRef(env, ref);
	return cc;
}

WmContext *
newWmTContext()
{
	JNIEnv *env = attachThread();
	jobject ref;
	WmContext * wmContext = NULL;

	/* construct object - default constructor only */
	ref = (*env)->NewObject(env, cTContext, mTC);
	if (ref == 0) {
		setError(wm_context, "Unable to construct TContext object");
		return 0;
	}

	wmContext = makeContext(env, WM_TRAN_CONTEXT, ref);

	(*env)->DeleteLocalRef(env, ref);

	return wmContext;
}

WmContext *
cloneWmContext(WmContext *cc)
{
	JNIEnv *env;

	if (!isClientContext(cc)) {
		setError(cc, "Unable to clone non-Client Context");
		return 0;
	}

	env = attachThread();

	return makeContext(env, cc->type, cc->ref);
	/* return makeContext(cc->env, cc->type, cc->ref); */

}

jint
setCcRPCType(
	WmContext *cc,
	jint 	type)
{
	if (!isClientContext(cc))
		return 0;

	(*cc->env)->CallVoidMethod(cc->env, cc->ref, mCCsetRPCType, type);
    return clearException(cc);

}

jint
setCcSecure(
	WmContext *cc,
	jint 	flag)
{
	if (!isClientContext(cc))
		return 0;

	(*cc->env)->CallVoidMethod(cc->env, cc->ref, mCCsetSecure, flag);
    return clearException(cc);

}

jint
setCcProxy(
	WmContext 		*cc,
	const char 		*host,
	const char		*user,
	const char		*pass)
{
    jstring sHost, sUser, sPass;

	if (!isClientContext(cc))
		return 0;

    sHost = (*cc->env)->NewStringUTF(cc->env, host);
    sUser = (*cc->env)->NewStringUTF(cc->env, user);
	sPass = (*cc->env)->NewStringUTF(cc->env, pass);
    if (sHost == 0 || sUser == 0 || sPass == 0) {
        setError(cc, "Out of memory on setCcProxy");
        return 0;
    }

	(*cc->env)->CallVoidMethod(cc->env, cc->ref, mCCsetProxy, sHost, sUser, sPass);

	(*cc->env)->DeleteLocalRef(cc->env, sHost);
	(*cc->env)->DeleteLocalRef(cc->env, sUser);
	(*cc->env)->DeleteLocalRef(cc->env, sPass);

    return clearException(cc);

}

jint
setCcSecureProxy(
	WmContext 		*cc,
	const char 		*host,
	const char		*user,
	const char		*pass)
{
    jstring sHost, sUser, sPass;

	if (!isClientContext(cc))
		return 0;

    sHost = (*cc->env)->NewStringUTF(cc->env, host);
    sUser = (*cc->env)->NewStringUTF(cc->env, user);
	sPass = (*cc->env)->NewStringUTF(cc->env, pass);
    if (sHost == 0 || sUser == 0 || sPass == 0) {
        setError(cc, "Out of memory on setCcSecureProxy");
        return 0;
    }

	(*cc->env)->CallVoidMethod(cc->env, cc->ref, mCCsetSecureProxy, sHost, sUser, sPass);

	(*cc->env)->DeleteLocalRef(cc->env, sHost);
	(*cc->env)->DeleteLocalRef(cc->env, sUser);
	(*cc->env)->DeleteLocalRef(cc->env, sPass);
    return clearException(cc);

}

jint
setScFixedUri(
	WmContext 		*cc,
	const char *	uri)
{
    jstring sUri;

	if (contextMismatch(cc, WM_SYNC_CONTEXT))
		return 0;

	sUri = (*cc->env)->NewStringUTF(cc->env, uri);
    if (sUri == 0) {
        setError(cc, "Out of memory on setCcFixedUri");
        return 0;
    }

	(*cc->env)->CallVoidMethod(cc->env, cc->ref, mCCsetFixedUri, sUri);

	(*cc->env)->DeleteLocalRef(cc->env, sUri);

    return clearException(cc);

}

jint
setCcSSLCertificates(
	WmContext 		*cc,
	const char 		*cert,
	const char		*privkey,
	const char		*ca)
{
    jstring sCert, sPrivkey, sCa;

	if (!isClientContext(cc))
		return 0;

    sCert = (*cc->env)->NewStringUTF(cc->env, cert);
    sPrivkey = (*cc->env)->NewStringUTF(cc->env, privkey);
	sCa = (*cc->env)->NewStringUTF(cc->env, ca);
    if (sCert == 0 || sPrivkey == 0 || sCa == 0) {
        setError(cc, "Out of memory on setCcSSLCertificates");
        return 0;
    }

	(*cc->env)->CallVoidMethod(cc->env, cc->ref, mCCsetCertificates, sCert, sPrivkey, sCa);

	(*cc->env)->DeleteLocalRef(cc->env, sCert);
	(*cc->env)->DeleteLocalRef(cc->env, sPrivkey);
	(*cc->env)->DeleteLocalRef(cc->env, sCa);

    return clearException(cc);

}

jint
isCcSecure(
	WmContext *cc)
{
	jint res;
	jboolean flag;

	if (!isClientContext(cc))
		return 0;

	flag = (*cc->env)->CallBooleanMethod(cc->env, cc->ref, mCCisSecure);
    res = clearException(cc);
	if (res >= 0)
		res = (jint)flag;

	return res;
}

jint
isCcConnected(
	WmContext *cc)
{
	jint res;
	jboolean flag;

	if (!isClientContext(cc))
		return 0;

	flag = (*cc->env)->CallBooleanMethod(cc->env, cc->ref, mCCisConnected);
    res = clearException(cc);
	if (res >= 0)
		res = (jint)flag;

	return res;
}

jint
connectCcUserPass(
	WmContext 		*cc,
	const char 		*host,
	const char		*user,
	const char		*pass)
{
    jstring sHost, sUser, sPass;
	//jmethodID mid;

	if (!isClientContext(cc))
		return 0;

    sHost = (*cc->env)->NewStringUTF(cc->env, host);
    sUser = (*cc->env)->NewStringUTF(cc->env, user);
	sPass = (*cc->env)->NewStringUTF(cc->env, pass);
    if (sHost == 0 || sUser == 0 || sPass == 0) {
        setError(cc, "Out of memory on connectCcUserPass");
        return 0;
    }

	if (cc->type == WM_TRAN_CONTEXT)
		(*cc->env)->CallVoidMethod(cc->env, cc->ref, mTCconnectUserPass, sHost, sUser, sPass);
	else
		(*cc->env)->CallVoidMethod(cc->env, cc->ref, mCCconnectUserPass, sHost, sUser, sPass);

	(*cc->env)->DeleteLocalRef(cc->env, sHost);
	(*cc->env)->DeleteLocalRef(cc->env, sUser);
	(*cc->env)->DeleteLocalRef(cc->env, sPass);

    return clearException(cc);

}

jint
connectCcCert(
	WmContext 		*cc,
	const char 		*host,
	const char		*cert)
{
	jstring sHost, sCert;
	jmethodID mid;

	if (!isClientContext(cc))
		return 0;

	sHost = (*cc->env)->NewStringUTF(cc->env, host);
	sCert = (*cc->env)->NewStringUTF(cc->env, cert);
    if (sCert == 0 || sHost == 0) {
			if(sCert != 0)
				(*cc->env)->DeleteLocalRef(cc->env, sCert);
			if(sHost != 0)
				(*cc->env)->DeleteLocalRef(cc->env, sHost);
        setError(cc, "Out of memory on connectCcCert");
        return 0;
    }

	if (cc->type == WM_TRAN_CONTEXT)
		mid = mTCconnectCertString;
	else
		mid = mCCconnectCertString;

	(*cc->env)->CallVoidMethod(cc->env, cc->ref, mid, sHost, sCert);

	(*cc->env)->DeleteLocalRef(cc->env, sHost);
	(*cc->env)->DeleteLocalRef(cc->env, sCert);

    return clearException(cc);

}

jint
connectCcCertPath(
	WmContext 		*cc,
	const char 		*host,
	const char		*cert_path)
{
	jint res;
	jstring sCertpath, sHost;
	jobject bytes;
	jmethodID mid;

	if (!isClientContext(cc))
		return 0;

	sHost = (*cc->env)->NewStringUTF(cc->env, host);
	sCertpath = (*cc->env)->NewStringUTF(cc->env, cert_path);
    if (sCertpath == 0 || sHost == 0) {
			if(sCertpath != 0)
				(*cc->env)->DeleteLocalRef(cc->env, sCertpath);
			if(sHost != 0)
				(*cc->env)->DeleteLocalRef(cc->env, sHost);
        setError(cc, "Out of memory on connectCcCertPath");
        return 0;
    }

	bytes = (*cc->env)->CallObjectMethod(cc->env, cc->ref, mCCgetCert, sCertpath);
    res = clearException(cc);
	if (res == 0) {
		(*cc->env)->DeleteLocalRef(cc->env, sCertpath);
		(*cc->env)->DeleteLocalRef(cc->env, sHost);
		return res;
	}

	if (cc->type == WM_TRAN_CONTEXT)
		mid = mTCconnectCertBytes;
	else
		mid = mCCconnectCertBytes;

	(*cc->env)->CallVoidMethod(cc->env, cc->ref, mid, sHost, bytes);

	(*cc->env)->DeleteLocalRef(cc->env, sCertpath);
	(*cc->env)->DeleteLocalRef(cc->env, sHost);
	(*cc->env)->DeleteLocalRef(cc->env, bytes);

    return clearException(cc);

}

jint
disconnectCc(
	WmContext *cc)
{
	//jmethodID mid;

	if (!isClientContext(cc))
		return 0;

	if (cc->type == WM_TRAN_CONTEXT)
		//mid = mTCdisconnect;
		(*cc->env)->CallVoidMethod(cc->env, cc->ref, mTCdisconnect);
	else
		//mid = mCCdisconnect;
		(*cc->env)->CallVoidMethod(cc->env, cc->ref, mCCdisconnect);

	//(*cc->env)->CallVoidMethod(cc->env, cc->ref, mid);
    return clearException(cc);

}

WmRecord *
invokeWmSync(
	WmContext 			*cc,
	const char			*ifc,
	const char			*svc,
	WmRecord			*in)
{
	jint res;
    jstring sIfc, sSvc;
	jobject values;
	WmRecord *out;

	if (contextMismatch(cc, WM_SYNC_CONTEXT))
		return 0;

    sIfc = (*cc->env)->NewStringUTF(cc->env, ifc);
    sSvc = (*cc->env)->NewStringUTF(cc->env, svc);
    if (sIfc == 0 || sSvc == 0) {
		if(sIfc != 0)
			(*cc->env)->DeleteLocalRef(cc->env, sIfc);
		if(sSvc != 0)
			(*cc->env)->DeleteLocalRef(cc->env, sSvc);
        setError(cc, "Out of memory on invokeCcSync");
		return 0;
    }
	values = (*cc->env)->CallObjectMethod(cc->env, cc->ref, mCCinvokeSync, sIfc, sSvc,
		in->ref);

	(*cc->env)->DeleteLocalRef(cc->env, sIfc);
	(*cc->env)->DeleteLocalRef(cc->env, sSvc);

    res = clearException(cc);

	if (res == 0)
		return 0;
	out = makeWmRec(cc, values, RECORD, 0, 0);
	if (out == 0)
		setError(cc, "Out of memory on invokeCcSync");

	return out;
}

WmContext *
invokeWmAsync(
	WmContext 			*cc,
	const char			*ifc,
	const char			*svc,
	WmRecord			*in)
{
	jint res;
    jstring sIfc, sSvc;
	jobject invokeThread;
	WmContext *wmContext = NULL;

	if (contextMismatch(cc, WM_SYNC_CONTEXT))
		return 0;

    sIfc = (*cc->env)->NewStringUTF(cc->env, ifc);
    sSvc = (*cc->env)->NewStringUTF(cc->env, svc);
    if (sIfc == 0 || sSvc == 0) {
		if(sIfc != 0)
			(*cc->env)->DeleteLocalRef(cc->env, sIfc);
		if(sSvc != 0)
			(*cc->env)->DeleteLocalRef(cc->env, sSvc);
        setError(cc, "Out of memory on invokeCcAsync");
		return 0;
    }

	invokeThread = (*cc->env)->CallObjectMethod(cc->env, cc->ref, mCCinvokeAsync, sIfc,
		sSvc, in->ref);
    res = clearException(cc);
	if (res == 0) {
		(*cc->env)->DeleteLocalRef(cc->env, sSvc);
		(*cc->env)->DeleteLocalRef(cc->env, sIfc);
		return 0;
	}


	wmContext = makeContext(cc->env, WM_ASYNC_CONTEXT, invokeThread);

	(*cc->env)->DeleteLocalRef(cc->env, invokeThread);

	(*cc->env)->DeleteLocalRef(cc->env, sSvc);
	(*cc->env)->DeleteLocalRef(cc->env, sIfc);

	return wmContext;
}

WmRecord *
getWmAsyncData(
	WmContext 		*ac)
{
	jint res;
	jobject values;
	WmRecord *out;

	if (contextMismatch(ac, WM_ASYNC_CONTEXT))
		return 0;

	values = (*ac->env)->CallObjectMethod(ac->env, ac->ref, mACgetData);
    res = clearException(ac);
	if (res == 0)
		return 0;

	out = makeWmRec(ac, values, RECORD, 0, 0);
	if (out == 0)
		setError(ac, "Out of memory on getAcData");


	return out;
}

WmTid
startWmTx(WmContext *tc)
{
	WmTid tid;
	WmTid gTid;
	jint res;

	if (contextMismatch(tc, WM_TRAN_CONTEXT))
		return 0;

	tid = (*tc->env)->CallObjectMethod(tc->env, tc->ref, mTCstartTx);
	res = clearException(tc);
	if (res == 0)
		return 0;

 	/* get global ref to tid */
    gTid = (*tc->env)->NewGlobalRef(tc->env, tid);

	(*tc->env)->DeleteLocalRef(tc->env, tid);

    if (gTid == 0) {
        setError(tc, "Unable to get global reference to tid on start");
        return 0;
    }

	return gTid;
}

WmTid
startWmTxTtl(
	WmContext *tc,
	jlong ttl)
{
	WmTid tid;
	WmTid gTid;
	jint res;

	if (contextMismatch(tc, WM_TRAN_CONTEXT))
		return 0;

	tid = (*tc->env)->CallObjectMethod(tc->env, tc->ref, mTCstartTxTtl, ttl);
	res = clearException(tc);
	if (res == 0)
		return 0;

 	/* get global ref to tid */
    gTid = (*tc->env)->NewGlobalRef(tc->env, tid);

	(*tc->env)->DeleteLocalRef(tc->env, tid);

    if (gTid == 0) {
        setError(tc, "Unable to get global reference to tid on start/ttl");
        return 0;
    }

	return gTid;
}

WmTid
startWmTxRetries(
	WmContext *tc,
	jlong ttl,
	jlong retries)
{
	WmTid tid;
	WmTid gTid;
	jint res;

	if (contextMismatch(tc, WM_TRAN_CONTEXT))
		return 0;

	tid = (*tc->env)->CallObjectMethod(tc->env, tc->ref, mTCstartTxRetries, ttl, retries);
	res = clearException(tc);
	if (res == 0)
		return 0;

 	/* get global ref to tid */
    gTid = (*tc->env)->NewGlobalRef(tc->env, tid);

	 (*tc->env)->DeleteLocalRef(tc->env, tid);
    if (gTid == 0) {
        setError(tc, "Unable to get global reference to tid on start/retries");
        return 0;
    }

	return gTid;

}

jint
restartWmTx(
	WmTContext *tc,
	WmTid tid)
{
	if (contextMismatch(tc, WM_TRAN_CONTEXT))
		return 0;

	(*tc->env)->CallVoidMethod(tc->env, tc->ref, mTCrestartTx, tid);
	return clearException(tc);

}

jint
endWmTx(
	WmContext *tc,
	WmTid tid)
{
	if (contextMismatch(tc, WM_TRAN_CONTEXT))
		return 0;

	(*tc->env)->CallVoidMethod(tc->env, tc->ref, mTCendTx, tid);
	return clearException(tc);

}

WmTid
chainWmTx(
	WmContext *tc,
	WmTid tid)
{
	WmTid ftid;
	WmTid gTid;
	jint res;

	if (contextMismatch(tc, WM_TRAN_CONTEXT))
		return 0;

	ftid = (*tc->env)->CallObjectMethod(tc->env, tc->ref, mTCchainTx, tid);
	res = clearException(tc);
	if (res == 0)
		return 0;

 	/* get global ref to tid */
    gTid = (*tc->env)->NewGlobalRef(tc->env, ftid);

	(*tc->env)->DeleteLocalRef(tc->env, ftid);
    if (gTid == 0) {
        setError(tc, "Unable to get global reference to tid on chain");
        return 0;
    }

	return gTid;
}

WmTid
chainWmTxTtl(
	WmContext *tc,
	WmTid tid,
	jlong ttl)
{
	WmTid ftid;
	WmTid gTid;
	jint res;

	if (contextMismatch(tc, WM_TRAN_CONTEXT))
		return 0;

	ftid = (*tc->env)->CallObjectMethod(tc->env, tc->ref, mTCchainTxTtl, tid, ttl);
	res = clearException(tc);
	if (res == 0)
		return 0;

 	/* get global ref to tid */
    gTid = (*tc->env)->NewGlobalRef(tc->env, ftid);

	(*tc->env)->DeleteLocalRef(tc->env, ftid);

    if (gTid == 0) {
        setError(tc, "Unable to get global reference to tid on chain/ttl");
        return 0;
    }

	return gTid;
}

WmTid
chainWmTxRetries(
	WmContext *tc,
	WmTid tid,
	jlong ttl,
	jlong retries)
{
	WmTid ftid;
	WmTid gTid;
	jint res;

	if (contextMismatch(tc, WM_TRAN_CONTEXT))
		return 0;

	ftid = (*tc->env)->CallObjectMethod(tc->env, tc->ref, mTCchainTxRetries, tid,
		ttl, retries);
	res = clearException(tc);
	if (res == 0)
		return 0;

 	/* get global ref to tid */
    gTid = (*tc->env)->NewGlobalRef(tc->env, ftid);

	(*tc->env)->DeleteLocalRef(tc->env, ftid);
    if (gTid == 0) {
        setError(tc, "Unable to get global reference to tid on chain/retries");
        return 0;
    }

	return gTid;

}

WmRecord *
invokeWmTx(
	WmContext *tc,
	WmTid tid,
	const char *ifc,
	const char *svc,
	WmRecord *in)
{
	jint res;
	jstring sIfc, sSvc;
	jobject values;
	WmRecord *out;

	if (contextMismatch(tc, WM_TRAN_CONTEXT))
		return 0;

    sIfc = (*tc->env)->NewStringUTF(tc->env, ifc);
    sSvc = (*tc->env)->NewStringUTF(tc->env, svc);
    if (sIfc == 0 || sSvc == 0) {
		if(sIfc != 0)
			(*tc->env)->DeleteLocalRef(tc->env, sIfc);
		if(sSvc != 0)
			(*tc->env)->DeleteLocalRef(tc->env, sSvc);
        setError(tc, "Out of memory on invokeWmTx");
		return 0;
    }

	values = (*tc->env)->CallObjectMethod(tc->env, tc->ref, mTCinvokeTx, tid,
		sIfc, sSvc, in->ref);
	res = clearException(tc);

	if (res == 0) {
		(*tc->env)->DeleteLocalRef(tc->env, sIfc);
		(*tc->env)->DeleteLocalRef(tc->env, sSvc);
		return 0;
	}

	out = makeWmRec(tc, values, RECORD, 0, 0);
	if (out == 0)
		setError(tc, "Out of memory on invokeWmTx");

	(*tc->env)->DeleteLocalRef(tc->env, sIfc);
	(*tc->env)->DeleteLocalRef(tc->env, sSvc);

	return out;

}

jint
submitWmTx(
	WmContext *tc,
	WmTid tid,
	const char *ifc,
	const char *svc,
	WmRecord *in)
{
	jstring sIfc, sSvc;

	if (contextMismatch(tc, WM_TRAN_CONTEXT))
		return 0;

    sIfc = (*tc->env)->NewStringUTF(tc->env, ifc);
    sSvc = (*tc->env)->NewStringUTF(tc->env, svc);
    if (sIfc == 0 || sSvc == 0) {
		if(sIfc != 0)
			(*tc->env)->DeleteLocalRef(tc->env, sIfc);
		if(sSvc != 0)
			(*tc->env)->DeleteLocalRef(tc->env, sSvc);
        setError(tc, "Out of memory on submitWmTx");
		return 0;
    }

	(*tc->env)->CallVoidMethod(tc->env, tc->ref, mTCsubmitTx, tid,
		sIfc, sSvc, in->ref);

	(*tc->env)->DeleteLocalRef(tc->env, sIfc);
	(*tc->env)->DeleteLocalRef(tc->env, sSvc);

	return clearException(tc);

}

WmRecord *
retrieveWmTx(
	WmContext *tc,
	WmTid tid,
	jint block)
{
	jint res;
	jobject values;
	WmRecord *out;

	if (contextMismatch(tc, WM_TRAN_CONTEXT))
		return 0;

	values = (*tc->env)->CallObjectMethod(tc->env, tc->ref, mTCretrieveTx, tid, block);
	res = clearException(tc);
	if (res == 0)
		return 0;

	out = makeWmRec(tc, values, RECORD, 0, 0);
	if (out == 0)
		setError(tc, "Out of memory on retrieveWmTx");


	return out;

}

WmContext *
getWmTxIds(
	WmContext *tc)
{
	jint res;
	jobject list;
	WmContext *wmContext = NULL;

	if (contextMismatch(tc, WM_TRAN_CONTEXT))
		return 0;

	list = (*tc->env)->CallObjectMethod(tc->env, tc->ref, mTCgetTxIds);
	res = clearException(tc);
	if (res == 0)
		return 0;


	wmContext = makeContext(tc->env, WM_ENUM_CONTEXT, list);

	(*tc->env)->DeleteLocalRef(tc->env, list);

	return wmContext;
}

WmTid
getNextWmTxId(
	WmEContext *ec)
{
	jint res;
	jint more;
	WmTid tid;
	WmTid gTid;

	if (contextMismatch(ec, WM_ENUM_CONTEXT))
		return 0;

	more = (*ec->env)->CallBooleanMethod(ec->env, ec->ref, mEChasMoreElements);
	res = clearException(ec);
	if (res == 0 || !more )
		return 0;

	tid = (*ec->env)->CallObjectMethod(ec->env, ec->ref, mECnextElement);
	res = clearException(ec);
	if (res == 0)
		return 0;

 	/* get global ref to tid */
    gTid = (*ec->env)->NewGlobalRef(ec->env, tid);

	(*ec->env)->DeleteLocalRef(ec->env, tid);

    if (gTid == 0) {
        setError(ec, "Unable to get global reference to tid on getNext");
        return 0;
    }

	return gTid;

}

char *
getWmTxStatus(
	WmContext *tc,
	WmTid tid)
{
	jint res;
	jobject status;
	char *wmName = NULL;

	if (contextMismatch(tc, WM_TRAN_CONTEXT))
		return 0;

	status = (*tc->env)->CallObjectMethod(tc->env, tc->ref, mTCgetTxStatus, tid);
	res = clearException(tc);
	if (res == 0)
		return 0;


	wmName = getWmName(tc, status);

	(*tc->env)->DeleteLocalRef(tc->env, status);

	return wmName;

}

jint
getWmTxStatusVal(
	WmContext *tc,
	WmTid tid)
{
	jint res;
	jint status;

	if (contextMismatch(tc, WM_TRAN_CONTEXT))
		return 0;

	status = (*tc->env)->CallIntMethod(tc->env, tc->ref, mTCgetTxStatusVal, tid);
	res = clearException(tc);
	if (res == 0)
		return -1;

	return status;
}

WmTid
getWmTxRmtId(
	WmContext *tc,
	WmTid tid)
{
	WmTid rtid;
	WmTid gTid;
	jint res;

	if (contextMismatch(tc, WM_TRAN_CONTEXT))
		return 0;

	rtid = (*tc->env)->CallObjectMethod(tc->env, tc->ref, mTCgetTxRmtId, tid);
	res = clearException(tc);
	if (res == 0)
		return 0;

 	/* get global ref to tid */
    gTid = (*tc->env)->NewGlobalRef(tc->env, rtid);

	(*tc->env)->DeleteLocalRef(tc->env, rtid);
    if (gTid == 0) {
        setError(tc, "Unable to get global reference to tid on get remote id");
        return 0;
    }
	return gTid;
}

WmTid
getWmTxChainId(
	WmContext *tc,
	WmTid tid)
{
	WmTid ctid;
	WmTid gTid;
	jint res;

	if (contextMismatch(tc, WM_TRAN_CONTEXT))
		return 0;

	ctid = (*tc->env)->CallObjectMethod(tc->env, tc->ref, mTCgetTxChainId, tid);
	res = clearException(tc);
	if (res == 0)
		return 0;

 	/* get global ref to tid */
    gTid = (*tc->env)->NewGlobalRef(tc->env, ctid);

	(*tc->env)->DeleteLocalRef(tc->env, ctid);

    if (gTid == 0) {
        setError(tc, "Unable to get global reference to tid on get chain id");
        return 0;
    }

	return gTid;
}

/* ----------- Util methods ------------------ */

jint
isClientContext(
	WmContext *cc)
{
	if (cc->type == WM_SYNC_CONTEXT || cc->type == WM_TRAN_CONTEXT)
		return 1;

	return 0;
}

void
freeWmContext(
    WmContext   **ccp)
{
	WmContext *cc;

    if (ccp == 0 || *ccp == 0) return;

	cc = *ccp;

	clearWmContext(cc);

	/* clear global reference to referenced object */
	if (cc->ref != 0)
		(*cc->env)->DeleteGlobalRef(cc->env, cc->ref);

	detachThread(cc);

	/* release and reset */
    free(*ccp);
    *ccp = 0;
}

JNIEnv *
attachThread()
{
	jint	res;
	JNIEnv	*env;
#ifdef JAVA2
	res = (*wm_jvm)->AttachCurrentThread(wm_jvm, (void **)&env, wm_thr_args);
#else
	res = (*wm_jvm)->AttachCurrentThread(wm_jvm, &env, wm_thr_args);
#endif
	if (res < 0) {
		fprintf(stderr, "Unable to attach thread to jvm\n");
		return 0;
	}
	/*(*env)->DeleteLocalRef(env, (jobject)res);*/
	return env;
}

void
detachThread(
	WmContext	*cc)
{
	jint res;

	/* don't detach in main thread */
	if (cc->env && (cc->env != wm_jvm_env)) {
		res = (*wm_jvm)->DetachCurrentThread(wm_jvm);
		if (res < 0)
			fprintf(stderr, "Detach failed\n");
		/* (*cc->env)->DeleteLocalRef(cc->env, (jobject)res); */
	}

	cc->env = 0;
}
