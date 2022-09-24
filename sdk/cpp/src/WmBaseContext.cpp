#include "WmBaseContext.h"
#include "WmGlobal.h"

jmethodID _WmBaseContext:: mid_constructor_;
jmethodID _WmBaseContext:: mid_setRpc2Ver_int_;
jmethodID _WmBaseContext:: mid_setServers_Values_;
jmethodID _WmBaseContext:: mid_getConnectedServer_;
jmethodID _WmBaseContext:: mid_getNumHosts_;
jmethodID _WmBaseContext:: mid_isClusteredEnv_;
jmethodID _WmBaseContext:: mid_setAllowRedir_int_;
jmethodID _WmBaseContext:: mid_setRetryServer_String_;
//jmethodID _WmBaseContext:: mid_setAllowRedir_int_;
jmethodID _WmBaseContext:: mid_setSecure_int_;
jmethodID _WmBaseContext:: mid_isSecure_;
jmethodID _WmBaseContext:: mid_isConnected_;
jmethodID _WmBaseContext:: mid_setFixedUri_String_;
jmethodID _WmBaseContext:: mid_setRPCType_int_;
jmethodID _WmBaseContext:: mid_setProxy_String_String_String_;
jmethodID _WmBaseContext:: mid_setSecureProxy_String_String_String_;
jmethodID _WmBaseContext:: mid_setAuthentication_String_String_;
jmethodID _WmBaseContext:: mid_getCertificate_String_;
jmethodID _WmBaseContext:: mid_setSSLCertificates_String_String_String_;
jmethodID _WmBaseContext:: mid_setSSLCertificates_String_StringArray_;
jmethodID _WmBaseContext:: mid_setInvokeDirective_String_;
jmethodID _WmBaseContext:: mid_isPipeBroken_String_String_;
jmethodID _WmBaseContext:: mid_loadWmHandler_;
jmethodID _WmBaseContext:: mid_checkConnection_;
jmethodID _WmBaseContext:: mid_getHost_String_;
jmethodID _WmBaseContext:: mid_getPort_String_String_;
jmethodID _WmBaseContext:: mid_cleanupSession_;
jmethodID _WmBaseContext:: mid_getCoder_;
jmethodID _WmBaseContext:: mid_clusterInvoke_Values_String_String_int_String_String_IData_;
jmethodID _WmBaseContext:: mid_clusterInvoke_Values_int_String_String_IData_;
jmethodID _WmBaseContext:: mid_clusterInvoke_Values_String_String_int_String_String_Values_;	
jmethodID _WmBaseContext:: mid_clusterInvoke_Values_int_String_String_Values_;	

jclass _WmBaseContext :: cid_;


_WmBaseContext :: _WmBaseContext(JNIEnv* env) : _WmObject(env)
{
	initializeMethods();
	// BaseContext is an abstract class, so we just use this
	// class for inheritance purposes.
}

_WmBaseContext :: _WmBaseContext( JNIEnv *env, jobject context, int manage_ref)
	:	_WmObject( env, context, manage_ref )
{
	initializeMethods();

	jobj_ = context;
}

_WmBaseContext :: ~_WmBaseContext(){ }

void _WmBaseContext :: setRpc2Ver(int v){
	jenv_->CallVoidMethod(
		jobj_,
		mid_setRpc2Ver_int_,
		(jint)v);

	checkExceptions();
}
			 
WmString _WmBaseContext :: getConnectedServer(){
	jobject jobj;
	WmString obj;

	jobj = jenv_->CallObjectMethod(jobj_, mid_getConnectedServer_ );

	obj = (WmString)WmGlobal::createWmObject(jenv_, jobj, 1);
	checkExceptions();

	return obj;
}

int _WmBaseContext :: getNumHosts(){
	jint jresult;

	jresult = jenv_->CallIntMethod(jobj_, mid_getNumHosts_ );
	checkExceptions();

	return (int)jresult;
}
	
int _WmBaseContext :: isClusteredEnv(){
	jboolean jval;

	jval = jenv_->CallBooleanMethod(jobj_, mid_isClusteredEnv_ );
	checkExceptions();

	return (int)jval;
}

/*void _WmBaseContext :: setAllowRedir(int val){
	jenv_->CallVoidMethod(jobj_, mid_setAllowRedir_bool_, val);
	checkExceptions();
}*/

void _WmBaseContext :: setRetryServer(WmString svr){
	jenv_->CallVoidMethod(jobj_, mid_setRetryServer_String_,
			      svr->getJavaObject());
	checkExceptions();
}

