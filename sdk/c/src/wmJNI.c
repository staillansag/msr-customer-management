/*
 *  wmJNI.c:    Library routines for C/C++ IMs and clients.
 *
 * Copyright (C) 1996-1999, webMethods, Inc. All Rights Reserved.
 */

#include "wmJNI.h"
#include "wmUtil.h"
#include "wmJNIc.h"

/*
 *  Prefix Naming conventions for all jni variables:
 *      c=jclass o=jobject m=jmethodID s=jstring
 */


/* -- Forward decls for private functions -- */
void				extractErrInfo(WmContext *con, jthrowable exc);

/* ------------ Globals ------------------- */

static jint         initialized=0;

static jclass       cValues=0;
static jobject      ogValues=0;   /* used for new object array default entries */

static jmethodID    mConstructor=0;
static jmethodID    mPut=0;
static jmethodID    mGet=0;

static jclass       cString=0;
static jstring      ogString=0;   /* used for new string array default entries */
static jclass       cStringArray=0;

static jclass       cService=0;   /* optional - server only */
static jmethodID    mInvoke=0;
static jmethodID	mThreadInvoke=0;
static jmethodID	mThrowErrorMsg=0;
static jmethodID	mThrowError=0;
static jclass		cServiceThread=0;
static jmethodID	mSACgetData=0;
static jclass		cSvrAPI=0;		/* used for ServerAPI log error */
static jmethodID	mlogError=0;

										/* exception classes */
static jclass		cAccessExc=0;		/* access */
static jclass		cDeliveryExc=0;		/* Tx delivery */
static jclass		cInvReqExc=0;		/* invalid request */
static jclass		cTXExc=0;			/* Tx job */
static jclass		cSvcExc=0;			/* Service - superclass! */

static jmethodID	mHeuristic=0;		/* TxException - heuristic failure */

static jclass		cThrowable=0;				/* Throwable class - super of exceptions */
static jmethodID	mGetMsg=0;					/* get throwable message string */
static jmethodID	mThrowableConstructor=0;	/* get throwable constructor */

static jint noVarWarn=0; /* Suppress missing variable warnings */
/******************* UTILITY METHODS *****************************/


/* ------------ Setup ------------- */

jint
WmRecInit(
	WmContext *con)
{
	return WmInit(con, 0);
}

