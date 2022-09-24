#include "WmIDataArray.h"
#include "WmGlobal.h"

static _WmObjectArrayT<WmIData> *_wmobj;

_WmIDataArray::_WmIDataArray( JNIEnv *env, jint size ):
 	_WmObjectArrayT<WmIData>( env, WMIDATA, size )
{
	type_ = WMIDATAARRAY;
}

_WmIDataArray::_WmIDataArray( JNIEnv *env, jobjectArray obj_array, 
		int manage_ref ) :
           _WmObjectArrayT<WmIData>( env, obj_array, WMIDATA, manage_ref )
{
	type_ = WMIDATAARRAY;
}
