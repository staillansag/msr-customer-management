#include "WmTContext.h"
#include "WmGlobal.h"
#include <iostream>

using namespace std;

JNIEnv*   _WmTContext:: Sjenv_;
jclass    _WmTContext:: Scid_;
jmethodID _WmTContext:: mid_init_;
jmethodID _WmTContext:: mid_init_String_String_;
jmethodID _WmTContext:: mid_shutdown_;
jmethodID _WmTContext:: mid_shutdown_int_;
jmethodID _WmTContext:: mid_resetJobMgr_;
jmethodID _WmTContext:: mid_resetJobMgr_String_String_;
jmethodID _WmTContext:: mid_resetLogFile_;
jmethodID _WmTContext:: mid_resetLogFile_String_;
jmethodID _WmTContext:: mid_connect_String_String_String_;
jmethodID _WmTContext:: mid_connect_String_char_;
jmethodID _WmTContext:: mid_connect_String_String_;
jmethodID _WmTContext:: mid_disconnect_;
jmethodID _WmTContext:: mid_startTx_;
jmethodID _WmTContext:: mid_startTx_long_;
jmethodID _WmTContext:: mid_startTx_long_int_;
jmethodID _WmTContext:: mid_startTx_String_;
jmethodID _WmTContext:: mid_startTx_String_long_;
jmethodID _WmTContext:: mid_startTx_String_long_int_;
jmethodID _WmTContext:: mid_invokeTx_String_String_String_Values_;
jmethodID _WmTContext:: mid_submitTx_String_String_String_Values_;
jmethodID _WmTContext:: mid_submitTx_String_String_String_IData_;
jmethodID _WmTContext:: mid_sendTx_String_String_String_Values_;
jmethodID _WmTContext:: mid_sendTx_String_String_String_IData_;
jmethodID _WmTContext:: mid_retrieveTx_String_;
jmethodID _WmTContext:: mid_retrieveIDTx_String_;
jmethodID _WmTContext:: mid_retrieveTx_String_int_;
jmethodID _WmTContext:: mid_retrieveIDTx_String_int_;
jmethodID _WmTContext:: mid_endTx_String_;
jmethodID _WmTContext:: mid_restartTx_String_;
jmethodID _WmTContext:: mid_getTxStatus_String_;
jmethodID _WmTContext:: mid_getTxStatusVal_String_;
jmethodID _WmTContext:: mid_getTxData_String_;
jmethodID _WmTContext:: mid_getTxIData_String_;
jmethodID _WmTContext:: mid_getRemoteTxId_String_;
jmethodID _WmTContext:: mid_getChainedTxId_String_;

jmethodID _WmTContext:: mid_invokeJob_String_String_Values_;
jmethodID _WmTContext:: mid_invokeJob_String_String_IData_;
jmethodID _WmTContext:: mid_clusterInvokeJob_String_String_Values_;
jmethodID _WmTContext:: mid_clusterInvokeJob_String_String_IData_;
jmethodID _WmTContext:: mid_dumpJobs_;
jmethodID _WmTContext:: mid_getValueKeys_;
jmethodID _WmTContext:: mid_getValue_String_;
jmethodID _WmTContext:: mid_setValue_String_Object_;
jmethodID _WmTContext:: mid_setSSLCertificates_String_StringArray_;
jmethodID _WmTContext:: mid_updateCredentials_;
int _WmTContext::initialized;
jmethodID _WmTContext:: mid_constructor_;
jmethodID _WmTContext:: mid_invokeTx_String_String_String_IData_;

jclass _WmTContext:: cid_;

_WmTContext :: _WmTContext(JNIEnv *env) : _WmBaseContext(env)
{
	initializeMethods();

	jobj_ = jenv_->NewObject(
	 	cid_,
		mid_constructor_);

	manage_ref_ = 1;
	checkExceptions();

	type_ = WMTCONTEXT;
}

_WmTContext :: _WmTContext() : _WmBaseContext(Sjenv_)
{
	initializeMethods();

	jobj_ = jenv_->NewObject(
	 	cid_,
		mid_constructor_);

	manage_ref_ = 1;
	checkExceptions();

	type_ = WMTCONTEXT;
}

_WmTContext :: _WmTContext(JNIEnv *env, jobject context, int manage_ref) :
	_WmBaseContext( env, context, manage_ref)
{
	initializeMethods();

	jobj_ = context;

	type_ = WMTCONTEXT;
}

