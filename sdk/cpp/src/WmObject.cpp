#include "WmObject.h"
#include "WmGlobal.h"

bool _WmObject::localRef_ = true;

_WmObject::_WmObject( JNIEnv *jenv ) :
	jobj_(NULL)
{
	jenv_ = jenv;
	type_ = WMINVALID;
	manage_ref_ = 0;
}

_WmObject::_WmObject( JNIEnv *jenv, jobject obj, int manage_ref ) :
	manage_ref_(manage_ref)
{
	jenv_ = jenv;
	jobj_ = obj;
	type_ = WMOBJECT;

	checkExceptions();
}

_WmObject::~_WmObject()
{
	if( manage_ref_ && localRef_) 
	{
		jenv_->DeleteLocalRef( jobj_ );

		checkExceptions();
	}
}

jobject _WmObject::getJavaObject()
{
	return jobj_;
}

WmObjectType _WmObject::getType()
{
	return type_;
}

void _WmObject::checkExceptions() const
{ 
	WmGlobal::checkExceptions( jenv_ ); 
}

void _WmObject :: setDontManageRef()
{
	localRef_ = false;
}
