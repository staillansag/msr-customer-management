#ifndef WmStringArray_h
#define WmStringArray_h

#include "WmString.h"
#include "WmPrefix.h"
#include "WmObjectArrayT.h"

class _WmStringArray;

typedef _WmStringArray *WmStringArray;

class _WmStringArray : public _WmObjectArrayT<WmString>
{
public:
	IMPORT_EXPORT_DLL PREFIX _WmStringArray( JNIEnv *env, jint size );
	
	IMPORT_EXPORT_DLL PREFIX _WmStringArray( JNIEnv *env, jobjectArray obj_array, int manage_ref );
};

#endif