_WmTContext :: _WmTContext(jobject context, int manage_ref) :
	_WmBaseContext( Sjenv_, context, manage_ref)
{
	initializeMethods();

	jobj_ = context;

	type_ = WMTCONTEXT;
}

_WmTContext::~_WmTContext(){ }

void _WmTContext:: init(){
	initializeStaticMethods();
	Sjenv_->CallStaticVoidMethod(Scid_,mid_init_);
}

void _WmTContext:: init(JNIEnv* env){
	Sjenv_ = env;
	initializeStaticMethods();
	Sjenv_->CallStaticVoidMethod(Scid_,mid_init_);
}

void _WmTContext:: init(JNIEnv* env, char* jobdir, char* logfile){
	WmString Wjobdir = new _WmString(env, jobdir);
	WmString Wlogfile = new _WmString(env, logfile);

	Sjenv_ = env;
	initializeStaticMethods();

	Sjenv_->CallStaticVoidMethod(Scid_,mid_init_String_String_,
			      Wjobdir->getJavaObject(),
			      Wlogfile->getJavaObject());

	delete Wjobdir;
	delete Wlogfile;
}

void _WmTContext:: init(JNIEnv* env, WmString jobdir, WmString logfile){
	Sjenv_ = env;
	initializeStaticMethods();
	Sjenv_->CallStaticVoidMethod(Scid_,mid_init_String_String_,
			      jobdir->getJavaObject(),
			      logfile->getJavaObject());

}

void _WmTContext:: shutdown(){
	Sjenv_->CallStaticVoidMethod(Scid_,mid_shutdown_);
}

void _WmTContext:: shutdown(int force){
	Sjenv_->CallStaticVoidMethod(Scid_,mid_shutdown_int_,
			jboolean(force));
}

void _WmTContext:: resetJobMgr(){
	Sjenv_->CallStaticVoidMethod(Scid_,mid_resetJobMgr_ );
}

void _WmTContext:: resetJobMgr(WmString jobdir, WmString logfile){
	Sjenv_->CallStaticVoidMethod(Scid_,mid_resetJobMgr_String_String_,
			      jobdir->getJavaObject(),
			      logfile->getJavaObject());
}

void _WmTContext:: resetLogFile(){
	Sjenv_->CallStaticVoidMethod(Scid_,mid_resetLogFile_ ) ;
}

void _WmTContext:: resetLogFile(WmString logfile){
	Sjenv_->CallStaticVoidMethod(Scid_,mid_resetLogFile_String_,
			      logfile->getJavaObject());
}

void _WmTContext:: connect(char* server, char* user, char* pass){
	WmString srvr, usr, pss;
	srvr = new _WmString(jenv_, server);
	usr = new _WmString(jenv_, user);
	pss = new _WmString(jenv_, pass);
	jenv_->CallVoidMethod(jobj_, mid_connect_String_String_String_,
			      srvr->getJavaObject(), usr->getJavaObject(),
			      pss->getJavaObject());
	delete srvr;
	delete pss;
	delete usr;
	checkExceptions();
}

void _WmTContext:: connect(WmString server, WmString user, WmString pass){
	jenv_->CallVoidMethod(jobj_, mid_connect_String_String_String_,
			      server->getJavaObject(), user->getJavaObject(),
			      pass->getJavaObject());
	checkExceptions();
}

void _WmTContext:: connect(WmString server, char certificate[]){
	jenv_->CallVoidMethod(jobj_, mid_connect_String_char_,
			      server->getJavaObject(), certificate);
	checkExceptions();
}

void _WmTContext:: connect(WmString server, WmString certificate){
	jenv_->CallVoidMethod(jobj_, mid_connect_String_String_,
			      server->getJavaObject(),
			      certificate->getJavaObject());
	checkExceptions();
}


void _WmTContext:: disconnect(){
	jenv_->CallVoidMethod(jobj_, mid_disconnect_ );
	checkExceptions();
}

