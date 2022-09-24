#ifndef WmIDataArray_h
#define WmIDataArray_h

#include "WmIData.h"
#include "WmPrefix.h"
#include "WmObjectArrayT.h"

class _WmIDataArray;

typedef _WmIDataArray *WmIDataArray;

class _WmIDataArray : public _WmObjectArrayT<WmIData>
{
	public:
		IMPORT_EXPORT_DLL PREFIX _WmIDataArray( JNIEnv *env, jint size);
		IMPORT_EXPORT_DLL PREFIX _WmIDataArray( JNIEnv *env, jobjectArray obj_array, 
			       int manage_ref );
};

#endif
