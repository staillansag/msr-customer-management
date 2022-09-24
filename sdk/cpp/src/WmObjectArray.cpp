#include "WmObjectArray.h"
#include "WmGlobal.h"

static _WmObjectArrayT<WmObject> *_wmobj;

_WmObjectArray::_WmObjectArray( JNIEnv *env, jint size ) :
	_WmObjectArrayT<WmObject>( env, WMOBJECT, size )
{
	type_ = WMOBJECTARRAY;
}

_WmObjectArray::_WmObjectArray( JNIEnv *env, jobjectArray obj_array, int manage_ref ) : 
	_WmObjectArrayT<WmObject>( env, obj_array, WMOBJECT, manage_ref )
{
	type_ = WMOBJECTARRAY;
}

_WmObjectArray::~_WmObjectArray()
{
}