void _WmBaseContext :: setAllowRedir(int amc){
	jenv_->CallVoidMethod(jobj_, mid_setAllowRedir_int_, amc);
	checkExceptions();
}

void _WmBaseContext :: setSecure(int sec){
	jenv_->CallVoidMethod(jobj_, mid_setSecure_int_, sec);
	checkExceptions();
}

int _WmBaseContext :: isSecure(){
	jboolean answer;

	answer = jenv_->CallBooleanMethod(jobj_, mid_isSecure_ );
	checkExceptions();
	
	return (answer == JNI_TRUE ? 1 : 0 );
}

int _WmBaseContext :: isConnected(){
	jboolean answer;

	answer = jenv_->CallBooleanMethod(jobj_, mid_isConnected_ );
	checkExceptions();

	return (answer == JNI_TRUE ? 1 : 0 );
}

void _WmBaseContext :: setFixedUri(WmString uri){
	jenv_->CallVoidMethod(jobj_, mid_setFixedUri_String_,
			      uri->getJavaObject());
	checkExceptions();
}

void _WmBaseContext :: setRPCType(int type){
	jenv_->CallVoidMethod(jobj_, mid_setRPCType_int_, type);
	checkExceptions();
}

void _WmBaseContext :: setProxy(WmString host, WmString user, WmString pass){
	jenv_->CallVoidMethod(jobj_, mid_setProxy_String_String_String_,
			      host->getJavaObject(), user->getJavaObject(),
			      pass->getJavaObject());
	checkExceptions();
}

void _WmBaseContext :: setSecureProxy(WmString host, WmString usr, WmString pas){
	jenv_->CallVoidMethod(jobj_, mid_setSecureProxy_String_String_String_,
			      host->getJavaObject(), usr->getJavaObject(),
			      pas->getJavaObject());
	checkExceptions();
}

void _WmBaseContext :: setAuthentication(WmString user, WmString pass){
	jenv_->CallVoidMethod(jobj_, mid_setAuthentication_String_String_,
			      user->getJavaObject(), pass->getJavaObject());
	checkExceptions();
}

void _WmBaseContext :: setServers(WmValues obj){
	jenv_->CallVoidMethod(jobj_, mid_setServers_Values_, 
			      obj->getJavaObject());

	checkExceptions();
}

char* _WmBaseContext :: getCertificate(WmString certPath){
	jobject boom;
	WmString result;
	
	boom = jenv_->CallObjectMethod(jobj_, mid_getCertificate_String_,
			      certPath->getJavaObject());
	
        result = (WmString)WmGlobal::createWmObject(jenv_, boom, 1);
	
	checkExceptions();
	return (char*)result->toString();
}

void _WmBaseContext :: setSSLCertificates(WmString cert, WmString pk, WmString crt){
     jenv_->CallVoidMethod(jobj_, mid_setSSLCertificates_String_String_String_,
        cert->getJavaObject(), pk->getJavaObject(),
		crt->getJavaObject());
	checkExceptions();
}

void _WmBaseContext :: setInvokeDirective(WmString directive){
	jenv_->CallVoidMethod(jobj_, mid_setInvokeDirective_String_, 
			      directive->getJavaObject());
	checkExceptions();
}

int _WmBaseContext :: isPipeBroken(WmString ifc, WmString svc){
	jboolean jresult;

	jresult = jenv_->CallBooleanMethod(jobj_,
			                   mid_isPipeBroken_String_String_,
					   ifc->getJavaObject(),
					   svc->getJavaObject());
	return (jresult == JNI_TRUE ? 1 : 0 );
}

void _WmBaseContext :: loadWmHandler(){
	jenv_->CallVoidMethod(jobj_, mid_loadWmHandler_ );
	checkExceptions();
}

void _WmBaseContext :: checkConnection(){
	jenv_->CallVoidMethod(jobj_, mid_checkConnection_ );
	checkExceptions();
}

WmString _WmBaseContext :: getHost(WmString hostport){
	WmString result;
	jobject jresult = jenv_->CallObjectMethod(jobj_, mid_getHost_String_,
			                          hostport->getJavaObject());
	result = (WmString)WmGlobal::createWmObject(jenv_, jresult, 1);
        checkExceptions();
	return result;
}

WmString _WmBaseContext :: getPort(WmString hostport, WmString defPort){
	WmString result;
	jobject jresult = jenv_->CallObjectMethod(
			           jobj_, mid_getPort_String_String_, 
				   hostport->getJavaObject(), 
				   defPort->getJavaObject());

	result = (WmString)WmGlobal::createWmObject(jenv_, jresult, 1);
        checkExceptions();
	return result;
}

