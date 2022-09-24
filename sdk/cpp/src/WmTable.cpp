#include "WmTable.h"
#include "WmGlobal.h"
#include <iostream>
using namespace std;

jmethodID	_WmTable::mid_constructor_;
jmethodID	_WmTable::mid_getRow_int_;
jmethodID	_WmTable::mid_getRowCount_;
jmethodID	_WmTable::mid_getValues_;
jmethodID	_WmTable::mid_addRow_Values_;
jmethodID	_WmTable::mid_addRow_ObjectArray_;
jmethodID	_WmTable::mid_deleteRow_int_;
jmethodID	_WmTable::mid_updateRow_int_Values_;
jmethodID	_WmTable::mid_insertRow_int_Values_;
jmethodID	_WmTable::mid_getColumnNames_;
jmethodID	_WmTable::mid_toValues_;
jmethodID	_WmTable::mid_appendRows_ValuesArray_;
jmethodID	_WmTable::mid_setRows_ValuesArray_;
jmethodID	_WmTable::mid_createRow_Values_;
jmethodID	_WmTable::mid_createRow_IData_;
jmethodID	_WmTable::mid_toString_;
jmethodID	_WmTable::mid_getIData_;
jmethodID	_WmTable::mid_setIData_IData_;
jmethodID	_WmTable::mid_getValue_String_;
jmethodID	_WmTable::mid_setValue_String_Object_;
jmethodID	_WmTable::mid_getValueKeys_;
jmethodID	_WmTable::mid_putItemAt_IData_int_;
jmethodID	_WmTable::mid_getItemAt_int_;
jmethodID	_WmTable::mid_putItems_IDataArray_;
jmethodID	_WmTable::mid_getItems_;
jmethodID	_WmTable::mid_deleteItemAt_int_;
jmethodID	_WmTable::mid_getSize_;

jclass	_WmTable::cid_;

_WmTable::_WmTable( JNIEnv *jenv ) : _WmObject( jenv )
{
	initializeMethods();

	jobj_ = jenv_->NewObject(
		cid_,
		mid_constructor_ );

	manage_ref_ = 1;

	checkExceptions();

	type_ = WMTABLE;

	checkExceptions();
	cols_initialized_ = 0;
}

_WmTable::_WmTable( JNIEnv *jenv , WmStringArray cols) : _WmObject( jenv )
{
	jfieldID suckit;
	initializeMethods();

	jobj_ = jenv_->NewObject(
		cid_,
		mid_constructor_ );

	manage_ref_ = 1;

	checkExceptions();

	type_ = WMTABLE;
	suckit = jenv_->GetFieldID(cid_, "cols", "[Ljava/lang/String;");

	jenv_->SetObjectField(jobj_, suckit, cols->getJavaObject());

	checkExceptions();
	cols_initialized_ = 1;
}

_WmTable::_WmTable( JNIEnv *jenv , char* name, WmStringArray cols) :
          _WmObject( jenv )
{
	initializeMethods();

	jobj_ = jenv_->NewObject(
		cid_,
		mid_constructor_ );

	manage_ref_ = 1;

	checkExceptions();

	type_ = WMTABLE;

	setCols(cols);
	setName(name);

	checkExceptions();
	cols_initialized_ = 1;
}

_WmTable::_WmTable( JNIEnv *jenv, jobject table, int manage_ref ) :
	_WmObject(jenv, table, manage_ref)
{
	initializeMethods();

	type_ = WMTABLE;

	checkExceptions();
	cols_initialized_ = 1;
}

_WmTable::~_WmTable()
{
}

void _WmTable::setCols(WmStringArray cols)
{
	jfieldID fid = jenv_->GetFieldID(cid_, "cols", "[Ljava/lang/String;");

	jenv_->SetObjectField(jobj_, fid, cols->getJavaObject());

	cols_initialized_ = 1;
}

void _WmTable::setCols(jobjectArray cols)
{
	jfieldID fid = jenv_->GetFieldID(cid_, "cols", "[Ljava/lang/String;");

	jenv_->SetObjectField(jobj_, fid, cols);

	cols_initialized_ = 1;
}