jint
WmInit(
    WmContext   *con,
    jobject     oInValues)
{
    jobject oTmp;
    JNIEnv *env = con->env;

	con->type = 0;

	/* owned by wmJNI */
	con->errType = WM_NO_ERROR;
	con->errMsg = 0;
	con->err = 0;

	/* owned by wmJNIc */
	con->ref = 0;

    if (initialized) return 1;

	/* setup Values */


	/* Reading watt property for suppressing missing variables warnings */
	oTmp = (*env)->FindClass(env, "java/lang/System");
	if (oTmp != 0) {
		jclass cls = (*env)->NewGlobalRef(env, oTmp);

		if (cls != 0) {
			jmethodID mid = (*env)->GetStaticMethodID(env, cls, "getProperty", "(Ljava/lang/String;)Ljava/lang/String;");

			if(mid != 0) {
				jobject propVal = 0;
				const char* tmpPort = NULL;
				const char* portKeyChars = "watt.server.suppresscwarn";
				const char* trueValue = "true";
				jstring portKey = (*env)->NewStringUTF(env, portKeyChars);

				propVal = (*env)->CallStaticObjectMethod(env, cls, mid, portKey);

				if(propVal != 0) {
					tmpPort = (*env)->GetStringUTFChars(env, propVal, 0);
					if(strcmp(trueValue, tmpPort) == 0) {
						noVarWarn = 1;
					}
					(*env)->ReleaseStringUTFChars(env, propVal, tmpPort);
					(*env)->DeleteLocalRef(env, propVal);
				}

				(*env)->DeleteLocalRef(env, portKey);
			}
			(*env)->DeleteGlobalRef(env, (jobject)cls);
		}
		(*env)->DeleteLocalRef(env, oTmp);
	}

    oTmp = (*env)->FindClass(env, "com/wm/util/Values");
    if (oTmp == 0) {
        setError(con, "Unable to initialize Values class reference");
        return 0;
    }
    cValues = (*env)->NewGlobalRef(env, oTmp);

	(*env)->DeleteLocalRef(env, oTmp);

    if (cValues == 0) {
        setError(con, "Unable to get global reference to Values class");
        return 0;
    }

    mConstructor = (*env)->GetMethodID(env, cValues, "<init>",
                "()V");
    if (mConstructor == 0) {
        setError(con, "Unable to initialize Values class constructor");
        return 0;
    }
    mGet = (*env)->GetMethodID(env, cValues, "get",
                "(Ljava/lang/String;)Ljava/lang/Object;");
    if (mGet == 0) {
        setError(con, "Unable to initialize Values class get methodID");
        return 0;
    }
    mPut = (*env)->GetMethodID(env, cValues, "put",
                "(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;");
    if (mPut == 0) {
        setError(con, "Unable to initialize Values class put methodID");
        return 0;
    }

    /* setup global Values object to use as default object array element */
    oTmp = (*env)->NewObject(env, cValues, mConstructor);
    if (oTmp == 0) {
        setError(con, "Unable to construct default Values object");
        return 0;
    }
    ogValues = (*env)->NewGlobalRef(env, oTmp);

	(*env)->DeleteLocalRef(env, oTmp);

    if (ogValues == 0) {
        setError(con, "Unable to get global reference to default Values object");
        return 0;
    }

    /* setup global String object to use as default string array/table element */
    oTmp = (*env)->NewStringUTF(env, "");
    if (oTmp == 0) {
        setError(con, "Unable to construct default String object");
        return 0;
    }
    ogString = (*env)->NewGlobalRef(env, oTmp);

	(*env)->DeleteLocalRef(env, oTmp);

    if (ogString == 0) {
        setError(con, "Unable to get global reference to default String object");
        return 0;
    }

    /* use global String object to create String class reference */
    oTmp = (*env)->GetObjectClass(env, ogString);
    if (oTmp == 0) {
        setError(con, "Unable to initialize String class reference");
        return 0;
    }
    cString = (*env)->NewGlobalRef(env, oTmp);

	 (*env)->DeleteLocalRef(env, oTmp);

    if (cString == 0) {
        setError(con, "Unable to get global reference to String class");
        return 0;
    }

    /* setup global String Array class */
    oTmp = (*env)->FindClass(env, "[Ljava/lang/String;");
    if (oTmp == 0) {
        setError(con, "Unable to initialize String Array class reference");
        return 0;
    }
    cStringArray = (*env)->NewGlobalRef(env, oTmp);

	(*env)->DeleteLocalRef(env, oTmp);

    if (cStringArray == 0) {
        setError(con, "Unable to get global reference to String Array class");
        return 0;
    }

	/* setup exception classes */
    oTmp = (*env)->FindClass(env, "com/wm/app/b2b/client/AccessException");
    if (oTmp == 0) {
        setError(con, "Unable to initialize AccessException reference");
        return 0;
    }
    cAccessExc = (*env)->NewGlobalRef(env, oTmp);

	(*env)->DeleteLocalRef(env, oTmp);

    if (cAccessExc == 0) {
        setError(con, "Unable to get global reference to AccessException class");
        return 0;
    }
    oTmp = (*env)->FindClass(env, "com/wm/app/b2b/client/DeliveryException");
    if (oTmp == 0) {
        setError(con, "Unable to initialize DeliveryException reference");
        return 0;
    }
    cDeliveryExc = (*env)->NewGlobalRef(env, oTmp);

	(*env)->DeleteLocalRef(env, oTmp);

    if (cDeliveryExc == 0) {
        setError(con, "Unable to get global reference to DeliveryException class");
        return 0;
    }
    oTmp = (*env)->FindClass(env, "com/wm/app/b2b/client/InvalidRequestException");
    if (oTmp == 0) {
        setError(con, "Unable to initialize InvalidRequestException reference");
        return 0;
    }
    cInvReqExc = (*env)->NewGlobalRef(env, oTmp);

	(*env)->DeleteLocalRef(env, oTmp);

    if (cInvReqExc == 0) {
        setError(con, "Unable to get global reference to InvalidRequestException class");
        return 0;
    }
    oTmp = (*env)->FindClass(env, "com/wm/app/b2b/client/ServiceException");
    if (oTmp == 0) {
        setError(con, "Unable to initialize ServiceException reference");
        return 0;
    }
    cSvcExc = (*env)->NewGlobalRef(env, oTmp);

	(*env)->DeleteLocalRef(env, oTmp);

    if (cSvcExc == 0) {
        setError(con, "Unable to get global reference to ServiceException class");
        return 0;
    }

	/* get TXException class and related methods */
	oTmp = (*env)->FindClass(env, "com/wm/app/b2b/client/TXException");
    if (oTmp == 0) {
        setError(con, "Unable to initialize TXException reference");
        return 0;
    }
    cTXExc = (*env)->NewGlobalRef(env, oTmp);

	(*env)->DeleteLocalRef(env, oTmp);

    if (cTXExc == 0) {
        setError(con, "Unable to get global reference to TXException class");
        return 0;
    }
    mHeuristic = (*env)->GetMethodID(env, cTXExc, "isHeuristicFailure",
                "()Z");
    if (mHeuristic == 0) {
        setError(con, "Unable to initialize TXException class isHeuristicFailure methodID");
        return 0;
    }

	/* get throwable class and method */
    oTmp = (*env)->FindClass(env, "java/lang/Throwable");
    if (oTmp == 0) {
        setError(con, "Unable to initialize Throwable reference");
        return 0;
    }
    cThrowable = (*env)->NewGlobalRef(env, oTmp);

	(*env)->DeleteLocalRef(env, oTmp);

    if (cThrowable == 0) {
        setError(con, "Unable to get global reference to Throwable class");
        return 0;
    }
    mGetMsg = (*env)->GetMethodID(env, cThrowable, "getMessage",
                "()Ljava/lang/String;");
    if (mGetMsg == 0) {
        setError(con, "Unable to initialize Throwable class getMessage methodID");
        return 0;
    }
	mThrowableConstructor = (*env)->GetMethodID(env, cThrowable, "<init>",
							"(Ljava/lang/String;)V");
    if (mThrowableConstructor == 0) {
        setError(con, "Unable to initialize Throwable class constructor");
        return 0;
    }

    /* setup Service class for doInvoke() and doThreadInvoke() */
	/* optional - server ONLY */
    oTmp = (*env)->FindClass(env, "com/wm/app/b2b/server/Service");
    if (oTmp != 0) {
		cService = (*env)->NewGlobalRef(env, oTmp);
		(*env)->DeleteLocalRef(env, oTmp);

		if (cService == 0) {
			setError(con, "Unable to get global reference to Service class");
			return 0;
		}
		mInvoke = (*env)->GetStaticMethodID(env, cService, "doInvoke",
			"(Ljava/lang/String;Ljava/lang/String;Lcom/wm/app/b2b/server/Session;Lcom/wm/util/Values;)Lcom/wm/util/Values;");
		if (mInvoke == 0) {
			setError(con, "Unable to initialize Service class doInvoke methodID");
			return 0;
		}
		mThreadInvoke = (*env)->GetStaticMethodID(env, cService, "doThreadInvoke",
			"(Ljava/lang/String;Ljava/lang/String;Lcom/wm/util/Values;)Lcom/wm/app/b2b/server/ServiceThread;");
		if (mThreadInvoke == 0) {
			setError(con, "Unable to initialize Service class doThreadInvoke methodID");
			return 0;
		}
		mThrowErrorMsg = (*env)->GetStaticMethodID(env, cService, "throwError",
			"(Ljava/lang/String;)Lcom/wm/util/Values;");
		if(mThrowErrorMsg == 0) {
			setError(con, "Unable to initialize Service class throwError methodID");
			return 0;
		}
		mThrowError = (*env)->GetStaticMethodID(env, cService, "throwError",
			"(Ljava/lang/Throwable;)Lcom/wm/util/Values;");
		if(mThrowError == 0) {
			setError(con, "Unable to initialize Service class throwError methodID");
			return 0;
		}

		/* setup ServiceThread class for getData() */
		oTmp = (*env)->FindClass(env,"com/wm/app/b2b/server/ServiceThread");
		if (oTmp == 0 ) {
			setError(con, "Unable to initialize ServiceThread class reference");
			return 0;
		}
		cServiceThread = (*env)->NewGlobalRef(env, oTmp);

		(*env)->DeleteLocalRef(env, oTmp);

		if (cServiceThread == 0) {
			setError(con, "Unable to get global reference to ServiceThread class");
			return 0;
		}
		mSACgetData = (*env)->GetMethodID(env,cServiceThread,"getData",
						"()Lcom/wm/util/Values;");
		if (mSACgetData == 0) {
			setError(con, "Unable to initialize ServiceThread.getData");
			return 0;
		}

		/* setup ServerAPI class for logError()*/
		oTmp = (*env)->FindClass(env,"com/wm/app/b2b/server/ServerAPI");
		if (oTmp == 0 ) {
			setError(con, "Unable to initialize ServerAPI class reference");
			return 0;
		}
		cSvrAPI = (*env)->NewGlobalRef(env, oTmp);

		(*env)->DeleteLocalRef(env, oTmp);

		if (cSvrAPI == 0) {
			setError(con, "Unable to get global reference to ServerAPI class");
			return 0;
		}
		mlogError = (*env)->GetStaticMethodID(env, cSvrAPI, "logError",
					"(Ljava/lang/Throwable;)V");
		if (mlogError == 0) {
			setError(con, "Unable to initialize ServerAPI.logError");
			return 0;
		}

	}
	else if ((*env)->ExceptionOccurred(env)) {
		/* clear exception on find failure */
        (*env)->ExceptionClear(env);
	}

    initialized = 1;
    return 1;

}

