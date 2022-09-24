#include "WmInvokeThread.h"
#include "WmGlobal.h"

jmethodID	_WmInvokeThread::mid_getData_;
jmethodID	_WmInvokeThread::mid_constructor_;

jclass		_WmInvokeThread::cid_;

_WmInvokeThread::_WmInvokeThread( JNIEnv *jenv ) : _WmObject( jenv )
{
	initializeMethods();

	jobj_ = jenv_->NewObject(
		cid_,
		mid_constructor_ );

	manage_ref_ = 1;

	type_ = WMINVOKETHREAD;

	checkExceptions();
}

/*
_WmInvokeThread::_WmInvokeThread( JNIEnv *jenv, WmContext ctx, 
		jstring ifc, jstring svc, WmValues data) : 
	_WmObject( jenv )
{
	initializeMethods();

	jobj_ = jenv_->NewObject(
		cid_,
		mid_constructor_ );

	manage_ref_ = 1;

	type_ = WMINVOKETHREAD;
	
	jfieldID thisctx = jenv_->GetFieldID(cid_, "nc", "Lcom/wm/app/b2b/client/Context;");
	jenv_->SetObjectField(jobj_, thisctx, ctx->getJavaObject());

	jfieldID thisdata = jenv_->GetFieldID(cid_, "data", "Lcom/wm/util/Values;");
	jenv_->SetObjectField(jobj_, thisdata, data->getJavaObject());

	jfieldID thisifc = jenv_->GetFieldID(cid_, "ifc", "Ljava/lang/String;");
	jenv_->SetObjectField(jobj_, thisifc, ifc);

	jfieldID thissvc = jenv_->GetFieldID(cid_, "svc", "Ljava/lang/String;");
	jenv_->SetObjectField(jobj_, thissvc, svc);

	checkExceptions();

}
*/

_WmInvokeThread::_WmInvokeThread( JNIEnv *jenv, jobject values, int manage_ref ) : 
	_WmObject(jenv, values, manage_ref)
{
	initializeMethods();

	jobj_ = values;

	type_ = WMINVOKETHREAD;

	checkExceptions();
}

_WmInvokeThread::~_WmInvokeThread()
{
}

WmValues _WmInvokeThread::getData( )
{
	jobject jobj = NULL;

	try
	{
		jobj = jenv_->CallObjectMethod(
			jobj_,
			mid_getData_);

		checkExceptions();
	}
	catch( WmException &ex )
	{
		throw ex;
	}

	WmValues wmv = new _WmValues(jenv_, jobj, 1);

	return (wmv);
}


void _WmInvokeThread::initializeMethods()
  throw( WmException )
{
	if( mid_constructor_ == NULL )
	{
		try
		{
			WmGlobal::monitorEnter( jenv_ );

			if( mid_constructor_ != NULL )
			{
				WmGlobal::monitorExit( jenv_ );
				return;
			}

			cid_ = WmGlobal::getClassRef( WMINVOKETHREAD );

			mid_getData_ = jenv_->GetMethodID( 
				cid_,
				"getData",
				"()Lcom/wm/util/Values;" );

			checkExceptions();
	
			mid_constructor_ = jenv_->GetMethodID( 
				cid_,
				"<init>",
				"()V" );

			checkExceptions();

			WmGlobal::monitorExit( jenv_ );
		}
		catch( WmException &ex )
		{
			throw ex;
		}
	}
}