void _WmTable::setName(char* name){
	WmString str = new _WmString(jenv_, name);
	setName(str);
	delete str;
}

void _WmTable::setName(WmString name){
	jfieldID fid = jenv_->GetFieldID(cid_, "name", "Ljava/lang/String;");

	jenv_->SetObjectField(jobj_, fid, name->getJavaObject());
}

void _WmTable::colsWarning()
{
	cerr << "WARNING!  Cols object is not initialized in class WmTable.";
	cerr << "\nInitialize with setCols(WmStringArray cols) or with the ";
	cerr << "\nconstructor WmTable(jenv, cols)!!!" << endl;
}


WmValues _WmTable::getRow( int idx )
{
	if(!cols_initialized_) colsWarning();
	WmValues values = NULL;
	jobject jobj = NULL;

	try
	{
		jobj = jenv_->CallObjectMethod(
			jobj_,
			mid_getRow_int_,
			idx );

		checkExceptions();

		values = (WmValues)WmGlobal::createWmObject( jenv_, jobj, 1 );
	}
	catch( WmException &ex )
	{
		throw ex;
	}

	return values;
}

jint _WmTable::getRowCount()
{
	jint rc = 0;

	rc = jenv_->CallIntMethod(
		jobj_,
		mid_getRowCount_ );

	checkExceptions();

	return rc;
}

WmValuesArray _WmTable::getValues()
{
	WmValuesArray values_array = NULL;
	jobject jobj = NULL;

	try
	{
		jobj = jenv_->CallObjectMethod(
			jobj_,
			mid_getValues_ );

		checkExceptions();

		values_array = (WmValuesArray)WmGlobal::createWmObject( jenv_, jobj, 1 );
	}
	catch( WmException &ex )
	{
		throw ex;
	}

	return values_array;
}

void _WmTable::addRow(WmObjectArray v){
	jenv_->CallVoidMethod(jobj_, mid_addRow_ObjectArray_,
			      v->getJavaObjectArray());

	checkExceptions();
}

void _WmTable::addRow(WmStringArray v){
	jenv_->CallVoidMethod(jobj_, mid_addRow_ObjectArray_,
			      v->getJavaObjectArray());

	checkExceptions();
}

void _WmTable::addRow(WmValues v){
	jenv_->CallVoidMethod(jobj_, mid_addRow_Values_,
			      v->getJavaObject());

	checkExceptions();
}

void _WmTable::deleteRow(int idx){
	jenv_->CallVoidMethod(jobj_, mid_deleteRow_int_, jint(idx));

	checkExceptions();
}

void _WmTable::updateRow(int idx, WmValues v){
	jenv_->CallVoidMethod(jobj_, mid_updateRow_int_Values_,
			      jint(idx), v->getJavaObject());

	checkExceptions();
}

void _WmTable::insertRow(int idx, WmValues v){
	if(!cols_initialized_) colsWarning();
	jenv_->CallVoidMethod(jobj_, mid_insertRow_int_Values_,
			      jint(idx), v->getJavaObject());

	checkExceptions();
}

WmStringArray _WmTable :: getColumnNames(){
	WmStringArray result;
	jobject jresult;

	jresult = jenv_->CallObjectMethod(jobj_, mid_getColumnNames_);

	result = (WmStringArray)WmGlobal::createWmObject(jenv_, jresult, 1);
	return result;
}

WmValues _WmTable :: toValues(){
	WmValues vals;
	jobject jvals;

	jvals = jenv_->CallObjectMethod(jobj_, mid_toValues_ );

	vals = (WmValues)WmGlobal::createWmObject(jenv_, jvals, 1);
	return vals;
}

void _WmTable :: appendRows(WmValuesArray v){
	jenv_->CallVoidMethod(jobj_, mid_appendRows_ValuesArray_,
			      v->getJavaObject());
	checkExceptions();
}


void _WmTable :: setRows(WmValuesArray v){
	if(!cols_initialized_) colsWarning();
	jenv_->CallVoidMethod(jobj_, mid_setRows_ValuesArray_,
			      v->getJavaObject());
	checkExceptions();
}

