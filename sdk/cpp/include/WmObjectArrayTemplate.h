#ifndef WmObjectArrayTemplate_h
#define WmObjectArrayTemplate_h

#include "WmObject.h"
#include "WmPrefix.h"

template <class WmArrayType> class _WmObjectArrayTemplate;

typedef _WmObjectArray *WmObjectArray;

class IMPORT_EXPORT_DLL _WmObjectArray : public _WmObject
{
public:
	PREFIX _WmObjectArray( JNIEnv *env, WmObjectType type, jint size=10 );
	
	PREFIX _WmObjectArray( JNIEnv *env, jobjectArray obj_array, WmObjectType type, int manage_ref );

	PREFIX ~_WmObjectArray();

	PREFIX jobjectArray getJavaObjectArray();

	PREFIX WmObject getElement( jint idx );

	PREFIX void setElement( jint idx, WmObject obj );

	PREFIX void setElement( jint idx, jobject jobj );

	PREFIX jint length();

protected:
	jobjectArray jobj_array_;
	WmObjectType element_type_;

	WmObject *wmobj_array_;
	jint size_;
};

#endif
