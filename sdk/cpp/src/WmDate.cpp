#include "WmDate.h"
#include "WmGlobal.h"

jmethodID _WmDate :: mid_constructor_;
jmethodID _WmDate :: mid_toString_;

jclass    _WmDate :: cid_;

_WmDate :: _WmDate(JNIEnv* jenv) : _WmObject(jenv)
{
	initializeMethods();

        jobj_ = jenv_->NewObject(
		cid_, 
		mid_constructor_ );

	manage_ref_ = 1;

	checkExceptions();
	
	type_ = WMDATE;
}

_WmDate :: _WmDate(JNIEnv* jenv, jobject obj, int manage_ref) :
  _WmObject(jenv, obj, manage_ref)
{
	initializeMethods();

	jobj_  = obj;

	type_ = WMDATE;
}

_WmDate :: _WmDate(JNIEnv* jenv, WmString date) : _WmObject(jenv)
{
	initializeMethods();

	jobj_ = jenv_->NewObject( cid_,
				  mid_constructor_, 
				  date->getJavaObject());

	manage_ref_ = 1;

	checkExceptions();

	type_ = WMDATE;
}

_WmDate :: _WmDate(JNIEnv* jenv, char* date) : _WmObject(jenv)
{
	initializeMethods();

	jobj_ = jenv_->NewObject(cid_,
				 mid_constructor_,
				 jenv_->NewStringUTF( date ));


	manage_ref_ = 1;

	checkExceptions();

	type_ = WMDATE;
}

_WmDate :: _WmDate(JNIEnv* jenv, long date) : _WmObject(jenv)
{
	initializeMethods();

	jobj_ = jenv_->NewObject(cid_,
			 	 mid_constructor_,
				 date);

	manage_ref_ = 1;

	checkExceptions();

	type_ = WMDATE;
}

WmString _WmDate :: toString(){
	jobject jresult;
	WmString result;

	jresult = jenv_->CallObjectMethod(jobj_, mid_toString_);

	result = (WmString)WmGlobal::createWmObject(jenv_, jresult, 1);
	return result;
}

void _WmDate :: initializeMethods()
  throw(WmException)
{
	if( cid_ == NULL )
	{
		try
		{
			WmGlobal::monitorEnter( jenv_ );

			if(cid_ != NULL)
			{
				WmGlobal::monitorExit( jenv_ );
				return;
			}

			cid_ = WmGlobal::getClassRef( WMDATE );
			checkExceptions();

			mid_constructor_ = jenv_->GetMethodID(
					cid_,
					"<init>",
					"()V" );

			checkExceptions();

			mid_toString_ = jenv_->GetMethodID(
					cid_,
					"toString",
					"()Ljava/lang/String;" );
			
			checkExceptions();

			WmGlobal::monitorExit( jenv_ );
		}
		catch( WmException &ex )
		{
			throw ex;
		}
	}
}