WmString _WmTContext :: startTx(){
	WmString result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_, mid_startTx_ );

	result = (WmString)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmString _WmTContext :: startTx(long ttl){
	WmString result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_, mid_startTx_long_, ttl);

	result = (WmString)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmString _WmTContext :: startTx(long ttl, int retries){
	WmString result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_, mid_startTx_long_int_,
			                  ttl, retries);

	result = (WmString)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmString _WmTContext :: startTx(WmString followTid){
	WmString result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_, mid_startTx_String_,
			                  followTid->getJavaObject());

	result = (WmString)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmString _WmTContext :: startTx(WmString followTid, long ttl){
	WmString result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_, mid_startTx_String_long_,
			                  followTid->getJavaObject(), ttl);

	result = (WmString)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmString _WmTContext :: startTx(WmString followTid, long ttl, int retries){
	WmString result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_, mid_startTx_String_long_int_,
			                  followTid->getJavaObject(), ttl,
					  retries);

	result = (WmString)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmValues _WmTContext :: invokeTx(WmString tid, WmString ifc, WmString svc,
				  WmValues data){
	WmValues result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(
			     jobj_,
			     mid_invokeTx_String_String_String_Values_,
			     tid->getJavaObject(),
			     ifc->getJavaObject(),
			     svc->getJavaObject(),
			     data->getJavaObject());

	result = (WmValues)WmGlobal::createWmObject(jenv_, jresult, 1);

	checkExceptions();
	return result;
}


WmIData _WmTContext :: invokeTx(WmString tid, WmString ifc, WmString svc,
				 WmIData data){
	WmIData result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(
			     jobj_,
			     mid_invokeTx_String_String_String_IData_,
			     tid->getJavaObject(),
			     ifc->getJavaObject(),
			     svc->getJavaObject(),
			     data->getJavaObject());

	result = (WmIData)WmGlobal::createWmObject(jenv_, jresult, 1);

	checkExceptions();
	return result;
}
void _WmTContext:: submitTx(WmString tid, WmString ifc, WmString svc,
			      WmValues data){
	jenv_->CallVoidMethod(
			     jobj_,
			     mid_submitTx_String_String_String_Values_,
			     tid->getJavaObject(),
			     ifc->getJavaObject(),
			     svc->getJavaObject(),
			     data->getJavaObject());
	checkExceptions();

}


void _WmTContext:: submitTx(WmString tid, WmString ifc, WmString svc,
			      WmIData data){
	jenv_->CallVoidMethod(
			     jobj_,
			     mid_submitTx_String_String_String_IData_,
			     tid->getJavaObject(),
			     ifc->getJavaObject(),
			     svc->getJavaObject(),
			     data->getJavaObject());
	checkExceptions();

}

void _WmTContext:: sendTx(WmString tid, WmString ifc, WmString svc,
			    WmValues data){
	jenv_->CallVoidMethod(
			     jobj_,
			     mid_submitTx_String_String_String_Values_,
			     tid->getJavaObject(),
			     ifc->getJavaObject(),
			     svc->getJavaObject(),
			     data->getJavaObject());

	checkExceptions();
}

void _WmTContext:: sendTx(WmString tid, WmString ifc, WmString svc,
	            WmIData data){
	jenv_->CallVoidMethod(
			     jobj_,
			     mid_submitTx_String_String_String_IData_,
			     tid->getJavaObject(),
			     ifc->getJavaObject(),
			     svc->getJavaObject(),
			     data->getJavaObject());

	checkExceptions();
}

WmValues _WmTContext :: retrieveTx(WmString tid){
	WmValues result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_,
					  mid_retrieveTx_String_,
					  tid->getJavaObject());

	result = (WmValues)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmIData _WmTContext :: retrieveIDTx(WmString tid){
	WmIData result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_,
					  mid_retrieveIDTx_String_,
					  tid->getJavaObject());

	result = (WmIData)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmValues _WmTContext :: retrieveTx(WmString tid, int block){
	WmValues result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_,
					  mid_retrieveTx_String_int_,
					  tid->getJavaObject(), block);

	result = (WmValues)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmIData _WmTContext :: retrieveIDTx(WmString tid, int block){
	WmIData result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_,
					  mid_retrieveIDTx_String_int_,
					  tid->getJavaObject(), block);

	result = (WmIData)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

void _WmTContext:: endTx(WmString tid){
	jenv_->CallVoidMethod(jobj_, mid_endTx_String_, tid->getJavaObject());
	checkExceptions();
}

void _WmTContext:: restartTx(WmString tid){
	jenv_->CallVoidMethod(jobj_, mid_restartTx_String_,
			      tid->getJavaObject());
	checkExceptions();
}

WmString  _WmTContext ::getTxStatus(WmString tid){
	WmString result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_, mid_getTxStatus_String_,
			 		  tid->getJavaObject());

	result = (WmString)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

int _WmTContext :: getTxStatusVal(WmString tid){
	int result;
	jint jresult;

	jresult = jenv_->CallIntMethod(jobj_, mid_getTxStatusVal_String_,
			                   tid->getJavaObject());
	result = (int)jresult;
	checkExceptions();
	return result;
}

