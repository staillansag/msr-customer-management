#include "WmIDataUtil.h"
#include "WmIDataCursor.h"
#include "WmStringArray.h"
#include "WmStringTable.h"
#include "WmGlobal.h"

jmethodID _WmIDataUtil::mid_constructor_;
jmethodID _WmIDataUtil::mid_create_Object_;
jmethodID _WmIDataUtil::mid_getBoolean_IDataCursor_;
jmethodID _WmIDataUtil::mid_getIData_IDataCursor_;
jmethodID _WmIDataUtil::mid_getString_IDataCursor_;
jmethodID _WmIDataUtil::mid_getStringArray_IDataCursor_;
jmethodID _WmIDataUtil::mid_getStringTable_IDataCursor_;
jmethodID _WmIDataUtil::mid_getInt_IDataCursor_int_;
jmethodID _WmIDataUtil::mid_getInt_IDataCursor_;
jmethodID _WmIDataUtil::mid_append_IData_IData_;
jmethodID _WmIDataUtil::mid_merge_IData_IData_;
jmethodID _WmIDataUtil::mid_clone_IData_;

jclass _WmIDataUtil::cid_ ;

_WmIDataUtil :: _WmIDataUtil ( JNIEnv *env ) : _WmObject( env )
{
	initializeMethods();

	jobj_ = jenv_->NewObject( cid_,
				  mid_constructor_ );

	manage_ref_ = 1;

	checkExceptions();

	type_ = WMIDATAUTIL;
}

_WmIDataUtil :: _WmIDataUtil( JNIEnv *env, jobject idatautil, int manage_ref ) : _WmObject( env, idatautil, manage_ref ) 
{
	initializeMethods();

	type_ = WMIDATAUTIL;
}

_WmIDataUtil::~_WmIDataUtil() { } 


WmIData _WmIDataUtil :: create(WmObject data){
	WmIData results;
	jobject jresults;

	jresults = jenv_->CallObjectMethod(
	 	   jobj_,
		   mid_create_Object_,
		   data->getJavaObject() );
	checkExceptions();

	results = (WmIData)WmGlobal::createWmObject(jenv_, jresults);

	checkExceptions();

	return results;
}


int _WmIDataUtil :: getBoolean(WmIDataCursor idc){
	jboolean west;
	int amc;

	west = jenv_->CallBooleanMethod(jobj_,
				 mid_getBoolean_IDataCursor_,
				 idc->getJavaObject() );
	checkExceptions();

	amc = (west == JNI_TRUE) ? 1 : 0;

	return amc;
}

WmIData _WmIDataUtil :: getIData(WmIDataCursor idc){
	jobject jo;
	WmIData idata;

	jo = jenv_->CallObjectMethod(jobj_,
			      mid_getIData_IDataCursor_,
			      idc->getJavaObject() );
	checkExceptions();

        idata = (WmIData)WmGlobal::createWmObject(jenv_, jo );

	return idata;
}

WmString _WmIDataUtil :: getString(WmIDataCursor idc){
	jobject ooga;
	WmString result;

	ooga = jenv_->CallObjectMethod(jobj_,
				mid_getString_IDataCursor_,
				idc->getJavaObject() );

	checkExceptions();

	result = (WmString)WmGlobal::createWmObject(jenv_, ooga);

	return result;
}

WmStringArray _WmIDataUtil :: getStringArray(WmIDataCursor idc){
	WmStringArray result;
	jobject ooga;

	ooga = jenv_->CallObjectMethod(jobj_,
				mid_getStringArray_IDataCursor_,
			 	idc->getJavaObject() );

	result = (WmStringArray)WmGlobal::createWmObject(jenv_, ooga, 1);

	return result;
}

WmStringTable _WmIDataUtil :: getStringTable(WmIDataCursor idc){
	WmStringTable result;
	jobject ooga;

	ooga = jenv_->CallObjectMethod(jobj_,
				mid_getStringArray_IDataCursor_,
			 	idc->getJavaObject() );

	result = (WmStringTable)WmGlobal::createWmObject(jenv_, ooga, 1);

	return result;
}



int _WmIDataUtil :: getInt(WmIDataCursor idc, int defaut){
	jint jresult;
	int  result;

	jresult = jenv_->CallIntMethod(jobj_,
				mid_getInt_IDataCursor_int_,
				idc->getJavaObject(), (jint)defaut);

	result = (int)jresult;

	return result;
}

int _WmIDataUtil :: getInt(WmIDataCursor idc){
	jint jresult;
	int result;

	jresult = jenv_->CallIntMethod(jobj_,
				mid_getInt_IDataCursor_,
				idc->getJavaObject() );

	result = (int)jresult;

	return result;
}

void _WmIDataUtil :: append(WmIData src, WmIData dst){
	jenv_->CallVoidMethod( jobj_,
		        mid_append_IData_IData_,
			src->getJavaObject(), dst->getJavaObject() );

	checkExceptions();

}

void _WmIDataUtil :: merge(WmIData src, WmIData dst){
	jenv_->CallVoidMethod( jobj_,
			mid_merge_IData_IData_,
			src->getJavaObject(), dst->getJavaObject() );

	checkExceptions();
}

WmIData _WmIDataUtil :: clone ( WmIData src ){
	jobject jobj;
	WmIData idata;

	jobj =  jenv_->CallObjectMethod( jobj_, 
					 mid_clone_IData_,
					 src->getJavaObject() );

	idata = (WmIData)WmGlobal::createWmObject(jenv_, jobj_);

	return idata;
}

void _WmIDataUtil :: initializeMethods()
	throw( WmException )
{
	if( cid_ == NULL )
	{
		try
		{
			WmGlobal :: monitorEnter( jenv_ );

			if( cid_ != NULL )
			{
				WmGlobal :: monitorExit( jenv_ );
				return;
			}

			cid_ = WmGlobal::getClassRef( WMIDATAUTIL );

			checkExceptions();

			/*mid_constructor_ = jenv_->GetMethodID(cid_,
							      "<init>",
							      "()V" );*/

			mid_create_Object_ = jenv_->GetMethodID(
					 	cid_,
						"create",
						"(Ljava/lang/Object;)Lcom/wm/data/IData;" );

			mid_getBoolean_IDataCursor_ = jenv_->GetMethodID(
					cid_,
					"getBoolean",
					"(Lcom/wm/data/IDataCursor;)Z" );

			mid_getIData_IDataCursor_ = jenv_->GetMethodID(
					cid_,
					"getIData",
					"(Lcom/wm/data/IDataCursor;)Z" );

			mid_getString_IDataCursor_ = jenv_->GetMethodID(
					cid_,
					"getString",
					"(Lcom/wm/data/IDataCursor;)Z" );

			mid_getStringArray_IDataCursor_ = jenv_->GetMethodID(
					cid_,
					"getStringArray",
					"(Lcom/wm/data/IDataCursor;)Z" );

			mid_getStringTable_IDataCursor_ = jenv_->GetMethodID(
					cid_,
					"getStringTable",
					"(Lcom/wm/data/IDataCursor;)Z" );

			mid_getInt_IDataCursor_int_ = jenv_->GetMethodID(
					cid_,
					"getInt",
					"(Lcom/wm/data/IDataCursor;)I" );

			mid_append_IData_IData_ = jenv_->GetMethodID(
					cid_,
					"append",
					"(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;" );

			mid_clone_IData_ = jenv_->GetMethodID(
					cid_, 
					"clone",
					"(Ljava/lang/Object;)Z" );

			checkExceptions();

		}
		catch ( WmException &ex)
		{ 
			throw(ex);
		}
	}
}
			