void _WmBaseContext :: cleanupSession(){
	jenv_->CallVoidMethod(jobj_, mid_cleanupSession_ );
	checkExceptions();
}

WmObject _WmBaseContext :: getCoder(){
	WmObject result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_, mid_getCoder_ );
	result = WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmIData _WmBaseContext :: clusterInvoke(WmValues cServers, WmString cSession,
		                        WmString cServer, int max, WmString ifc,
					WmString svc, WmIData inData){
	WmIData result;
	jobject jresult;

	jresult = 
	    jenv_->CallObjectMethod(jobj_, 
               mid_clusterInvoke_Values_String_String_int_String_String_IData_,
	       cServers->getJavaObject(), cSession->getJavaObject(), 
	       cServer->getJavaObject(), max, ifc->getJavaObject(),
	       svc->getJavaObject(), inData->getJavaObject());

	result = (WmIData)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmIData _WmBaseContext :: clusterInvoke(WmValues cServers, int max, 
		                        WmString ifc, WmString svc, 
					WmIData inData){
	WmIData result;
	jobject jresult;

	jresult = 
	    jenv_->CallObjectMethod(jobj_, 
               mid_clusterInvoke_Values_int_String_String_IData_,
	       cServers->getJavaObject(), max, ifc->getJavaObject(),
	       svc->getJavaObject(), inData->getJavaObject());

	result = (WmIData)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmValues _WmBaseContext :: clusterInvoke(WmValues cServers, WmString cSession,
		                        WmString cServer, int max, WmString ifc,
					WmString svc, WmValues inData){
	WmValues result;
	jobject jresult;

	jresult = 
	    jenv_->CallObjectMethod(jobj_, 
               mid_clusterInvoke_Values_String_String_int_String_String_Values_,
	       cServers->getJavaObject(), cSession->getJavaObject(), 
	       cServer->getJavaObject(), max, ifc->getJavaObject(),
	       svc->getJavaObject(), inData->getJavaObject());

	result = (WmValues)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmValues _WmBaseContext :: clusterInvoke(WmValues cServers, int max, 
		                        WmString ifc, WmString svc, 
					WmValues inData){
	WmValues result;
	jobject jresult;

	jresult = 
	    jenv_->CallObjectMethod(jobj_, 
               mid_clusterInvoke_Values_int_String_String_Values_,
	       cServers->getJavaObject(), max, ifc->getJavaObject(),
	       svc->getJavaObject(), inData->getJavaObject());

	result = (WmValues)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

void _WmBaseContext :: initializeMethods()
//  throw( WmException )
{
	if(cid_ == NULL )
	{
		try
		{
			WmGlobal::monitorEnter(jenv_);

			if(cid_ != NULL )
			{
				WmGlobal::monitorExit(jenv_);
				return;
			}

			cid_ = WmGlobal::getClassRef( WMBASECONTEXT );
			checkExceptions();

			mid_setRpc2Ver_int_ = jenv_->GetMethodID(
					cid_,
					"setRpc2Ver",
					"(I)V" );

			checkExceptions();

			mid_setServers_Values_ = jenv_->GetMethodID(
					cid_,
					"setServers",
					"(Lcom/wm/util/Values;)V");
			checkExceptions();

			mid_getConnectedServer_ = jenv_->GetMethodID(
					cid_,
					"getConnectedServer",
					"()Ljava/lang/String;" );

			checkExceptions();

			mid_getNumHosts_ = jenv_->GetMethodID(
					cid_,
					"getNumHosts",
					"()I" );

			checkExceptions();

			mid_isClusteredEnv_ = jenv_->GetMethodID(
					cid_,
					"isClusteredEnv",
					"()Z" );

			checkExceptions();

			mid_setAllowRedir_int_ = jenv_->GetMethodID(
					cid_,
					"setAllowRedir",
					"(Z)V" );

			checkExceptions();

			mid_setRetryServer_String_ = jenv_->GetMethodID(
					cid_,
					"setRetryServer",
					"(Ljava/lang/String;)V" );

			checkExceptions();

			mid_setAllowRedir_int_ = jenv_->GetMethodID( 
					cid_,
					"setAllowRedir",
					"(I)V" );

			checkExceptions();

			mid_setSecure_int_ = jenv_->GetMethodID(
					cid_,
					"setSecure",
					"(Z)V" );

			checkExceptions();

			mid_isSecure_ = jenv_->GetMethodID(
					cid_,
					"isSecure",
					"()Z" );

			checkExceptions();

			mid_isConnected_ = jenv_->GetMethodID(
					cid_,
					"isConnected",
					"()Z" );

			checkExceptions();

			mid_setFixedUri_String_ = jenv_->GetMethodID(
					cid_, 
					"setFixedUri",
					"(Ljava/lang/String;)V" );

			checkExceptions();

			mid_setRPCType_int_ = jenv_->GetMethodID(
					cid_,
					"setRPCType",
					"(I)V" );

			checkExceptions();

			mid_setProxy_String_String_String_ = jenv_->GetMethodID(
					cid_,
					"setProxy",
					"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V" );

			checkExceptions();

			mid_setSecureProxy_String_String_String_ = 
				jenv_->GetMethodID(
						cid_,
						"setSecureProxy",
						"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V" );

			checkExceptions();

			mid_setAuthentication_String_String_ = 
				jenv_->GetMethodID(
						cid_,
						"setAuthentication",
						"(Ljava/lang/String;Ljava/lang/String;)V");

			checkExceptions();

			mid_getCertificate_String_ = jenv_->GetMethodID(
					cid_,
					"getCertificate",
					"(Ljava/lang/String;)[B" );

			checkExceptions();

			mid_setSSLCertificates_String_String_String_ =
				jenv_->GetMethodID(
						cid_,
						"setSSLCertificates",
						"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V" );
			checkExceptions();

			mid_setSSLCertificates_String_StringArray_ = 
				jenv_->GetMethodID(
						cid_,
						"setSSLCertificates", 
						"(Ljava/lang/String;[Ljava/lang/String;)V"
						  );
			checkExceptions();

			mid_setInvokeDirective_String_ = jenv_->GetMethodID(
					cid_,
					"setInvokeDirective",
					"(Ljava/lang/String;)V" );

			checkExceptions();

			mid_isPipeBroken_String_String_ = jenv_->GetMethodID(
					cid_,
					"isPipeBroken",
					"(Ljava/lang/String;Ljava/lang/String;)Z" );


			checkExceptions();

			mid_loadWmHandler_ = jenv_->GetMethodID(
					cid_,
					"loadWmHandler",
					"()V" );

			checkExceptions();

			mid_checkConnection_ = jenv_->GetMethodID(
					cid_,
					"checkConnection",
					"()V" );

			checkExceptions();

			mid_getHost_String_ = jenv_->GetMethodID(
					cid_,
					"getHost",
					"(Ljava/lang/String;)Ljava/lang/String;" );

			checkExceptions();

			mid_getPort_String_String_ = jenv_->GetMethodID(
					cid_,
					"getPort",
					"(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;" );

			checkExceptions();

			mid_cleanupSession_ = jenv_->GetMethodID(
					cid_,
					"cleanupSession",
					"()V" );

			checkExceptions();

			mid_getCoder_ = jenv_->GetMethodID(
					cid_,
					"getCoder",
					"()Ljava/lang/Object;");

			checkExceptions();

			mid_clusterInvoke_Values_String_String_int_String_String_IData_ = 
				jenv_->GetMethodID(
						cid_,
						"clusterInvoke",
						"(Lcom/wm/util/Values;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Lcom/wm/data/IData;)Lcom/wm/data/IData;" );

			checkExceptions();

			mid_clusterInvoke_Values_String_String_int_String_String_Values_ = 
				jenv_->GetMethodID(
						cid_,
						"clusterInvoke",
						"(Lcom/wm/util/Values;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Lcom/wm/util/Values;)Lcom/wm/util/Values;" );


			checkExceptions();

			mid_clusterInvoke_Values_int_String_String_IData_ = 
				jenv_->GetMethodID(
						cid_,
						"clusterInvoke",
						"(Lcom/wm/util/Values;ILjava/lang/String;Ljava/lang/String;Lcom/wm/data/IData;)Lcom/wm/data/IData;" );

			checkExceptions();

			mid_clusterInvoke_Values_int_String_String_Values_ = 
				jenv_->GetMethodID(
						cid_,
						"clusterInvoke",
						"(Lcom/wm/util/Values;ILjava/lang/String;Ljava/lang/String;Lcom/wm/util/Values;)Lcom/wm/util/Values;" );
			checkExceptions();

			WmGlobal::monitorExit( jenv_ );
		}
		catch( WmException &ex )
		{
			throw ex;
		}
	}
}
