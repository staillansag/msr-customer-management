#ifndef WmValuesArray_h
#define WmValuesArray_h

#include "WmValues.h"
#include "WmPrefix.h"
#include "WmObjectArrayT.h"

class _WmValuesArray;

typedef _WmValuesArray *WmValuesArray;

class _WmValuesArray : public _WmObjectArrayT<WmValues>
{
public:
	IMPORT_EXPORT_DLL PREFIX _WmValuesArray( JNIEnv *env, jint size );
	
	IMPORT_EXPORT_DLL PREFIX _WmValuesArray( JNIEnv *env, jobjectArray obj_array, int manage_ref );
};

#endif
