#ifndef _WmIDataUtil_H_
#define _WmIDataUtil_H_

#include "WmIData.h"
#include "WmPrefix.h"
#include "WmString.h"
#include "WmStringArray.h"
#include "WmStringTable.h"
#include "WmObject.h"
#include "WmIDataCursor.h"



class _WmIDataUtil;

typedef _WmIDataUtil *WmIDataUtil;

class IMPORT_EXPORT_DLL _WmIDataUtil : public _WmObject
{

public:
	PREFIX _WmIDataUtil( JNIEnv *jenv );
	PREFIX _WmIDataUtil( JNIEnv *jenv , jobject idatautil,
		      int manage_ref=0);

	PREFIX ~_WmIDataUtil();

	PREFIX WmIData create(WmObject data);
	PREFIX int getBoolean(WmIDataCursor idc);
	PREFIX WmIData getIData(WmIDataCursor idc);
	PREFIX WmString getString(WmIDataCursor idc);
	PREFIX WmStringArray getStringArray(WmIDataCursor idc);
	PREFIX WmStringTable getStringTable(WmIDataCursor idc);
	PREFIX int getInt(WmIDataCursor idc, int defaut);
	PREFIX int getInt(WmIDataCursor idc);
	PREFIX void append(WmIData src, WmIData dst);
	PREFIX void merge(WmIData src, WmIData dst);
	PREFIX WmIData clone(WmIData src);

protected:
	void initializeMethods()
          throw( WmException );

	jint size_;

	static jmethodID	mid_create_Object_;
	static jmethodID	mid_constructor_;
	static jmethodID	mid_getBoolean_IDataCursor_;
	static jmethodID	mid_getIData_IDataCursor_;
	static jmethodID	mid_getString_IDataCursor_;
	static jmethodID	mid_getStringArray_IDataCursor_;
	static jmethodID	mid_getStringTable_IDataCursor_;
	static jmethodID	mid_getInt_IDataCursor_int_;
	static jmethodID	mid_getInt_IDataCursor_;
	static jmethodID	mid_append_IData_IData_;
	static jmethodID	mid_merge_IData_IData_;
	static jmethodID	mid_clone_IData_;

	static jclass		cid_;

};

#endif