WmString _WmTable :: toString(){
	WmString a;
	jobject b;

	b = jenv_->CallObjectMethod(jobj_, mid_toString_ );

	a = (WmString)WmGlobal::createWmObject(jenv_, b, 1);
	return a;
}

WmIData _WmTable :: getIData(){
	WmIData a;
	jobject b;

	b = jenv_->CallObjectMethod(jobj_, mid_getIData_ );

	checkExceptions();

	a = (WmIData)WmGlobal::createWmObject(jenv_, b, 1);
	return a;
}

void _WmTable :: setIData(WmIData id){
	jenv_->CallVoidMethod(jobj_, mid_setIData_IData_, id->getJavaObject());

	checkExceptions();
}

WmObject _WmTable :: getValue(WmString key){
	WmObject a;
	jobject b;

	b = jenv_->CallObjectMethod(jobj_, mid_getValue_String_,
			            key->getJavaObject());

	checkExceptions();

	a = WmGlobal::createWmObject(jenv_, b, 1);
	return a;
}

void _WmTable:: setValue(WmString key, WmObject val){
	jenv_->CallVoidMethod(jobj_, mid_setValue_String_Object_,
			      key->getJavaObject(), val->getJavaObject());

	checkExceptions();
}

WmStringArray _WmTable :: getValueKeys(){
	WmStringArray a;
	jobject b;

	b = jenv_->CallObjectMethod(jobj_, mid_getValueKeys_ );

	checkExceptions();

	a = (WmStringArray)WmGlobal::createWmObject(jenv_, b, 1);
	return a;
}

void _WmTable :: putItemAt(WmIData item, int idx){
	jenv_->CallVoidMethod(jobj_, mid_putItemAt_IData_int_,
			      item->getJavaObject(), jint(idx));

	checkExceptions();
}

WmIData _WmTable :: getItemAt(int idx){
	WmIData a;
	jobject b;

	b = jenv_->CallObjectMethod(jobj_, mid_getItemAt_int_, jint(idx));

	checkExceptions();

	a = (WmIData)WmGlobal::createWmObject(jenv_, b, 1);
	return a;
}

void _WmTable :: putItems(WmIDataArray items){
	jenv_->CallVoidMethod(jobj_, mid_putItems_IDataArray_,
			      items->getJavaObject());

	checkExceptions();
}

WmIDataArray _WmTable :: getItems(){
	WmIDataArray a;
	jobject b;

	b = jenv_->CallObjectMethod(jobj_, mid_getItems_);

	a = (WmIDataArray)WmGlobal::createWmObject(jenv_, b, 1);
	return a;
}

void _WmTable :: deleteItemAt(int idx){
	jenv_->CallVoidMethod(jobj_, mid_deleteItemAt_int_, jint(idx));

	checkExceptions();
}

int _WmTable :: getSize(){
	int result;
	jint jresult;

	jresult = jenv_->CallIntMethod(jobj_, mid_getSize_ );
	checkExceptions();

	result = jresult;
	return result;
}





