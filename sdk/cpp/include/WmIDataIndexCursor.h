#ifndef _WmIDataIndexCursor_H_
#define _WmIDataIndexCursor_H_

#include "WmObject.h"
#include "WmPrefix.h"
#include "WmIDataCursor.h"

class _WmIDataIndexCursor;

typedef _WmIDataIndexCursor *WmIDataIndexCursor;

class IMPORT_EXPORT_DLL _WmIDataIndexCursor : public _WmIDataCursor
{
	public:
		PREFIX _WmIDataIndexCursor ( JNIEnv *jenv );
		PREFIX _WmIDataIndexCursor ( JNIEnv *jenv, jobject indexcursor,
				      int manage_ref=0);
		PREFIX int  seek  (int index);
		PREFIX int   count ();
	protected:
		void initializeMethods();

		static jmethodID mid_constructor_;
		static jmethodID mid_seek_int_;
		static jmethodID mid_count_;
		static jclass    cid_;
};

#endif

