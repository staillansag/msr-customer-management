#ifndef WmObjectArrayT_h
#define WmObjectArrayT_h

#include "WmObject.h"
#include "WmPrefix.h"


template <class ObjType> class _WmObjectArrayT : public _WmObject
{
public:
	IMPORT_EXPORT_DLL PREFIX _WmObjectArrayT( JNIEnv *env, WmObjectType element_type, jint size );

	IMPORT_EXPORT_DLL PREFIX _WmObjectArrayT( JNIEnv *env, jobjectArray obj_array, WmObjectType element_type, int manage_ref=0 );

	IMPORT_EXPORT_DLL PREFIX ~_WmObjectArrayT();

	IMPORT_EXPORT_DLL PREFIX jobjectArray getJavaObjectArray();

	IMPORT_EXPORT_DLL PREFIX ObjType getElement( jint idx );

	IMPORT_EXPORT_DLL PREFIX void setElement( jint idx, ObjType obj );

	IMPORT_EXPORT_DLL PREFIX jint length();

protected:
	jobjectArray jobj_array_;
	WmObjectType element_type_;

	ObjType *wmobj_array_;
	jint size_;
};

#endif
