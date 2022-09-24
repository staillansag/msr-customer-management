#ifndef WmObjectT_h
#define WmObjectT_h

#include <jni.h>
#include "WmPrefix.h"
#include "WmExceptions.h"

typedef enum 
{
	WMSTRING,
	WMSTRINGARRAY,
	WMVALUES, 
	WMVALUESARRAY, 
	WMOBJECT,
	WMOBJECTARRAY,
	WMSESSION,
	WMCONTEXT,
	WMINVALID
} WmObjectType;

template <class ObjType> class _WmObjectT
{
public:

	PREFIX _WmObject( JNIEnv *jenv );
	
	PREFIX _WmObject( JNIEnv *jenv, jobject obj, int manage_ref=0 );
	
	PREFIX ~_WmObject();

	PREFIX jobject getJavaObject();

	PREFIX WmObjectType getType();

protected:
	void checkExceptions() const;

	JNIEnv *jenv_;
	jobject jobj_;
	WmObjectType type_;
	int manage_ref_;
};

#endif