/* ------- Context utilities ---------- */

void
initWmContext(
	WmContext *con,
	JNIEnv *env,
	jint type)
{
	con->env = env;
	con->type = type;

	/* owned by wmJNI */
	con->errType = WM_NO_ERROR;
	con->errMsg = 0;
	con->err = 0;

	/* owned by wmJNIc */
	con->ref = 0;
}

void
clearWmContext(WmContext *con)
{
	/* free error msg, if any */
	if (con->errMsg != 0) {
		freeWmString(&con->errMsg);
		con->errMsg = 0;
	}

	/* release global ref, if any */
	if (con->err !=0) {
		(*con->env)->DeleteGlobalRef(con->env, con->err);
		con->err = 0;
	}

}


/* ------- String utilities ----------- */

char *
getStringCopy(
   WmContext	*con,
   jstring      sStr)
{
    const char *tmp;
    char *ret;
    jsize len;

	JNIEnv  *env = con->env;

    tmp = (*env)->GetStringUTFChars(env, sStr, 0);
    if (tmp == 0) {
        setError(con, "Invalid source string - getStringCopy");
        return 0;
    }

    len = strlen(tmp)+1;

    ret = (char *)malloc(len);
    if (ret == 0) {
        setError(con, "Memory Allocation Error - getStringCopy");
        return 0;
    }
    memcpy(ret, tmp, len);

    (*env)->ReleaseStringUTFChars(env, sStr, tmp);
    return ret;
}

/* --------- Create WmRecord ---------- */

WmRecord *
makeRec(
    WmContext	*con,
    jobject     oRef,
    jint        type,
    jint        size1,
    jint        size2)
{
    WmRecord *ret;
 	JNIEnv  *env = con->env;

    ret = (WmRecord *) malloc(sizeof(WmRecord));
    if (ret == 0) {
        setError(con, "Memory Allocation Error - new WmRecord");
        return 0;
    }
	ret->con = con;
    ret->env = env;
    ret->ref = oRef;
    ret->type = type;
    ret->size1 = size1;
    ret->size2 = size2;

    return ret;
}


/* --------- Error routines ----------- */

jint
getWmErrType(WmContext *con)
{
	return con->errType;
}

char *
getWmErrMsg(WmContext *con)
{
	return con->errMsg;
}

jint
clearException(
    WmContext	*con)
{
    jthrowable  exc;

	JNIEnv  *env = con->env;

	if (env == 0) {
        fprintf(stderr, "Fatal Error - null JNI Environment pointer");
		return 0;
	}

	clearWmContext(con);

    exc =(*env)->ExceptionOccurred(env);
    if (exc) {
		/* log and clear */
        (*env)->ExceptionDescribe(env);
        (*env)->ExceptionClear(env);

		/* save error info */
		extractErrInfo(con, exc);

		/* save global ref to exception */
		con->err = (*env)->NewGlobalRef(env, exc);

		(*env)->DeleteLocalRef(env, exc);
        return 0;
    }

    return 1;
}

void
extractErrInfo(
	WmContext   *con,
	jthrowable  exc)
{
	jboolean flag;
	jstring msg;
	jthrowable exc1;

	JNIEnv  *env = con->env;

	/* get throwable error message */
	msg = (*env)->CallObjectMethod(env, exc, mGetMsg);
	exc1 =(*env)->ExceptionOccurred(env);
    if (exc1) {
 		con->errType = WM_INTERNAL_ERROR;
       (*env)->ExceptionDescribe(env);
        (*env)->ExceptionClear(env);
		(*env)->DeleteLocalRef(env, exc1);
        fprintf(stderr, "Fatal Error - unable to get Throwable Error Message");
		return;
	}
	con->errMsg = getStringCopy(con, msg);

	/* set specific error type */
	if ((*env)->IsInstanceOf(env, exc, cAccessExc)) {
		con->errType = WM_ACCESS_EXCEPTION;
	}
	else if ((*env)->IsInstanceOf(env, exc, cDeliveryExc)) {
		con->errType = WM_DELIVERY_EXCEPTION;
	}
	else if ((*env)->IsInstanceOf(env, exc, cInvReqExc)) {
		con->errType = WM_INVALID_ARG_ERROR;
	}
	else if ((*env)->IsInstanceOf(env, exc, cTXExc)) {
		/* check attributes of exception for specific type */
		flag = (*env)->CallBooleanMethod(env, exc, mHeuristic);
		exc1 =(*env)->ExceptionOccurred(env);
		if (exc1) {
			con->errType = WM_INTERNAL_ERROR;
			(*env)->ExceptionDescribe(env);
			(*env)->ExceptionClear(env);
			fprintf(stderr, "Fatal Error - unable to get Heuristic flag on TXException");
			return;
		}
		if (flag)
			con->errType = WM_TX_HEURISTIC_ERROR;
		else
			con->errType = WM_TX_EXPIRED;
	}
	else if ((*env)->IsInstanceOf(env, exc, cSvcExc)) {
		/* process after!!! subclasses */
		con->errType = WM_SERVICE_EXCEPTION;
	}
	else {
		con->errType = WM_THROWABLE;
	}

	(*env)->DeleteLocalRef(env, msg);


}

