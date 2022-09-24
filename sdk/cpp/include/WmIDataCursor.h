#ifndef _WmIDataCursor_H_
#define _WmIDataCursor_H_

#include "WmString.h"
#include "WmPrefix.h"
#include "WmObject.h"

class _WmIDataCursor;
typedef _WmIDataCursor *WmIDataCursor;
class IMPORT_EXPORT_DLL _WmIDataCursor : public _WmObject {
	public:
		PREFIX _WmIDataCursor( JNIEnv *jenv );

      	PREFIX _WmIDataCursor( JNIEnv *jenv, jobject idatacursor,
			int manage_ref=0);

		PREFIX ~_WmIDataCursor();

		PREFIX WmString  getKey();

		PREFIX WmObject  getValue();

		PREFIX void setKey(WmString key);
		PREFIX void setKey(char* key);

		PREFIX void setValue(WmObject value);

		PREFIX int Delete();
		PREFIX void insertBefore(WmString key, WmObject value);
		PREFIX void insertBefore(char* key, WmObject value);
		PREFIX void insertAfter(WmString key, WmObject value);
		PREFIX void insertAfter(char* key, WmObject value);
		PREFIX WmObject insertDataBefore(WmString key);
		PREFIX WmObject insertDataBefore(char* key);
		PREFIX WmObject insertDataAfter(WmString key);
		PREFIX WmObject insertDataAfter(char* key);

		PREFIX int next();
		PREFIX int next(WmString key);
		PREFIX int next(char* key);

		PREFIX int previous();
		PREFIX int previous(WmString key);
		PREFIX int previous(char* key);

		PREFIX int first();
		PREFIX int first(char* key);
		PREFIX int first(WmString key);

		PREFIX int last();
		PREFIX int last(WmString key);
		PREFIX int last(char* key);

		PREFIX int hasMoreData();
		PREFIX void destroy();

		PREFIX WmObject getCursorClone();

	protected:
	 	void initializeMethods();

		static jmethodID	mid_constructor_;
		static jmethodID	mid_getKey_;
		static jmethodID	mid_getValue_;
		static jmethodID	mid_setKey_String_;
		static jmethodID	mid_setValue_Object_;
		static jmethodID	mid_delete_;
		static jmethodID	mid_insertBefore_String_Object_;
		static jmethodID	mid_insertAfter_String_Object_;
		static jmethodID	mid_insertDataBefore_String_;
		static jmethodID	mid_insertDataAfter_String_;
		static jmethodID	mid_next_;
		static jmethodID 	mid_next_String_;
		static jmethodID	mid_previous_;
		static jmethodID    mid_previous_String_;
		static jmethodID	mid_first_;
		static jmethodID    mid_first_String_;
		static jmethodID	mid_last_;
		static jmethodID    mid_last_String_;
		static jmethodID	mid_hasMoreData_;
		static jmethodID	mid_destroy_;
		static jmethodID	mid_getCursorClone_;

		static jclass		cid_;
};


#endif


