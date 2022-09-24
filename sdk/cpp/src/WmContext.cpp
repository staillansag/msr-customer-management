

#include "WmContext.h"
#include "WmGlobal.h"

#include <iostream>

using namespace std;

jmethodID _WmContext::mid_constructor_;
jmethodID _WmContext::mid_connect_String_String_String_;
jmethodID _WmContext::mid_disconnect_;
jmethodID _WmContext::mid_invoke_String_String_Values_;
jmethodID _WmContext::mid_isConnected_;
jmethodID _WmContext::mid_isSecure_;
jmethodID _WmContext::mid_setFixedUri_String_;
jmethodID _WmContext::mid_setProxy_String_String_String_;
jmethodID _WmContext::mid_setSecure_int_;
jmethodID _WmContext::mid_setSecureProxy_String_String_String_;
jmethodID _WmContext::mid_invokeThreaded_String_String_Values_;

jmethodID _WmContext::mid_invoke_String_String_IData_;
jmethodID _WmContext::mid_clusterSvcInvoke_String_String_Values_;
jmethodID _WmContext::mid_clusterSvcInvoke_String_String_IData_;
jmethodID _WmContext::mid_invoke_String_String_IData_int_;


jclass _WmContext::cid_;

_WmContext::_WmContext( JNIEnv *env ) : _WmBaseContext( env )
{
	initializeMethods();

	jobj_ = jenv_->NewObject(
		cid_,
		mid_constructor_ );

	manage_ref_ = 1;

	checkExceptions();

	type_ = WMCONTEXT;
}

_WmContext::_WmContext( JNIEnv *env, jobject context, int manage_ref ) :
	_WmBaseContext( env, context, manage_ref )
{
	initializeMethods();

	jobj_ = context;

	type_ = WMCONTEXT;
}

_WmContext::~_WmContext()
{
}