void _WmTable::initializeMethods()
  throw( WmException )
{
	if( mid_constructor_ == NULL )
	{
		try
		{
			WmGlobal::monitorEnter( jenv_ );

			if( mid_constructor_ != NULL )
			{
				WmGlobal::monitorExit( jenv_ );
				return;
			}
			cid_ = WmGlobal::getClassRef( WMTABLE );
			if(cid_ == NULL){
				cerr << "WMTABLE class ref is NULL";
				return;
			}

			mid_getRow_int_ = jenv_->GetMethodID(
				cid_,
				"getRow",
				"(I)Lcom/wm/util/Values;" );
			checkExceptions();

			mid_getRowCount_ = jenv_->GetMethodID(
				cid_,
				"getRowCount",
				"()I" );

			checkExceptions();

			mid_getValues_ = jenv_->GetMethodID(
				cid_,
				"getValues",
				"()[Lcom/wm/util/Values;" );

			checkExceptions();

			mid_addRow_Values_ = jenv_->GetMethodID(
				cid_,
				"addRow",
				"(Lcom/wm/util/Values;)V" );

			checkExceptions();

			mid_addRow_ObjectArray_ = jenv_->GetMethodID(
				cid_,
				"addRow",
				"([Ljava/lang/Object;)V" );

			checkExceptions();

			mid_deleteRow_int_ = jenv_->GetMethodID(
				cid_,
				"deleteRow",
				"(I)V" );

			checkExceptions();

			mid_updateRow_int_Values_ = jenv_->GetMethodID(
				cid_,
				"updateRow",
				"(ILcom/wm/util/Values;)V" );

			checkExceptions();

			mid_insertRow_int_Values_ = jenv_->GetMethodID(
				cid_,
				"insertRow",
				"(ILcom/wm/util/Values;)V" );

			checkExceptions();

			mid_getColumnNames_ = jenv_->GetMethodID(
				cid_,
				"getColumnNames",
				"()[Ljava/lang/String;" );

			checkExceptions();

			mid_toValues_ = jenv_->GetMethodID(
				cid_,
				"toValues",
				"()Lcom/wm/util/Values;" );

			checkExceptions();

			mid_appendRows_ValuesArray_ = jenv_->GetMethodID(
				cid_,
				"appendRows",
				"([Lcom/wm/util/Values;)V" );

			checkExceptions();

			mid_setRows_ValuesArray_ = jenv_->GetMethodID(
				cid_,
				"setRows",
				"([Lcom/wm/util/Values;)V" );

			checkExceptions();

			mid_createRow_Values_ = jenv_->GetMethodID(
				cid_,
				"createRow",
				"(Lcom/wm/util/Values;)[Ljava/lang/Object;" );

			checkExceptions();

			mid_createRow_IData_ = jenv_->GetMethodID(
				cid_,
				"createRow",
				"(Lcom/wm/data/IData;)[Ljava/lang/Object;" );

			checkExceptions();

			mid_toString_ = jenv_->GetMethodID(
				cid_,
				"toString",
				"()Ljava/lang/String;" );

			checkExceptions();

			mid_getIData_ = jenv_->GetMethodID(
				cid_,
				"getIData",
				"()Lcom/wm/data/IData;" );

			checkExceptions();

			mid_setIData_IData_ = jenv_->GetMethodID(
				cid_,
				"setIData",
				"(Lcom/wm/data/IData;)V" );

			checkExceptions();

			mid_getValue_String_ = jenv_->GetMethodID(
				cid_,
				"getValue",
				"(Ljava/lang/String;)Ljava/lang/Object;" );

			checkExceptions();

			mid_setValue_String_Object_ = jenv_->GetMethodID(
				cid_,
				"setValue",
				"(Ljava/lang/String;Ljava/lang/Object;)V" );

			checkExceptions();

			mid_getValueKeys_ = jenv_->GetMethodID(
				cid_,
				"getValueKeys",
				"()[Ljava/lang/String;" );

			checkExceptions();

			mid_putItemAt_IData_int_ = jenv_->GetMethodID(
				cid_,
				"putItemAt",
				"(Lcom/wm/data/IData;I)V" );

			checkExceptions();

			mid_getItemAt_int_ = jenv_->GetMethodID(
				cid_,
				"getItemAt",
				"(I)Lcom/wm/data/IData;" );

			checkExceptions();

			mid_putItems_IDataArray_ = jenv_->GetMethodID(
				cid_,
				"putItems",
				"([Lcom/wm/data/IData;)V" );

			checkExceptions();

			mid_getItems_ = jenv_->GetMethodID(
				cid_,
				"getItems",
				"()[Lcom/wm/data/IData;" );

			checkExceptions();

			mid_deleteItemAt_int_ = jenv_->GetMethodID(
				cid_,
				"deleteItemAt",
				"(I)V" );

			checkExceptions();

			mid_getSize_ = jenv_->GetMethodID(
				cid_,
				"getSize",
				"()I" );

			checkExceptions();

			mid_constructor_ = jenv_->GetMethodID(
				cid_,
				"<init>",
				"()V" );

			checkExceptions();

			WmGlobal::monitorExit( jenv_ );
		}
		catch( WmException &ex )
		{
			throw ex;
		}
	}
}
