#ifndef WmObjectArray_h
#define WmObjectArray_h

#include "WmObject.h"
#include "WmPrefix.h"
#include "WmObjectArrayT.h"

class _WmObjectArray;

typedef _WmObjectArray *WmObjectArray;

class _WmObjectArray : public _WmObjectArrayT<WmObject>
{
public:
	IMPORT_EXPORT_DLL PREFIX _WmObjectArray( JNIEnv *env, jint size );
	
	IMPORT_EXPORT_DLL PREFIX _WmObjectArray( JNIEnv *env, jobjectArray obj_array, int manage_ref );

	IMPORT_EXPORT_DLL PREFIX ~_WmObjectArray();
protected:
};

#endif