void
setError(
    WmContext	*con,
    char		*msg)
{
	char *info;
	const int formatMsgLen = 64;

	info = malloc(strlen(msg) + formatMsgLen + 1);

	/* format message */
	sprintf(info, "JNI IM Error:  %s\n", msg);

	/* log Service error */
	if (cService) {
		if (!logWmServiceError(con, info)) {
			fprintf(stderr, info);
		}
	}
	else {
		fprintf(stderr, info);
	}

    if (clearException(con)) {
		/* free error msg, if any, befor assigning new memory */
		if (con->errMsg != 0) {
			freeWmString(&con->errMsg);
		}
		/* set error info - not yet set */
		con->errType = WM_INTERNAL_ERROR;
		/* Tranfer ownership to WmContext object */
		con->errMsg = info;
	}
	else {
		free(info);
	}
}

void
setKeyError(
    WmContext	*con,
    char		*msg,
    jstring		sKey)
{
    const char *key;
	char *info = NULL;
	char *keyinfo = NULL;
	const int formatMsgLen = 64;

    JNIEnv  *env = con->env;

    if (env == 0) {
		info = malloc(strlen(msg) + formatMsgLen + 1);

		sprintf(info, "JNI IM Warning: %s\n", msg);
		fprintf(stderr, "Fatal Error - null JNI Environment pointer");
		fprintf(stderr, info);
		/* release memory allocated to the message*/
		if (con->errMsg != 0) {
			freeWmString(&con->errMsg);
		}
		/* set error info */
		con->errType = WM_INTERNAL_ERROR;
		/* Tranfering ownership of memory to WmContext Object */
		con->errMsg = info;
        return;
    }

    clearException(con);

    key = (*env)->GetStringUTFChars(env, sKey, 0);
    // Allocate memory
    keyinfo = malloc(strlen(msg) + strlen(key)+ formatMsgLen + 1);

	sprintf(keyinfo, "JNI IM Warning:  %s (%s)\n", msg, key);

	if (cService) {
		if(!logWmServiceError(con, keyinfo)) {
			fprintf(stderr, keyinfo);
		}
	}
	else {
		fprintf(stderr, keyinfo);
	}

	free(keyinfo);

	(*env)->ReleaseStringUTFChars(env, sKey, key);
}

/*  --------- Miscellaneous ------------ */

jsize
getWmArraySize(
    WmRecord *rec)
{
    return rec->size1;
}

void
getWmTableSize(
    WmRecord *rec,
    jsize      *pSize1,
    jsize      *pSize2)
{
    *pSize1 = rec->size1;
    *pSize2 = rec->size2;
}


/******************* API Routines ********************************/

jstring
makeWmName(
    WmContext   *con,
    const char  *str)
{
    jobject oTmp;
    jstring sName;
    JNIEnv  *env = con->env;

    oTmp = (*env)->NewStringUTF(env, str);
    if (oTmp == 0) {
        setError(con, "Make Key String");
        return 0;
    }

    sName = (*env)->NewGlobalRef(env, oTmp);
    if (sName == 0) {
        setError(con, "Make Key global reference");
        return 0;
    }
	(*env)->DeleteLocalRef(env, oTmp);
    return sName;
}

void
freeWmName(
	WmContext	*con,
	jstring		oStr)
{
	JNIEnv *env = con->env;

	(*env)->DeleteGlobalRef(env, oStr);

}

char *
getWmName(WmContext *con, WmName str)
{
	return getStringCopy(con, str);
}


WmRecord *
makeWmRec(
    WmContext   *con,
    jobject     oRef,
    jint        type,
    jsize       size1,
    jsize       size2)
{
    return makeRec(con, oRef, type, size1, size2);
}


WmRecord *
newWmRec(
    WmContext  *con)
{
	JNIEnv *env = con->env;
    jobject oValues = (*env)->NewObject(env, cValues, mConstructor);
    if (oValues == 0) {
        setError(con, "Unable to construct new Record Values object");
        return 0;
    }

    return makeWmRec(con, oValues, WM_RECORD, 0, 0);
}


WmRecord *
newWmRecArray(
    WmContext *con,
    jsize     size)
{
    JNIEnv *env = con->env;
    jarray oArray = (*env)->NewObjectArray(env, size, cValues, ogValues);
    if(oArray == 0) {
        setError(con, "Unable to construct new Record Array");
        return 0;
    }
    return makeWmRec(con, oArray, WM_RECARRAY, size, 0);
}


WmRecord *
newWmStringArray(
    WmContext *con,
    jsize     size)
{
    JNIEnv *env = con->env;
    jarray oArray = (*env)->NewObjectArray(env, size, cString, ogString);
    if(oArray == 0) {
        setError(con, "Unable to construct new String Array");
        return 0;
    }
    return makeWmRec(con, oArray, WM_STRARRAY, size, 0);
}

