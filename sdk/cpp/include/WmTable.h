#ifndef WmTable_h
#define WmTable_h

#include "WmObject.h"
#include "WmObjectArray.h"
#include "WmPrefix.h"
#include "WmValues.h"
#include "WmValuesArray.h"
#include "WmIData.h"
#include "WmIDataArray.h"
#include "WmString.h"
#include "WmStringArray.h"

class _WmTable;

typedef _WmTable *WmTable;

class IMPORT_EXPORT_DLL _WmTable : public _WmObject
{
public:
	PREFIX _WmTable( JNIEnv *env );
	PREFIX _WmTable( JNIEnv *env, WmStringArray cols);
	PREFIX _WmTable( JNIEnv *env, char*, WmStringArray cols);
	PREFIX _WmTable( JNIEnv *env, jobject table, int manage_ref=0 );
	PREFIX virtual ~_WmTable();

	PREFIX jint 		getRowCount();
	PREFIX void 		addRow(WmObjectArray v);
	PREFIX void 		addRow(WmStringArray v);
	PREFIX void 		deleteRow(int idx);
	PREFIX void 		setIData(WmIData id);
	PREFIX void 		setValue(WmString key, WmObject val);
	PREFIX void 		putItemAt(WmIData item, int idx);
	PREFIX void 		putItems(WmIDataArray items);
	PREFIX void	 	deleteItemAt(int idx);
	PREFIX int 		getSize();
	PREFIX void 		setCols(WmStringArray cols);
	PREFIX void 		setCols(jobjectArray cols);
	PREFIX void 		setName(char* name);
	PREFIX void 		setName(WmString name);
	PREFIX WmStringArray 	getColumnNames();
	PREFIX WmStringArray 	getValueKeys();
	PREFIX WmString 	toString();
	PREFIX WmIDataArray 	getItems();
	PREFIX WmIData 	getIData();
	PREFIX WmIData 	getItemAt(int idex);
	PREFIX WmObject 	getValue(WmString key);

	// For backward compatibility

	PREFIX WmValues 	toValues();
	PREFIX WmValuesArray 	getValues();
	PREFIX void 		addRow(WmValues v);
	PREFIX void		updateRow(int idx, WmValues v);
	PREFIX void 		insertRow(int idx, WmValues v);
	PREFIX void	 	appendRows(WmValuesArray v);
	PREFIX void 		setRows(WmValuesArray v);
	PREFIX WmValues 	getRow( int idx );


protected:
	void initializeMethods()
	  throw( WmException );

	int cols_initialized_;  // the String[] cols object has to be
				 // initialized in the Table object for
				 // correct operation. this is a flag
				 // so that the class can alert the user
				 // of not initializing this object, and
				 // thus the reason of malfunction.

	void colsWarning();

	static jmethodID	mid_constructor_;
	static jmethodID	mid_getRow_int_;
	static jmethodID	mid_getRowCount_;
	static jmethodID	mid_getValues_;
	static jmethodID	mid_addRow_Values_;
	static jmethodID	mid_addRow_ObjectArray_;
	static jmethodID	mid_deleteRow_int_;
	static jmethodID	mid_updateRow_int_Values_;
	static jmethodID	mid_insertRow_int_Values_;
	static jmethodID	mid_getColumnNames_;
	static jmethodID	mid_toValues_;
	static jmethodID	mid_appendRows_ValuesArray_;
	static jmethodID	mid_setRows_ValuesArray_;
	static jmethodID	mid_createRow_Values_;
	static jmethodID	mid_createRow_IData_;
	static jmethodID	mid_toString_;
	static jmethodID	mid_getIData_;
	static jmethodID	mid_setIData_IData_;
	static jmethodID	mid_getValue_String_;
	static jmethodID	mid_setValue_String_Object_;
	static jmethodID	mid_getValueKeys_;
	static jmethodID	mid_putItemAt_IData_int_;
	static jmethodID	mid_getItemAt_int_;
	static jmethodID	mid_putItems_IDataArray_;
	static jmethodID	mid_getItems_;
	static jmethodID	mid_deleteItemAt_int_;
	static jmethodID	mid_getSize_;


	static jclass	cid_;
};


#endif