WmValues _WmTContext :: getTxData(WmString tid){
	WmValues result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_, mid_getTxData_String_,
			                  tid->getJavaObject());
	result = (WmValues)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmIData _WmTContext :: getTxIData(WmString tid){
	WmIData result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_, mid_getTxIData_String_,
			                  tid->getJavaObject());
	result = (WmIData)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmString _WmTContext :: getRemoteTxId(WmString tid){
	WmString result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_, mid_getRemoteTxId_String_,
			                  tid->getJavaObject());
	result = (WmString)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmString _WmTContext :: getChainedTxId(WmString tid){
	WmString result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_, mid_getChainedTxId_String_,
			                  tid->getJavaObject());

	result = (WmString)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmValues _WmTContext :: invokeJob(WmString ifc, WmString svc, WmValues data){
	WmValues result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_,
			                  mid_invokeJob_String_String_Values_,
					  ifc->getJavaObject(),
					  svc->getJavaObject(),
					  data->getJavaObject());

	result = (WmValues)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmIData _WmTContext :: invokeJob(WmString ifc, WmString svc, WmIData data){
	WmIData result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_,
			                  mid_invokeJob_String_String_IData_,
					  ifc->getJavaObject(),
					  svc->getJavaObject(),
					  data->getJavaObject());

	result = (WmIData)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmValues _WmTContext :: clusterInvokeJob(WmString ifc, WmString svc,
          WmValues data){
	WmValues result;
	jobject jresult;

	jresult =
	   jenv_->CallObjectMethod(jobj_,
			           mid_clusterInvokeJob_String_String_Values_,
				   ifc->getJavaObject(), svc->getJavaObject(),
				   data->getJavaObject());

	result = (WmValues)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmIData _WmTContext :: clusterInvokeJob(WmString ifc, WmString svc,
				         WmIData data){
	WmIData result;
	jobject jresult;

	jresult =
	   jenv_->CallObjectMethod(jobj_,
			           mid_clusterInvokeJob_String_String_IData_,
				   ifc->getJavaObject(), svc->getJavaObject(),
				   data->getJavaObject());

	result = (WmIData)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

void _WmTContext:: dumpJobs(){
	jenv_->CallVoidMethod(jobj_, mid_dumpJobs_ );
	checkExceptions();
}

WmStringArray _WmTContext :: getValueKeys(){
	WmStringArray result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_, mid_getValueKeys_ );

	result = (WmStringArray)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmObject _WmTContext :: getValue(WmString key){
	WmObject result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_, mid_getValue_String_,
			                  key->getJavaObject());

	result = (WmObject)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

void _WmTContext:: setValue(WmString key, WmObject value){
	jenv_->CallVoidMethod(jobj_, mid_setValue_String_Object_,
			      key->getJavaObject(),
			      value->getJavaObject());
	checkExceptions();
}

void _WmTContext:: setSSLCertificates(WmString keyPath, WmStringArray certPaths){
	jenv_->CallVoidMethod(jobj_, mid_setSSLCertificates_String_StringArray_,
			      keyPath->getJavaObject(),
			      certPaths->getJavaObject());
	checkExceptions();
}

void _WmTContext:: updateCredentials(){
	jenv_->CallVoidMethod(jobj_, mid_updateCredentials_ );
	checkExceptions();
}

void _WmTContext:: initializeStaticMethods()
//	throw( WmException )
{
	if(initialized != 1){
		if(Scid_ == NULL){
			Scid_ = WmGlobal::getClassRef( WMTCONTEXT );
		}
		mid_init_ = Sjenv_->GetStaticMethodID(Scid_,
						      "init",
						      "()V" );
		if(mid_init_ == NULL){
			cerr << "initializeStaticMethods: init_ is NULL\n";
		}
		mid_init_String_String_ = Sjenv_->GetStaticMethodID(
				                  Scid_,
						  "init",
						  "(Ljava/lang/String;Ljava/lang/String;)V");
		if(Scid_ == NULL){
			cerr << "Scid_ is NULL!\n";
		}
		if(mid_init_String_String_ == NULL){
			cerr << "initializeStaticMethods: init_String_String_ is NULL\n";
		}
		mid_shutdown_ = Sjenv_->GetStaticMethodID(
				 	Scid_,
					"shutdown",
					"()V");
		mid_shutdown_int_ = Sjenv_->GetStaticMethodID(
				        Scid_,
					"shutdown",
					"(Z)V");
		mid_resetJobMgr_ = Sjenv_->GetStaticMethodID(
					Scid_,
					"resetJobMgr",
					"()V");
		mid_resetJobMgr_String_String_ = Sjenv_->GetStaticMethodID(
					Scid_,
					"resetJobMgr",
					"(Ljava/lang/String;Ljava/lang/String;)V");
		mid_resetLogFile_ = Sjenv_->GetStaticMethodID(
					Scid_,
					"resetLogFile",
					"()V");
		mid_resetLogFile_String_ = Sjenv_->GetStaticMethodID(
					Scid_,
					"resetLogFile",
					"(Ljava/lang/String;)V");
		WmGlobal::monitorExit(Sjenv_);
	}
}


void _WmTContext:: initializeMethods()
//	throw( WmException )
{
	if(cid_ == NULL){
		try
		{
			WmGlobal::monitorEnter( jenv_ );

			if(cid_ != NULL)
			{
				WmGlobal :: monitorExit(jenv_);
				return;
			}

			cid_ = WmGlobal::getClassRef( WMTCONTEXT );

			checkExceptions();

			mid_constructor_ = jenv_->GetMethodID( cid_,
						               "<init>",
							       "()V" );

			checkExceptions();

			mid_connect_String_String_String_ =
				jenv_->GetMethodID(cid_,
						   "connect",
						   "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V");
			checkExceptions();

			mid_connect_String_char_ =
				jenv_->GetMethodID(cid_,
						   "connect",
						   "(Ljava/lang/String;[B)V");

			checkExceptions();

			mid_connect_String_String_ =
				jenv_->GetMethodID(cid_,
						   "connect",
						   "(Ljava/lang/String;Ljava/lang/String;)V");

			checkExceptions();

			mid_disconnect_ = jenv_->GetMethodID(cid_,
							     "disconnect",
							     "()V");

			checkExceptions();

			mid_startTx_ = jenv_->GetMethodID(cid_,
							  "startTx",
							  "()Ljava/lang/String;");

			checkExceptions();

			mid_startTx_long_ = jenv_->GetMethodID(
					cid_,
					"startTx",
					"(J)Ljava/lang/String;");

			checkExceptions();

			mid_startTx_long_int_ = jenv_->GetMethodID(
					cid_,
					"startTx",
					"(JI)Ljava/lang/String;");

			checkExceptions();

			mid_startTx_String_ = jenv_->GetMethodID(
					cid_,
					"startTx",
					"(Ljava/lang/String;)Ljava/lang/String;");

			checkExceptions();

			mid_startTx_String_long_ = jenv_->GetMethodID(
					cid_,
					"startTx",
					"(Ljava/lang/String;J)Ljava/lang/String;");

			checkExceptions();

			mid_startTx_String_long_int_ = jenv_->GetMethodID(
					cid_,
					"startTx",
					"(Ljava/lang/String;JI)Ljava/lang/String;");

			checkExceptions();

			mid_invokeTx_String_String_String_Values_ =
				jenv_->GetMethodID(
						cid_,
						"invokeTx",
						"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/wm/util/Values;)Lcom/wm/util/Values;");

			checkExceptions();

			mid_invokeTx_String_String_String_IData_ =
				jenv_->GetMethodID(
						cid_,
						"invokeTx",
						"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/wm/data/IData;)Lcom/wm/data/IData;");

			checkExceptions();

			mid_submitTx_String_String_String_Values_ =
				jenv_->GetMethodID(
					cid_,
					"submitTx",
					"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/wm/util/Values;)V");

			checkExceptions();

			mid_submitTx_String_String_String_IData_ =
				jenv_->GetMethodID(
					cid_,
					"submitTx",
					"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/wm/data/IData;)V");

			checkExceptions();

			mid_sendTx_String_String_String_Values_ =
				jenv_->GetMethodID(
					cid_,
					"sendTx",
					"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/wm/util/Values;)V");

			checkExceptions();

			mid_sendTx_String_String_String_IData_ =
				jenv_->GetMethodID(
					cid_,
					"sendTx",
					"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/wm/data/IData;)V");

			checkExceptions();

			mid_retrieveTx_String_ = jenv_->GetMethodID(
				cid_,
				"retrieveTx",
				"(Ljava/lang/String;)Lcom/wm/util/Values;");

			checkExceptions();

			mid_retrieveIDTx_String_ = jenv_->GetMethodID(
				cid_,
				"retrieveIDTx",
				"(Ljava/lang/String;)Lcom/wm/data/IData;");

			checkExceptions();

			mid_retrieveTx_String_int_ = jenv_->GetMethodID(
				cid_,
				"retrieveTx",
				"(Ljava/lang/String;Z)Lcom/wm/util/Values;");

			checkExceptions();

			mid_retrieveIDTx_String_int_ = jenv_->GetMethodID(
					cid_,
					"retrieveIDTx",
					"(Ljava/lang/String;Z)Lcom/wm/data/IData;");

			checkExceptions();

			mid_endTx_String_ = jenv_->GetMethodID(
					cid_,
					"endTx",
					"(Ljava/lang/String;)V");

			checkExceptions();

			mid_restartTx_String_ = jenv_->GetMethodID(
					cid_,
					"restartTx",
					"(Ljava/lang/String;)V");

			checkExceptions();

			mid_getTxStatus_String_ = jenv_->GetMethodID(
					cid_,
					"getTxStatus",
					"(Ljava/lang/String;)Ljava/lang/String;");

			checkExceptions();

			mid_getTxStatusVal_String_ = jenv_->GetMethodID(
					cid_,
					"getTxStatusVal",
					"(Ljava/lang/String;)I");

			checkExceptions();

			mid_getTxData_String_ = jenv_->GetMethodID(
					cid_,
					"getTxData",
					"(Ljava/lang/String;)Lcom/wm/util/Values;");

			checkExceptions();

			mid_getTxIData_String_ = jenv_->GetMethodID(
					cid_,
					"getTxIData",
					"(Ljava/lang/String;)Lcom/wm/data/IData;");

			checkExceptions();

			mid_getRemoteTxId_String_ = jenv_->GetMethodID(
					cid_,
					"getRemoteTxId",
					"(Ljava/lang/String;)Ljava/lang/String;");

			checkExceptions();

			mid_getChainedTxId_String_ =
				jenv_->GetMethodID(
					cid_,
					"getChainedTxId",
					"(Ljava/lang/String;)Ljava/lang/String;");
			checkExceptions();


			mid_invokeJob_String_String_Values_ =
				jenv_->GetMethodID(
					cid_,
					"invokeJob",
					"(Ljava/lang/String;Ljava/lang/String;Lcom/wm/util/Values;)Lcom/wm/util/Values;");

			checkExceptions();

			mid_invokeJob_String_String_IData_ =
				jenv_->GetMethodID(
					cid_,
					"invokeJob",
					"(Ljava/lang/String;Ljava/lang/String;Lcom/wm/data/IData;)Lcom/wm/data/IData;");

			checkExceptions();

			mid_clusterInvokeJob_String_String_Values_ =
				jenv_->GetMethodID(
					cid_,
					"clusterInvokeJob",
					"(Ljava/lang/String;Ljava/lang/String;Lcom/wm/util/Values;)Lcom/wm/util/Values;");

			checkExceptions();

			mid_clusterInvokeJob_String_String_IData_ =
				jenv_->GetMethodID(
					cid_,
					"clusterInvokeJob",
					"(Ljava/lang/String;Ljava/lang/String;Lcom/wm/data/IData;)Lcom/wm/data/IData;");

			checkExceptions();

			mid_dumpJobs_ = jenv_->GetMethodID(
					cid_,
					"dumpJobs",
					"()V");

			checkExceptions();

			mid_getValueKeys_ = jenv_->GetMethodID(
					cid_,
					"getValueKeys",
					"()[Ljava/lang/String;");

			checkExceptions();

			mid_getValue_String_ =
				jenv_->GetMethodID(
					cid_,
					"getValue",
					"(Ljava/lang/String;)Ljava/lang/Object;");

			checkExceptions();

			mid_setValue_String_Object_ =
				jenv_->GetMethodID(
					cid_,
					"setValue",
					"(Ljava/lang/String;Ljava/lang/Object;)V");

			checkExceptions();

			mid_setSSLCertificates_String_StringArray_ =
				jenv_->GetMethodID(
					cid_,
					"setSSLCertificates",
					"(Ljava/lang/String;[Ljava/lang/String;)V");

			checkExceptions();

			mid_updateCredentials_ = jenv_->GetMethodID(
					cid_,
					"updateCredentials",
					"()V");

			checkExceptions();

			WmGlobal::monitorExit( jenv_ );
		}
		catch( WmException &ex)
		{
			throw ex;
		}
 	}
}