WmRecord *
newWmStringTable(
    WmContext *con,
    jsize     size1,
    jsize     size2)
{
    jint i;
    jarray oTmp;
    jarray oArray1, oArray2;

    JNIEnv *env = con->env;

    /* create default entry for base array initialization */
    oTmp = (*env)->NewObjectArray(env, size2, cString, ogString);
    if (oTmp == 0) {
        setError(con, "Unable to construct default nested array");
        return 0;
    }

    oArray1 = (*env)->NewObjectArray(env, size1, cStringArray, oTmp);
    if (oArray1 == 0) {
			(*env)->DeleteLocalRef(env, (jobject)oTmp);
        setError(con, "Unable to construct new stringtable Base Array");
        return 0;
    }

    /* replace duplicate default entries */
    for (i=1; i<size1; i++) {
        oArray2 = (*env)->NewObjectArray(env, size2, cString, ogString);
        if (oArray2 == 0) {
				(*env)->DeleteLocalRef(env, (jobject)oArray1);
				(*env)->DeleteLocalRef(env, (jobject)oTmp);
            setError(con, "Unable to construct stringtable arrays");
            return 0;
        }
        (*env)->SetObjectArrayElement(env, oArray1, i, oArray2);
        if (!clearException(con)) {
				(*env)->DeleteLocalRef(env, (jobject)oArray2);
				(*env)->DeleteLocalRef(env, (jobject)oArray1);
				(*env)->DeleteLocalRef(env, (jobject)oTmp);
            setError(con, "Unable to construct stringtable");
            return 0;
        }
			(*env)->DeleteLocalRef(env, (jobject)oArray2);
    }
	(*env)->DeleteLocalRef(env, (jobject)oTmp);

    return makeWmRec(con, oArray1, WM_STRTABLE, size1, size2);
}

void
freeWmRec(
    WmRecord   **rec)
{

    WmRecord *r;
    if (rec == 0 || *rec == 0) return;


	r = *rec;


	/* clear local reference to referenced object */
	if (r->ref != 0) {
		//fprintf(stderr, "delete local reference for this record");
		(*r->env)->DeleteLocalRef(r->env, r->ref);
	}

    free(*rec);
    *rec = 0;
}

void
freeWmString(
    char    **str)
{
    if (str == 0 || *str == 0) return;

    free(*str);
    *str = 0;
}

void
printWmRec(
	WmRecord *rec,
	int		 pad)
{



}

WmRecord *
getWmRec(
    WmRecord   *curRec,
    jstring    sName)
{
    jobject oVal=0;

    JNIEnv *env = curRec->env;
    if (curRec->type != WM_RECORD) {
        setError(curRec->con, "Unable to get record by key - not a WM_RECORD");
        return 0;
    }

    oVal = (*env)->CallObjectMethod(env, curRec->ref, mGet, sName);
    if (oVal == 0) {
		if(noVarWarn == 0)
	        setKeyError(curRec->con, "Field doesn't exist", sName);
        return 0;
    }

    return makeRec(curRec->con, oVal, WM_RECORD, 0, 0);
}

jint
setWmRec(
    WmRecord   *targetRec,
    jstring    sName,
    WmRecord   *curRec)
{
    JNIEnv *env = targetRec->env;

    if (targetRec->type != WM_RECORD) {
        setError(targetRec->con, "Unable to set rec by key - target not a WM_RECORD");
        return 0;
    }
    if (curRec->type != WM_RECORD) {
        setError(targetRec->con, "Unable to set rec by key - source not a WM_RECORD");
        return 0;
    }
    (*env)->CallObjectMethod(env, targetRec->ref, mPut,
                sName, curRec->ref);
    return clearException(targetRec->con);
}

WmRecord *
getWmRecArray(
    WmRecord   *curRec,
    jstring    sName)
{
    jsize size;
    jobject oVal=0;

    JNIEnv *env = curRec->env;
    if (curRec->type != WM_RECORD) {
        setError(curRec->con, "Unable to get recarray by key - not a WM_RECORD");
        return 0;
    }

    oVal = (*env)->CallObjectMethod(env, curRec->ref, mGet, sName);
    if (oVal == 0) {
        setKeyError(curRec->con, "Unable to Get Field", sName);
        return 0;
    }

    /* figure out size of array */
    size = (*env)->GetArrayLength(env, oVal);
    if (size <= 0) {
        setError(curRec->con, "Unable to get recarray by key - Not a valid WM_RECARRAY");
        return 0;
    }

    return makeRec(curRec->con, oVal, WM_RECARRAY, size, 0);

}

jint
setWmRecArray(
    WmRecord   *targetRec,
    jstring     sName,
    WmRecord   *curRec)
{
    JNIEnv *env = targetRec->env;

    if (targetRec->type != WM_RECORD) {
        setError(targetRec->con, "Unable to set by key - target not a WM_RECORD");
        return 0;
    }
    if (curRec->type != WM_RECARRAY) {
        setError(targetRec->con, "Unable to set by key - source not a WM_RECARRAY");
        return 0;
    }

    (*env)->CallObjectMethod(env, targetRec->ref, mPut,
                sName, curRec->ref);
    return clearException(targetRec->con);

}

WmRecord *
getWmRecByIdx(
    WmRecord   *curRec,
    jint         idx)
{
    jobject oVal=0;

    JNIEnv *env = curRec->env;
    if (curRec->type != WM_RECARRAY) {
        setError(curRec->con, "Unable to get rec by index - not a WM_RECARRAY");
        return 0;
    }
    if (idx < 0 || idx >= curRec->size1) {
        setError(curRec->con, "Index out of bounds on get");
        return 0;
    }

    oVal = (*env)->GetObjectArrayElement(env, curRec->ref, idx);
    if (oVal == 0) {
        setError(curRec->con, "Unable to get rec by index");
        return 0;
    }

    return makeRec(curRec->con, oVal, WM_RECORD, 0, 0);
}

jint
setWmRecByIdx(
    WmRecord   *targetRec,
    jint        idx,
    WmRecord   *curRec)
{
    JNIEnv *env = targetRec->env;

    if (targetRec->type != WM_RECARRAY) {
        setError(targetRec->con, "Unable to set field by index - target not a WM_RECARRAY");
        return 0;
    }
    if (curRec->type != WM_RECORD) {
        setError(targetRec->con, "Unable to set field by index - source not a WM_RECORD");
        return 0;
    }
    if (idx < 0 || idx >= targetRec->size1) {
        setError(targetRec->con, "Index out of bounds on set");
        return 0;
    }

    (*env)->SetObjectArrayElement(env, targetRec->ref, idx, curRec->ref);
    return clearException(targetRec->con);
}

