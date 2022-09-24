#include "WmGroup.h"
#include "WmGlobal.h"

jmethodID _WmGroup :: mid_constructor_;
jmethodID _WmGroup :: mid_add_User_;

jclass    _WmGroup :: cid_;

_WmGroup :: _WmGroup(JNIEnv* jenv) : _WmObject(jenv)
{
	initializeMethods();

        jobj_ = jenv_->NewObject(
		cid_, 
		mid_constructor_ );

	manage_ref_ = 1;

	checkExceptions();
	
	type_ = WMGROUP;
}

_WmGroup :: _WmGroup(JNIEnv* jenv, jobject obj, int manage_ref) :
  _WmObject(jenv, obj, manage_ref)
{
	initializeMethods();

	jobj_  = obj;

	type_ = WMGROUP;
}

_WmGroup :: _WmGroup(JNIEnv* jenv, WmString user) : _WmObject(jenv)
{
	initializeMethods();

	jobj_ = jenv_->NewObject( cid_,
				  mid_constructor_, 
				  user->getJavaObject());

	manage_ref_ = 1;

	checkExceptions();

	type_ = WMGROUP;
}

_WmGroup :: _WmGroup(JNIEnv* jenv, char* user) : _WmObject(jenv)
{
	initializeMethods();

	jobj_ = jenv_->NewObject(cid_,
				 mid_constructor_,
				 jenv_->NewStringUTF( user ));

	manage_ref_ = 1;

	checkExceptions();

	type_ = WMGROUP;
}

WmUser _WmGroup :: add(WmUser user){
	jobject jresult;
	WmUser result;

	jresult = jenv_->CallObjectMethod(jobj_, mid_add_User_, user->getJavaObject());

	result = (WmUser)WmGlobal::createWmObject(jenv_, jresult, 1);
	return result;
}

void _WmGroup :: initializeMethods()
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

			cid_ = WmGlobal::getClassRef( WMGROUP );
			checkExceptions();

			mid_constructor_ = jenv_->GetMethodID(
					cid_,
					"<init>",
					"()V" );

			checkExceptions();

			mid_add_User_ = jenv_->GetMethodID(
					cid_,
					"add",
					"(Lcom/wm/app/b2b/server/User;)Lcom/wm/app/b2b/server/User;" );
			
			checkExceptions();

			WmGlobal::monitorExit( jenv_ );
		}
		catch( WmException &ex )
		{
			throw ex;
		}
	}
}



