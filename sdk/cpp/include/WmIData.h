#ifndef _WmIData_H_
#define _WmIData_H_

#include <jni.h>
#include "WmPrefix.h"
#include "WmObject.h"
#include "WmString.h"
#include "WmIDataCursor.h"
#include "WmIDataIndexCursor.h"
#include "WmIDataTreeCursor.h"
#include "WmIDataHashCursor.h"

class _WmIData;

typedef _WmIData *WmIData;

class IMPORT_EXPORT_DLL _WmIData : public _WmObject 
{

public:
	PREFIX _WmIData( JNIEnv *jenv );

	PREFIX _WmIData( JNIEnv *jenv, jobject idata, int manage_ref=0);

	PREFIX virtual ~_WmIData();

	PREFIX WmString toString();

        PREFIX WmIDataCursor getCursor();
	PREFIX WmIDataIndexCursor  getIndexCursor ();
	PREFIX WmIDataHashCursor   getHashCursor  ();
	PREFIX WmIDataTreeCursor   getTreeCursor  ();

protected:
	void initializeMethods()
	  throw( WmException );

	jint size_;

	static jmethodID	mid_getCursor_;
	static jmethodID	mid_getIndexCursor_;
	static jmethodID	mid_getHashCursor_;
	static jmethodID	mid_getTreeCursor_;
	static jmethodID	mid_constructor_;

	static jclass 		cid_;

};

#endif /* _WmIData_H_ */