WmIData _WmContext::invoke(WmString ifc, WmString svc, WmIData idata){
	WmIData result;
	jobject jresult;
	checkExceptions();

	jresult = jenv_->CallObjectMethod(jobj_,mid_invoke_String_String_IData_,
			ifc->getJavaObject(), svc->getJavaObject(),
			idata->getJavaObject());

	if(jresult == NULL){
		cerr << "WmContext::invoke():  result is NULL " << endl;
	}

	checkExceptions();
	result = (WmIData)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmIData _WmContext::invoke(jstring ifc, jstring svc, WmIData idata){
	WmIData result;
	jobject jresult;
	checkExceptions();

	jresult = jenv_->CallObjectMethod(jobj_,mid_invoke_String_String_IData_,
			ifc, svc,
			idata->getJavaObject());

	if(jresult == NULL){
		cerr << "WmContext::invoke():  result is NULL " << endl;
	}

	checkExceptions();
	result = (WmIData)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

WmIData _WmContext :: invoke(char* ifc, char* svc, WmIData idata)
//	throw (WmException)
{
	WmString ifc_str = new _WmString(jenv_, ifc);
	WmString svc_str = new _WmString(jenv_, svc);

	WmIData result = invoke(ifc_str, svc_str, idata);

	delete ifc_str;
	delete svc_str;

	return result;
}

WmIData _WmContext :: invoke(char* ifc, char* svc,
		             WmIData idata, int isConnect){
	WmString wifc = new _WmString(jenv_, ifc),
	         wsvc = new _WmString(jenv_, svc);

	WmIData result = invoke(wifc, wsvc, idata, isConnect);
	delete wifc; delete wsvc;
	checkExceptions();
	return result;
}


WmIData _WmContext::invoke(WmString ifc, WmString svc,
		           WmIData idata, int isConnect){
	WmIData result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_, mid_invoke_String_String_IData_int_,
			ifc->getJavaObject(), svc->getJavaObject(),
			idata->getJavaObject(), isConnect);

	result = (WmIData)WmGlobal::createWmObject(jenv_, jresult, 1);
	checkExceptions();
	return result;
}

/** Extended from class BaseContext **/

WmValues _WmContext :: clusterSvcInvoke(WmString ifc, WmString svc, WmValues in)
{
	WmValues vals;
	jobject result;

	result = jenv_->CallObjectMethod(jobj_,
			          mid_clusterSvcInvoke_String_String_Values_,
				  ifc->getJavaObject(),
				  svc->getJavaObject(),
				  in->getJavaObject());

	vals = (WmValues)WmGlobal::createWmObject(jenv_, result, 1);
	checkExceptions();
	return vals;
}

WmIData _WmContext :: clusterSvcInvoke(WmString ifc, WmString svc, WmIData in)
{
	WmIData vals;
	jobject result;

	result = jenv_->CallObjectMethod(jobj_,
			          mid_clusterSvcInvoke_String_String_IData_,
				  ifc->getJavaObject(),
				  svc->getJavaObject(),
				  in->getJavaObject());

	vals = (WmIData)WmGlobal::createWmObject(jenv_, result, 1);
	checkExceptions();
	return vals;
}

WmIData _WmContext :: clusterSvcInvoke(char* ifc, char* svc, WmIData in){
	WmString wifc = new _WmString(jenv_, ifc),
	 	 wsvc =	new _WmString(jenv_, svc);

	WmIData results = clusterSvcInvoke(wifc, wsvc, in);

	delete wifc; delete wsvc;
	checkExceptions();
	return results;
}

WmValues _WmContext :: clusterSvcInvoke(char* ifc, char* svc, WmValues in){
	WmString wifc = new _WmString(jenv_, ifc),
	 	 wsvc =	new _WmString(jenv_, svc);

	WmValues results = clusterSvcInvoke(wifc, wsvc, in);

	delete wifc; delete wsvc;
	checkExceptions();
	return results;
}
void _WmContext::connect(WmString host, WmString user, WmString pwd)
{
	connect(
		(jstring)host->getJavaObject(),
		(jstring)user->getJavaObject(),
		(jstring)pwd->getJavaObject() );
	checkExceptions();
}

void _WmContext::connect(jstring host, jstring user, jstring pwd)
{
	WmUtil::trace("WmContext.connect : Calling Java API Context.connect.");

	jenv_->CallVoidMethod(
		jobj_,
		mid_connect_String_String_String_,
		host,
		user,
		pwd );

	WmUtil::trace("WmContext.connect. Checking exceptions after calling Java API Context.connect.");

	checkExceptions();

	WmUtil::trace("WmContext.connect. No exceptions thrown from calling Java API Context.connect. Exiting");
}

void _WmContext::connect(char *host, char *user, char *pwd)
{
	jstring jhost = jenv_->NewStringUTF( host );
	jstring juser = jenv_->NewStringUTF( user );
	jstring jpwd = jenv_->NewStringUTF( pwd );

	connect(
		jhost,
		juser,
		jpwd );

	jenv_->DeleteLocalRef( jhost );
	jenv_->DeleteLocalRef( juser );
	jenv_->DeleteLocalRef( jpwd );
	checkExceptions();
}

void _WmContext::disconnect()
{
	WmUtil::trace("WmContext.disconnect : Calling Java API Context.disconnect.");

	jenv_->CallVoidMethod(
		jobj_,
		mid_disconnect_ );

	WmUtil::trace("WmContext.disconnect. Checking exceptions after calling Java API Context.disconnect.");

	checkExceptions();

	WmUtil::trace("WmContext.disconnect. No exceptions thrown from calling Java API Context.disconnect. Exiting.");

}

WmValues _WmContext::invoke(WmString ifc, WmString svc, WmValues vals)
{
	WmValues return_vals = NULL;

	return_vals = invoke(
		(jstring)ifc->getJavaObject(),
		(jstring)svc->getJavaObject(),
		vals );

	checkExceptions();
	return return_vals;
}

WmInvokeThread _WmContext::invokeThreaded(char* ifc, char* svc, WmValues vals)
{
	jstring jifc = jenv_->NewStringUTF( ifc );
	jstring jsvc = jenv_->NewStringUTF( svc );

	WmInvokeThread return_vals = NULL;
	jobject jvals;

	jvals = jenv_->CallObjectMethod(
		jobj_,
		mid_invokeThreaded_String_String_Values_,
		jifc,
		jsvc,
		vals->getJavaObject() );

	checkExceptions();

	return_vals = (WmInvokeThread)WmGlobal::createWmObject( jenv_, jvals, 1 );

        cout << "Debug: checkExceptions() 2\n";
	checkExceptions();

	return return_vals;
}

WmInvokeThread _WmContext::invokeThreaded(jstring ifc, jstring svc, WmValues vals)
{
	WmInvokeThread return_vals = NULL;
	jobject jvals;

	jvals = jenv_->CallObjectMethod(
		jobj_,
		mid_invokeThreaded_String_String_Values_,
		ifc,
		svc,
		vals->getJavaObject() );

	checkExceptions();

	return_vals = (WmInvokeThread)WmGlobal::createWmObject( jenv_, jvals, 1 );

	checkExceptions();

	return return_vals;
}

WmValues _WmContext::invoke(jstring ifc, jstring svc, WmValues vals)
{
	WmUtil::trace("WmContext.invoke. Entered");
	jboolean iscopy;
	const char *strifc = jenv_->GetStringUTFChars(ifc,&iscopy);
	const char *strsvc = jenv_->GetStringUTFChars(svc,&iscopy);
	WmUtil::trace((char*)strifc);
	WmUtil::trace((char*)strsvc);
	jenv_->ReleaseStringUTFChars(ifc,strifc);
	jenv_->ReleaseStringUTFChars(svc,strsvc);

	WmValues return_vals = NULL;
	jobject jvals;

	WmUtil::trace("WmContext.invoke : Calling Java API Context.invoke");

	jvals = jenv_->CallObjectMethod(
		jobj_,
		mid_invoke_String_String_Values_,
		ifc,
		svc,
		vals->getJavaObject() );

	WmUtil::trace("WmContext.invoke. Returned from calling Java API Context.invoke");

	WmUtil::trace("WmContext.invoke. Checking exceptions from calling Java API Context.invoke");

	checkExceptions();

	WmUtil::trace("WmContext.invoke. No exceptions thrown from calling Java API Context.invoke");

	WmUtil::trace("WmContext.invoke. Converting Java Values object to C++ Values object");

	return_vals = (WmValues)WmGlobal::createWmObject( jenv_, jvals );

	WmUtil::trace("WmContext.invoke. Converted Java Values object to C++ Values object");

	WmUtil::trace("WmContext.invoke. Checking exceptions from converting Java Values object to C++ Values object");

	checkExceptions();

	WmUtil::trace("WmContext.invoke. No exceptions thrown from converting Java Values object to C++ Values object");

	WmUtil::trace("WmContext.invoke. exiting");

	return return_vals;
}

WmValues _WmContext::invoke(char *ifc, char *svc, WmValues vals)
{
	WmValues return_vals = NULL;
	jstring jifc = jenv_->NewStringUTF( ifc );
	jstring jsvc = jenv_->NewStringUTF( svc );

	return_vals = invoke(
		jifc,
		jsvc,
		vals );

	checkExceptions();
	return return_vals;
}

int _WmContext::isConnected()
{
	jboolean jresult = JNI_FALSE;
	int result = 0;

	jresult = jenv_->CallBooleanMethod(
		jobj_,
		mid_isConnected_ );

	checkExceptions();

	result = (jresult == JNI_TRUE) ? 1 : 0;

	return result;
}

void _WmContext::initializeMethods()
  throw( WmException )
{
	if( cid_ == NULL )
	{
		try
		{
			WmGlobal::monitorEnter( jenv_ );

			if( cid_ != NULL )
			{
				WmGlobal::monitorExit( jenv_ );
				return;
			}

			cid_ = WmGlobal::getClassRef( WMCONTEXT );
			checkExceptions();

			mid_constructor_ = jenv_->GetMethodID(
				cid_,
				"<init>",
				"()V" );


			mid_connect_String_String_String_ = jenv_->GetMethodID(
				cid_,
				"connect",
				"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V" );

			checkExceptions();

			mid_disconnect_ = jenv_->GetMethodID(
				cid_,
				"disconnect",
				"()V" );

			checkExceptions();

			mid_invokeThreaded_String_String_Values_ = jenv_->GetMethodID(
				cid_,
				"invokeThreaded",
				"(Ljava/lang/String;Ljava/lang/String;Lcom/wm/util/Values;)Lcom/wm/app/b2b/client/InvokeThread;" );

			checkExceptions();

			mid_invoke_String_String_Values_ = jenv_->GetMethodID(
				cid_,
				"invoke",
				"(Ljava/lang/String;Ljava/lang/String;Lcom/wm/util/Values;)Lcom/wm/util/Values;" );

			checkExceptions();

			mid_isConnected_ = jenv_->GetMethodID(
				cid_,
				"isConnected",
				"()Z" );

			checkExceptions();

			mid_isSecure_ = jenv_->GetMethodID(
				cid_,
				"isSecure",
				"()Z" );

			checkExceptions();

			mid_setFixedUri_String_ = jenv_->GetMethodID(
				cid_,
				"setFixedUri",
				"(Ljava/lang/String;)V" );

			checkExceptions();

			mid_setProxy_String_String_String_ = jenv_->GetMethodID(
				cid_,
				"setProxy",
				"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V" );

			checkExceptions();

			mid_setSecure_int_ = jenv_->GetMethodID(
				cid_,
				"setSecure",
				"(Z)V" );

			checkExceptions();

			mid_setSecureProxy_String_String_String_ = jenv_->GetMethodID(
				cid_,
				"setSecureProxy",
				"(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V" );
			checkExceptions();

			mid_invoke_String_String_IData_ = jenv_->GetMethodID(
					cid_,
					"invoke",
					"(Ljava/lang/String;Ljava/lang/String;Lcom/wm/data/IData;)Lcom/wm/data/IData;" );

			checkExceptions();

			mid_clusterSvcInvoke_String_String_Values_ =
				jenv_->GetMethodID(cid_,
				       "clusterSvcInvoke",
				       "(Ljava/lang/String;Ljava/lang/String;Lcom/wm/util/Values;)Lcom/wm/util/Values;" );

			checkExceptions();

			mid_clusterSvcInvoke_String_String_IData_ =
				jenv_->GetMethodID(cid_,
				       "clusterSvcInvoke",
				       "(Ljava/lang/String;Ljava/lang/String;Lcom/wm/data/IData;)Lcom/wm/data/IData;" );

			checkExceptions();

			mid_invoke_String_String_IData_int_ =
				jenv_->GetMethodID(
					cid_,
					"invoke",
					"(Ljava/lang/String;Ljava/lang/String;Lcom/wm/data/IData;Z)Lcom/wm/data/IData;" );

			checkExceptions();

			WmGlobal::monitorExit( jenv_ );
		}
		catch( WmException &ex )
		{
			throw ex;
		}
	}
}

int _WmContext::isSecure()
{
	jboolean jresult = JNI_FALSE;
	int result = 0;

	jresult = jenv_->CallBooleanMethod(
		jobj_,
		mid_isSecure_ );

	checkExceptions();

	result = (jresult == JNI_TRUE) ? 1 : 0;

	return result;
}

void _WmContext::setFixedUri(WmString uri)
{
	setFixedUri( (jstring)uri->getJavaObject() );
}

void _WmContext::setFixedUri(jstring uri)
{
	jenv_->CallVoidMethod(
		jobj_,
		mid_setFixedUri_String_,uri );

	checkExceptions();
}

void _WmContext::setFixedUri(char *uri)
{
	jstring juri = jenv_->NewStringUTF( uri );

	checkExceptions();

	setFixedUri( juri );

	jenv_->DeleteLocalRef( juri );

	checkExceptions();
}

void _WmContext::setProxy(WmString host, WmString user, WmString pass)
{
	jstring jhost = (jstring)host->getJavaObject();
	jstring juser = NULL;
	jstring jpass = NULL;

	if( user != NULL ) juser = (jstring)user->getJavaObject();
	if( pass != NULL ) jpass = (jstring)pass->getJavaObject();

	setProxy( jhost, juser, jpass );
}

void _WmContext::setProxy(jstring host, jstring user, jstring pass)
{
	jenv_->CallVoidMethod(
		jobj_,
		mid_setProxy_String_String_String_,host,user,pass );

	checkExceptions();
}

void _WmContext::setProxy(char *host, char *user, char *pass)
{
	jstring jhost = NULL;
	jstring juser = NULL;
	jstring jpass = NULL;

	jhost = jenv_->NewStringUTF( host );

	if( user != NULL )
	{
		juser = jenv_->NewStringUTF( user );
		checkExceptions();
	}

	if( pass != NULL )
	{
		jpass = jenv_->NewStringUTF( pass );
		checkExceptions();
	}

	setProxy( jhost, juser, jpass );

	jenv_->DeleteLocalRef( jhost );
	jenv_->DeleteLocalRef( juser );
	jenv_->DeleteLocalRef( jpass );

	checkExceptions();
}

void _WmContext::setSecure(int setting)
{
	jboolean jsetting = (setting == 1) ? JNI_TRUE : JNI_FALSE;

	jenv_->CallVoidMethod(
		jobj_,
		mid_setSecure_int_,
		jsetting );

	checkExceptions();
}

void _WmContext::setSecureProxy(WmString host, WmString user, WmString pass)
{
	jstring jhost = (jstring)host->getJavaObject();
	jstring juser = NULL;
	jstring jpass = NULL;

	if( user != NULL ) juser = (jstring)user->getJavaObject();
	if( pass != NULL ) jpass = (jstring)pass->getJavaObject();

	setSecureProxy( jhost, juser, jpass );
			checkExceptions();

}

void _WmContext::setSecureProxy(jstring host, jstring user, jstring pass)
{
	jenv_->CallVoidMethod(
		jobj_,
		mid_setSecureProxy_String_String_String_, host, user, pass );

	checkExceptions();
}

void _WmContext::setSecureProxy(char *host, char *user, char *pass)
{
	jstring jhost = NULL;
	jstring juser = NULL;
	jstring jpass = NULL;

	jhost = jenv_->NewStringUTF( host );

	if( user != NULL )
	{
		juser = jenv_->NewStringUTF( user );
		checkExceptions();
	}

	if( pass != NULL )
	{
		jpass = jenv_->NewStringUTF( pass );
		checkExceptions();
	}

	setSecureProxy( jhost, juser, jpass );

	jenv_->DeleteLocalRef( jhost );
	jenv_->DeleteLocalRef( juser );
	jenv_->DeleteLocalRef( jpass );

	checkExceptions();
}

