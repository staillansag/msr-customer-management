#include "WmValuesArray.h"
#include "WmGlobal.h"

static _WmObjectArrayT<WmValues> *_wmobj;

_WmValuesArray::_WmValuesArray( JNIEnv *env, jint size ) : 
	_WmObjectArrayT<WmValues>( env, WMVALUES, size )
{
	type_ = WMVALUESARRAY;
}

_WmValuesArray::_WmValuesArray( JNIEnv *env, jobjectArray obj_array, int manage_ref ) : 
	_WmObjectArrayT<WmValues>( env, obj_array, WMVALUES, manage_ref )
{
	type_ = WMVALUESARRAY;
}
