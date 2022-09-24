#include "WmStringArray.h"
#include "WmGlobal.h"

_WmStringArray::_WmStringArray( JNIEnv *env, jint size ) : 
	_WmObjectArrayT<WmString>( env, WMSTRING, size )
{
	type_ = WMSTRINGARRAY;
}

_WmStringArray::_WmStringArray( JNIEnv *env, jobjectArray obj_array, int manage_ref ) : 
	_WmObjectArrayT<WmString>( env, obj_array, WMSTRING, manage_ref )
{
	type_ = WMSTRINGARRAY;
}

