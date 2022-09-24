#ifndef WmObject_h
#define WmObject_h

#include <jni.h>
#include "WmPrefix.h"
#include "WmException.h"

class _WmObject;

typedef _WmObject *WmObject;

typedef enum 
{
	WMSTRING,
	WMSTRINGARRAY,
	WMSTRINGTABLE,
	WMVALUES, 
	WMDATE, 
	WMGROUP, 
	WMUSER, 
	WMVALUESARRAY, 
	WMIDATA,
	WMIDATAARRAY,
	WMIDATAUTIL,
	WMGENUTIL,
	WMIDATACODABLE,
	WMIDATACURSOR,
	WMIDATAFACTORY,
	WMIDATAINDEXCURSOR,
	WMIDATAHASHCURSOR,
	WMIDATATREECURSOR,
	WMOBJECT,
	WMOBJECTARRAY,
	WMSESSION,
	WMCONTEXT,
	WMBASECONTEXT,
	WMTCONTEXT,
	WMEXCEPTION,
	WMVECTOR,
	WMTABLE,
	WMBINCODER,
	WMINVOKETHREAD,
	WMINVALID
} WmObjectType;

class IMPORT_EXPORT_DLL _WmObject
{
public:

	PREFIX _WmObject( JNIEnv *jenv );
	
	PREFIX _WmObject( JNIEnv *jenv, jobject obj, int manage_ref=0 );
	
	PREFIX virtual ~_WmObject();

	PREFIX jobject getJavaObject();

	PREFIX WmObjectType getType();

	PREFIX void setManageRef(int newval) {manage_ref_ = newval;}

	PREFIX static void setDontManageRef();

protected:
	void checkExceptions() const;

	JNIEnv *jenv_;
	jobject jobj_;
	WmObjectType type_;
	int manage_ref_;

	static bool localRef_;
};

#endif