WmRecord *
getWmRecArrayByIdx(
    WmRecord   *curRec,
    jint        idx)
{
    jsize size;
    jobject oVal=0;

    JNIEnv *env = curRec->env;
    if (curRec->type != WM_RECARRAY) {
        setError(curRec->con, "Unable to get recarray by index - not a WM_RECARRAY");
        return 0;
    }
    if (idx < 0 || idx >= curRec->size1) {
        setError(curRec->con, "Index out of bounds on get");
        return 0;
    }

    oVal = (*env)->GetObjectArrayElement(env, curRec->ref, idx);
    if (oVal == 0) {
        setError(curRec->con, "Unable to get recarray by index");
        return 0;
    }

    /* figure out size of array */
    size = (*env)->GetArrayLength(env, oVal);
    if (size <= 0) {
        setError(curRec->con, "Unable to get recarray by index - Not a valid WM_RECARRAY");
        return 0;
    }

    return makeRec(curRec->con, oVal, WM_RECARRAY, size, 0);
}

jint
setWmRecArrayByIdx(
    WmRecord   *targetRec,
    jint        idx,
    WmRecord   *curRec)
{
    JNIEnv *env = targetRec->env;

    if (targetRec->type != WM_RECARRAY) {
        setError(targetRec->con, "Unable to set field by index - target not a WM_RECARRAY");
        return 0;
    }
    if (curRec->type != WM_RECARRAY) {
        setError(targetRec->con, "Unable to set field by index - source not a WM_RECARRAY");
        return 0;
    }
    if (idx < 0 || idx >= targetRec->size1) {
        setError(targetRec->con, "Index out of bounds on set");
        return 0;
    }

    (*env)->SetObjectArrayElement(env, targetRec->ref, idx, curRec->ref);
    return clearException(targetRec->con);
}


char *
getWmString(
    WmRecord   *curRec,
    jstring    sName)
{
    jobject oVal=0;
    JNIEnv *env = curRec->env;
    char *string = NULL;

    oVal = (*env)->CallObjectMethod(env, curRec->ref, mGet, sName);
    if (oVal == 0) {
        if(noVarWarn == 0)
	        setKeyError(curRec->con, "Field doesn't exist", sName);
        return 0;
    }

	string = getStringCopy(curRec->con, oVal);

	(*env)->DeleteLocalRef(env, oVal);

	return string;
}

jint
setWmString(
    WmRecord    *targetRec,
    jstring     sName,
    const char  *value)
{
    JNIEnv *env = targetRec->env;

    jstring oVal = (*env)->NewStringUTF(env, value);
    (*env)->CallObjectMethod(env, targetRec->ref, mPut,
                sName, oVal);

	(*env)->DeleteLocalRef(env, oVal);
    return clearException(targetRec->con);
}

WmRecord *
getWmStringArray(
    WmRecord *curRec,
    jstring  sName)
{
    jsize size;
    jobject oVal=0;

    JNIEnv *env = curRec->env;
    if (curRec->type != WM_RECORD) {
        setError(curRec->con, "Unable to get strarray by key - not a WM_RECORD");
        return 0;
    }

    oVal = (*env)->CallObjectMethod(env, curRec->ref, mGet, sName);
    if (oVal == 0) {
       if(noVarWarn == 0)
	        setKeyError(curRec->con, "Field doesn't exist", sName);
        return 0;
    }

    /* figure out size of array */
    size = (*env)->GetArrayLength(env, oVal);
    if (size <= 0) {
        setError(curRec->con, "Unable to get strarray by key - Not a valid WM_STRARRAY");
        return 0;
    }

    return makeRec(curRec->con, oVal, WM_STRARRAY, size, 0);

}

jint
setWmStringArray(
    WmRecord *targetRec,
    jstring  sName,
    WmRecord *curRec)
{
    JNIEnv *env = targetRec->env;

    if (targetRec->type != WM_RECORD) {
        setError(targetRec->con, "Unable to set by key - target not a WM_RECORD");
        return 0;
    }
    if (curRec->type != WM_STRARRAY) {
        setError(targetRec->con, "Unable to set by key - source not a WM_STRARRAY");
        return 0;
    }

    (*env)->CallObjectMethod(env, targetRec->ref, mPut,
                sName, curRec->ref);
    return clearException(targetRec->con);
}

WmRecord *
getWmStringTable(
    WmRecord *curRec,
    jstring  sName)
{
    jsize size1, size2;
    jobject oVal1=0;
    jobject oVal2=0;

    JNIEnv *env = curRec->env;
    if (curRec->type != WM_RECORD) {
        setError(curRec->con, "Unable to get strtable by key - not a WM_RECORD");
        return 0;
    }

    oVal1 = (*env)->CallObjectMethod(env, curRec->ref, mGet, sName);
    if (oVal1 == 0) {
        if(noVarWarn == 0)
        	setKeyError(curRec->con, "Field doesn't exist", sName);
        return 0;
    }

    /* figure out size of table - start with base array */
    size1 = (*env)->GetArrayLength(env, oVal1);
    if (size1 <= 0) {
        setError(curRec->con, "Unable to get strtable by key - Not a valid WM_STRTABLE");
        return 0;
    }

    /* get first embedded array to get 2d dimension */
    oVal2 = (*env)->GetObjectArrayElement(env, oVal1, 0);
    if (oVal2 == 0) {
        setError(curRec->con, "Unable to get 2d dimension - Not a valid WM_STRTABLE");
        return 0;
    }

    size2 = (*env)->GetArrayLength(env, oVal2);
    if (size2 <= 0) {
        setError(curRec->con, "Unable to get 2d dimension - Not a valid WM_STRTABLE");
        return 0;
    }
	(*env)->DeleteLocalRef(env, (jobject)oVal2);
    return makeRec(curRec->con, oVal1, WM_STRTABLE, size1, size2);

}

jint
setWmStringTable(
    WmRecord *targetRec,
    jstring  sName,
    WmRecord *curRec)
{
    JNIEnv *env = targetRec->env;

    if (targetRec->type != WM_RECORD) {
        setError(targetRec->con, "Unable to set by key - target not a WM_RECORD");
        return 0;
    }
    if (curRec->type != WM_STRTABLE) {
        setError(targetRec->con, "Unable to set by key - source not a WM_STRTABLE");
        return 0;
    }

    (*env)->CallObjectMethod(env, targetRec->ref, mPut,
                sName, curRec->ref);
    return clearException(targetRec->con);
}

