#include "WmUser.h"
#include "WmGlobal.h"

jmethodID _WmUser :: mid_constructor_;
jmethodID _WmUser :: mid_add_Group_;
jmethodID _WmUser :: mid_isAdministrator_;

jclass    _WmUser :: cid_;

_WmUser :: _WmUser(JNIEnv* jenv) : _WmObject(jenv)
{
	initializeMethods();

        jobj_ = jenv_->NewObject(
		cid_, 
		mid_constructor_ );

	manage_ref_ = 1;

	checkExceptions();
	
	type_ = WMUSER;
}

_WmUser :: _WmUser(JNIEnv* jenv, jobject obj, int manage_ref) :
  _WmObject(jenv, obj, manage_ref)
{
	initializeMethods();

	jobj_  = obj;

	type_ = WMUSER;
}

_WmUser :: _WmUser(JNIEnv* jenv, WmString name) : _WmObject(jenv)
{
	initializeMethods();

	jobj_ = jenv_->NewObject( cid_,
				  mid_constructor_, 
				  name->getJavaObject());

	manage_ref_ = 1;

	checkExceptions();

	type_ = WMUSER;
}

_WmUser :: _WmUser(JNIEnv* jenv, char* name) : _WmObject(jenv)
{
	initializeMethods();

	jobj_ = jenv_->NewObject(cid_,
				 mid_constructor_,
				 jenv_->NewStringUTF( name ));

	manage_ref_ = 1;

	checkExceptions();

	type_ = WMUSER;
}

WmGroup _WmUser :: add(WmGroup group){
	jobject jresult;
	WmGroup result;

	jresult = jenv_->CallObjectMethod(jobj_, mid_add_Group_, group->getJavaObject());

	result = (WmGroup)WmGlobal::createWmObject(jenv_, jresult, 1);
	return result;
}

int _WmUser :: isAdministrator(){
	jboolean jbool;

	jbool = jenv_->CallBooleanMethod(jobj_, mid_isAdministrator_ );
	return (jbool == JNI_TRUE ? 1 : 0);
}

void _WmUser :: initializeMethods()
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

			cid_ = WmGlobal::getClassRef( WMUSER );
			checkExceptions();

			mid_constructor_ = jenv_->GetMethodID(
					cid_,
					"<init>",
					"()V" );

			checkExceptions();

			mid_add_Group_ = jenv_->GetMethodID(
					cid_,
					"add",
					"(Lcom/wm/app/b2b/server/Group;)Lcom/wm/app/b2b/server/Group;" );
			
			checkExceptions();

			mid_isAdministrator_ = jenv_->GetMethodID(
					cid_,
					"isAdministrator",
					"()Z");

			checkExceptions();

			WmGlobal::monitorExit( jenv_ );
		}
		catch( WmException &ex )
		{
			throw ex;
		}
	}
}



