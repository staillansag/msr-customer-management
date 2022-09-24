#ifndef _WmStringTable_H_
#define _WmStringTable_H_

#include "WmObject.h"
#include "WmPrefix.h"
#include "WmStringArray.h"
#include "WmString.h"


class _WmStringTable;

typedef _WmStringTable *WmStringTable;

class IMPORT_EXPORT_DLL _WmStringTable : public _WmObject
{
	public:
		PREFIX _WmStringTable(JNIEnv* jenv);
		PREFIX _WmStringTable(JNIEnv* jenv, jobjectArray jobj, 
			       int manage_ref = 0);

		PREFIX _WmStringTable(JNIEnv* jenv, int rows, int cols);
		
		PREFIX int rows();
		PREFIX int columns();

		PREFIX WmStringArray getRow(int row);
		PREFIX WmString getValue(int row, int column);

		PREFIX void setRow(int row, WmStringArray strarray);
		PREFIX void setElement(int row, int cols, WmString str);
	protected:
		void initializeMethods()
			throw (WmException);

		static jclass cid_;
		static jclass cid_java_lang_String_;
		static jclass cid_java_lang_String_Array_;
		jobjectArray jstrtable_;
		int rows_, cols_;

};

#endif