char *
getWmStringByIdx(
    WmRecord    *curRec,
    jint         idx)
{
    jobject oVal=0;
    JNIEnv *env = curRec->env;
	 char *string = NULL;

    if (curRec->type != WM_STRARRAY) {
        setError(curRec->con, "Unable to get string by index - not a WM_STRARRAY");
        return 0;
    }
    if (idx < 0 || idx >= curRec->size1) {
        setError(curRec->con, "Index out of bounds on get string");
        return 0;
    }

    oVal = (*env)->GetObjectArrayElement(env, curRec->ref, idx);
    if (oVal == 0) {
        setError(curRec->con, "Unable to get string by index");
        return 0;
    }

    string = getStringCopy(curRec->con, oVal);

	(*env)->DeleteLocalRef(env, oVal);
	return string;

}

jint
setWmStringByIdx(
    WmRecord    *targetRec,
    jint         idx,
    const char  *value)
{
    jstring oVal;

    JNIEnv *env = targetRec->env;

    if (targetRec->type != WM_STRARRAY) {
        setError(targetRec->con, "Unable to set string by index - target not a WM_STRARRAY");
        return 0;
    }
    if (idx < 0 || idx >= targetRec->size1) {
        setError(targetRec->con, "Index out of bounds on set string");
        return 0;
    }

    oVal = (*env)->NewStringUTF(env, value);
    (*env)->SetObjectArrayElement(env, targetRec->ref, idx, oVal);
	(*env)->DeleteLocalRef(env, oVal);
    return clearException(targetRec->con);
}

char *
getWmStringByIndices(
    WmRecord    *curRec,
    jint         idx1,
    jint         idx2)
{
    jarray oArray=0;
    jobject oVal=0;
	 char *string = NULL;

    JNIEnv *env = curRec->env;
    if (curRec->type != WM_STRTABLE) {
        setError(curRec->con, "Unable to get string by indices - not a WM_STRTABLE");
        return 0;
    }
    if (idx1 < 0 || idx1 >= curRec->size1 ||
        idx2 < 0 || idx2 >= curRec->size2) {
        setError(curRec->con, "Indices out of bounds on get string");
        return 0;
    }

    oArray = (*env)->GetObjectArrayElement(env, curRec->ref, idx1);
    if (oArray == 0) {
        setError(curRec->con, "Unable to get array for get string by indices");
        return 0;
    }

    oVal = (*env)->GetObjectArrayElement(env, oArray, idx2);
    if (oVal == 0) {
		(*env)->DeleteLocalRef(env, (jobject)oArray);
        setError(curRec->con, "Unable to get string by indices");
        return 0;
    }

	string = getStringCopy(curRec->con, oVal);

	(*env)->DeleteLocalRef(env, oVal);

	(*env)->DeleteLocalRef(env, (jobject)oArray);

	return string;

}

jint
setWmStringByIndices(
    WmRecord    *targetRec,
    jint         idx1,
    jint         idx2,
    const char  *value)
{
    jstring oVal;
    jarray oArray=0;

    JNIEnv *env = targetRec->env;

    if (targetRec->type != WM_STRTABLE) {
        setError(targetRec->con, "Unable to set string by indices - target not a WM_STRTABLE");
        return 0;
    }
    if (idx1 < 0 || idx1 >= targetRec->size1 ||
        idx2 < 0 || idx2 >= targetRec->size2) {
        setError(targetRec->con, "Indices out of bounds on set string");
        return 0;
    }

    oArray = (*env)->GetObjectArrayElement(env, targetRec->ref, idx1);
    if (oArray == 0) {
        setError(targetRec->con, "Unable to get array for get string by indices");
        return 0;
    }

    oVal = (*env)->NewStringUTF(env, value);
    (*env)->SetObjectArrayElement(env, oArray, idx2, oVal);

	(*env)->DeleteLocalRef(env, (jobject)oVal);
	(*env)->DeleteLocalRef(env, (jobject)oArray);

    return clearException(targetRec->con);

}

WmRecord *
getWmStringArrayByIdx(
    WmRecord *curRec,
    jint idx)
{
    jobject oArray=0;

    JNIEnv *env = curRec->env;
    if (curRec->type != WM_STRTABLE) {
        setError(curRec->con, "Unable to get string array by index - not a WM_STRTABLE");
        return 0;
    }
    if (idx < 0 || idx >= curRec->size1) {
        setError(curRec->con, "Index out of bounds on get string array");
        return 0;
    }

    oArray = (*env)->GetObjectArrayElement(env, curRec->ref, idx);
    if (oArray == 0) {
        setError(curRec->con, "Unable to get string array by index");
        return 0;
    }

    return makeRec(curRec->con, oArray, WM_STRARRAY, curRec->size2, 0);

}

jint
setWmStringArrayByIdx(
    WmRecord *targetRec,
    jint      idx,
    WmRecord *curRec)
{
    JNIEnv *env = targetRec->env;

    if (targetRec->type != WM_STRTABLE) {
        setError(targetRec->con, "Unable to set string array by index - target not a WM_STRTABLE");
        return 0;
    }
    if (curRec->type != WM_STRARRAY) {
        setError(targetRec->con, "Unable to set string array by index - source not a WM_STRARRAY");
        return 0;
    }
    if (idx < 0 || idx >= targetRec->size1) {
        setError(targetRec->con, "Index out of bounds on set string array");
        return 0;
    }

    (*env)->SetObjectArrayElement(env, targetRec->ref, idx, curRec->ref);
    return clearException(targetRec->con);
}

jint
invokeWmService(
    const char *ifc,
    const char *svc,
    WmRecord *session,
    WmRecord *input,
    WmRecord *output)
{
    JNIEnv *env = session->env;
    jstring sIfc, sSvc;

 	if (cService == 0 || mInvoke == 0) {
		setError(session->con, "Unable to initialize Service class doInvoke method");
		return 0;
	}

    sIfc = (*env)->NewStringUTF(env, ifc);
    sSvc = (*env)->NewStringUTF(env, svc);
    if (sIfc == 0 || sSvc == 0) {
		if (sIfc != 0) {
			(*env)->DeleteLocalRef(env, sIfc);
		}
		if (sSvc != 0) {
			(*env)->DeleteLocalRef(env, sSvc);
		}
        setError(session->con, "Can't create interface or svc strings on doInvoke");
        return 0;
    }
    output->ref =(*env)->CallStaticObjectMethod(env, cService, mInvoke,
                    sIfc, sSvc, session->ref, input->ref);

	(*env)->DeleteLocalRef(env, sIfc);
	(*env)->DeleteLocalRef(env, sSvc);

    return clearException(session->con);
}


WmSAContext *
invokeWmServiceThreaded(
    const char *ifc,
    const char *svc,
    WmRecord *input)
{
    jstring sIfc, sSvc;
	jobject invokeThread;
	jint res;
    JNIEnv *env = input->env;
	WmSAContext *wmSAContext = NULL;

 	if (cService == 0 || mThreadInvoke == 0) {
		setError(input->con, "Unable to initialize Service class doThreadInvoke method");
		return 0;
	}

    sIfc = (*env)->NewStringUTF(env, ifc);
    sSvc = (*env)->NewStringUTF(env, svc);
    if (sIfc == 0 || sSvc == 0) {
		if (sIfc != 0) {
			(*env)->DeleteLocalRef(env, sIfc);
		}
		if (sSvc != 0) {
			(*env)->DeleteLocalRef(env, sSvc);
		}
        setError(input->con, "Can't create interface or svc strings on doThreadInvoke");
        return 0;
    }

    invokeThread = (*env)->CallStaticObjectMethod(env, cService, mThreadInvoke,
                    sIfc, sSvc,input->ref);

    res = clearException(input->con);
	if (res == 0) {
		(*env)->DeleteLocalRef(env, invokeThread);
		(*env)->DeleteLocalRef(env, sSvc);
		(*env)->DeleteLocalRef(env, sIfc);
		return 0;
	}

	(*env)->DeleteLocalRef(env, sSvc);
	(*env)->DeleteLocalRef(env, sIfc);

	wmSAContext =  makeContext(env, WM_SVR_ASYNC_CONTEXT, invokeThread);

	(*env)->DeleteLocalRef(env, invokeThread); /* Delete the local reference*/

	return wmSAContext;
}


/* --- method to retrieve the results from the ServiceThread --- */

WmRecord *
getWmServiceThreadData(
    WmSAContext   *con)
{
	jint res;
	jobject values;
	WmRecord *out;

	if (contextMismatch(con, WM_SVR_ASYNC_CONTEXT))
		return 0;

	if(cServiceThread == 0 || mSACgetData == 0) {
		setError(con,"Unable to initialize ServiceThread class getData method");
		return 0;
	}

	values = (*con ->env) ->CallObjectMethod(con->env,con->ref,mSACgetData);
	res = clearException(con);
	if (res == 0)
		return 0;

	out = makeWmRec(con, values, WM_RECORD, 0, 0);
	if (out == 0)
		setError(con,"Out of memory on ServiceThread.getData()");


	return out;
}

/* --------- ServerAPI log error ------------*/

jint
logWmServiceError(
	WmContext *con,
	const char *msg)
{
	jthrowable exc;
	JNIEnv *env = con->env;
	jstring sMsg;


	if ( cSvrAPI == 0 || mlogError == 0) {
		setError(con, "Unable to initialize ServerAPI class logError method");
		return 0;
	}

	sMsg = (*env)->NewStringUTF(env, msg);

	exc =(*env)->NewObject(env, cThrowable, mThrowableConstructor, sMsg);


	(*env)->CallStaticObjectMethod(env, cSvrAPI, mlogError, exc);

	(*con->env)->DeleteLocalRef(con->env, exc);
	(*con->env)->DeleteLocalRef(con->env, sMsg);
	return 1;
}

/* --------- Service throw error ------------- */

WmRecord *
throwWmServiceErrorMsg(
	WmContext	*con,
	const char	*msg)
{
	JNIEnv *env = con->env;
	jstring sMsg;
	jobject values;
	WmRecord *out;

	sMsg = (*env)->NewStringUTF(env,msg);

	values = (*env)->CallStaticObjectMethod(env, cService, mThrowErrorMsg, sMsg);

	out = makeWmRec(con, values, WM_RECORD, 0, 0);
	if (out == 0)
		setError(con,"Out of memory on Service.throwError(String msg)");

	(*con->env)->DeleteLocalRef(con->env, sMsg);

	return out;
}

WmRecord *
throwWmServiceError(
	WmContext *con,
	jthrowable exc)
{
	JNIEnv *env = con->env;
	jobject values;
	WmRecord *out;

	values = (*env)->CallStaticObjectMethod(env, cService, mThrowError, exc);

	out = makeWmRec(con, values, WM_RECORD, 0, 0);
	if (out == 0)
		setError(con, "Out of memory on Server.throwError(Throwable e)");


	return out;
}


/* ----------- Util methods ------------------ */

WmContext *
makeContext(
	JNIEnv *env,
	jint type,
	jobject ref)
{

	WmContext *cc = (WmContext *)malloc(sizeof(WmContext));
	//fprintf(stderr, "context size: %-6d\r\n", sizeof(WmContext));
	if (cc == 0) {
		fprintf(stderr, "Out of memory - WmContext\n");
		return 0;
	}

	initWmContext(cc, env, type);

	if (ref != 0) {
		/* get global ref to object */
		cc->ref = (*env)->NewGlobalRef(env, ref);
		if (cc->ref == 0) {
			setError(cc,
				"Unable to get global reference to WmContext Object Ref\n");
			free (cc);
			return 0;
		}

	}
	return cc;
}


jint
contextMismatch(
	WmContext	*cc,
	jint		type)
{
	if (type == cc->type)
		return 0;

	fprintf(stderr, "Context type mismatch\n");
	/* add more info later... */
	return 1;
}

void
freeWmSvrContext(
    WmContext   **ccp)
{
	WmContext *cc;

    if (ccp == 0 || *ccp == 0) return;

	cc = *ccp;

	clearWmContext(cc);

	/* clear global reference to referenced object */
	if (cc->ref != 0)
		(*cc->env)->DeleteGlobalRef(cc->env, cc->ref);

	/* release and reset */
    free(*ccp);
    *ccp = 0;
}

