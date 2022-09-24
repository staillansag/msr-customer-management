#include "WmIDataCursor.h"
#include "WmGlobal.h"
#include "WmString.h"
#include "WmObject.h"

jmethodID _WmIDataCursor::mid_constructor_;
jmethodID _WmIDataCursor::mid_getKey_;
jmethodID _WmIDataCursor::mid_getValue_;
jmethodID _WmIDataCursor::mid_setKey_String_;
jmethodID _WmIDataCursor::mid_setValue_Object_;
jmethodID _WmIDataCursor::mid_delete_;
jmethodID _WmIDataCursor::mid_insertBefore_String_Object_;
jmethodID _WmIDataCursor::mid_insertAfter_String_Object_;
jmethodID _WmIDataCursor::mid_insertDataBefore_String_;
jmethodID _WmIDataCursor::mid_insertDataAfter_String_;
jmethodID _WmIDataCursor::mid_next_;
jmethodID _WmIDataCursor::mid_next_String_;
jmethodID _WmIDataCursor::mid_previous_;
jmethodID _WmIDataCursor::mid_previous_String_;
jmethodID _WmIDataCursor::mid_first_;
jmethodID _WmIDataCursor::mid_first_String_;
jmethodID _WmIDataCursor::mid_last_;
jmethodID _WmIDataCursor::mid_last_String_;
jmethodID _WmIDataCursor::mid_hasMoreData_;
jmethodID _WmIDataCursor::mid_destroy_;
jmethodID _WmIDataCursor::mid_getCursorClone_;

jclass    _WmIDataCursor::cid_;

_WmIDataCursor::_WmIDataCursor( JNIEnv *jenv ) : _WmObject( jenv )
{
	initializeMethods();

	jobj_ = jenv_->NewObject( cid_, mid_constructor_ );

	manage_ref_ = 1;

	type_ = WMIDATACURSOR;

	checkExceptions();

}

_WmIDataCursor::_WmIDataCursor( JNIEnv *jenv, jobject idatacursor,
		                int manage_ref ) : _WmObject( jenv,
					             idatacursor, manage_ref)
{
	initializeMethods();

	type_ = WMIDATACURSOR;

	checkExceptions();
}

_WmIDataCursor::~_WmIDataCursor(){ }

WmString _WmIDataCursor :: getKey()
{
	jobject amc = NULL;
	WmString boom = NULL;
 	try
	{
	 	amc = jenv_->CallObjectMethod( jobj_, mid_getKey_ );

		checkExceptions();


		boom = (WmString)WmGlobal::createWmObject(jenv_, amc, 1);
	} catch ( WmException &ex )
	{
		throw ex;
	}

	return boom;
}

WmObject _WmIDataCursor :: getValue()
{
	jobject jobj = NULL;
	WmObject obj = NULL;

	try
	{
		jobj = jenv_->CallObjectMethod( jobj_, mid_getValue_ );

		checkExceptions();

		obj = WmGlobal::createWmObject( jenv_, jobj, 1 );
	} catch ( WmException &ex )
	{
		throw ex;
	}

	return obj;
}

void _WmIDataCursor :: setKey(char* key){
	WmString amc = new _WmString(jenv_, key);
	setKey(amc);
	delete amc;
}

void _WmIDataCursor :: setKey(WmString key)
{
	try{
		jenv_->CallVoidMethod( jobj_ , mid_setKey_String_ ,
				       key->getJavaObject() );

		checkExceptions();

	} catch ( WmException &ex )
	{
		throw ex;
	}
}

void _WmIDataCursor :: setValue(WmObject key)
{
	try{
		jenv_->CallVoidMethod( jobj_ , mid_setValue_Object_ , key->getJavaObject() );

		checkExceptions();

	} catch ( WmException &ex ){
		throw ex;
	}
}

void _WmIDataCursor :: insertBefore(char* key, WmObject value){
	WmString wmstr = new _WmString(jenv_, key);
	insertBefore(wmstr, value);
	delete wmstr;
}

void _WmIDataCursor :: insertBefore(WmString key, WmObject value){
	try
	{
		jenv_->CallVoidMethod( jobj_, mid_insertBefore_String_Object_,
				       key->getJavaObject(), value->getJavaObject());

		checkExceptions();
	} catch (WmException &ex){
		throw ex;
	}
}

int _WmIDataCursor :: Delete(){
	jboolean  jbool = JNI_FALSE;
	int       boo ;

	jbool = jenv_->CallBooleanMethod( jobj_ , mid_delete_ );

	boo = (jbool == JNI_TRUE) ? 1 : 0;

	checkExceptions();

	return boo;
}

void _WmIDataCursor :: insertAfter(char* key, WmObject value){
	try
	{
		WmString amc = new _WmString(jenv_, key);
		insertAfter(amc, value);
		delete amc;
	} catch( WmException &ex){
		throw ex;
	}
}

void _WmIDataCursor :: insertAfter(WmString key, WmObject value){
	try
	{
		key->getJavaObject();
		value->getJavaObject();
		jenv_->CallVoidMethod( jobj_, mid_insertAfter_String_Object_,
				       key->getJavaObject(), value->getJavaObject());

		checkExceptions();
	} catch (WmException &ex){
		throw ex;
	}
}

WmObject _WmIDataCursor :: insertDataBefore(char* key){
	WmString amc = new _WmString(jenv_, key);
	WmObject obj = insertDataBefore(amc);
	delete amc;
	return obj;
}
WmObject _WmIDataCursor :: insertDataBefore(WmString key){
	jobject obj;
	WmObject idata;

	try
	{
		obj = jenv_->CallObjectMethod( jobj_ ,
				               mid_insertDataBefore_String_,
					       key->getJavaObject() );
		idata = WmGlobal::createWmObject( jenv_, obj, 1);
	} catch (WmException &ex){
		throw ex;
	}

	return idata;
}

WmObject _WmIDataCursor :: insertDataAfter(char* key){
	WmString amc = new _WmString(jenv_, key);
	WmObject obj = insertDataAfter(amc);
	delete amc;
	return obj;
}

WmObject _WmIDataCursor :: insertDataAfter(WmString key){
	jobject obj;
	WmObject idata;

	try
	{
		obj = jenv_->CallObjectMethod( jobj_ ,
				               mid_insertDataAfter_String_,
					       key->getJavaObject() );
		idata = (WmIData)WmGlobal::createWmObject( jenv_, obj, 1);

		checkExceptions();

	} catch (WmException &ex){
		throw ex;
	}

	return idata;
}

int _WmIDataCursor :: next(){
	jboolean result = JNI_FALSE;
	int amc = 0;

	try
	{
		result = jenv_->CallBooleanMethod( jobj_ ,
				                   mid_next_ );

		checkExceptions();
	} catch (WmException &ex){
		throw ex;
	}

	amc = (result == JNI_TRUE) ? 1 : 0;

	return amc;
}

int _WmIDataCursor::next(char* key){
	int oogaboola = 0;
	WmString amc = new _WmString(jenv_, key);
 	oogaboola = next(amc);
	delete amc;
	return oogaboola;
}

int _WmIDataCursor::next(WmString key){
	jboolean jbool;
	int oogabool;

	jbool = jenv_->CallBooleanMethod( jobj_, mid_next_String_,
							key->getJavaObject());

	oogabool = (jbool == JNI_TRUE) ? 1 : 0;

	return oogabool;
}

int _WmIDataCursor :: previous(){
	jboolean result = JNI_FALSE;
	int amc = 0;

	try
	{
		result = jenv_->CallBooleanMethod( jobj_ ,
				                   mid_previous_ );

		checkExceptions();
	} catch (WmException &ex){
		throw ex;
	}

	amc = (result == JNI_TRUE) ? 1 : 0;

        return amc;
}

int _WmIDataCursor::previous(char* key){
	int oogaboola = 0;
	WmString amc = new _WmString(jenv_, key);
 	oogaboola = previous(amc);
	delete amc;
	return oogaboola;
}

int _WmIDataCursor::previous(WmString key){
	jboolean jbool;
	int oogabool;

	jbool = jenv_->CallBooleanMethod( jobj_, mid_previous_String_,
									key->getJavaObject());

	oogabool = (jbool == JNI_TRUE) ? 1 : 0;

	return oogabool;
}

int _WmIDataCursor :: first(){
	jboolean result = JNI_FALSE;
	int amc = 0;

	try
	{
		result = jenv_->CallBooleanMethod( jobj_ ,
				                   mid_first_ );

		checkExceptions();
	} catch (WmException &ex){
		throw ex;
	}

	amc = (result == JNI_TRUE) ? 1 : 0;

        return amc;
}

int _WmIDataCursor::first(char* key){
	int oogaboola = 0;
	WmString amc = new _WmString(jenv_, key);
 	oogaboola = first(amc);
	delete amc;
	return oogaboola;
}

int _WmIDataCursor::first(WmString key){
	jboolean jbool;
	int oogabool;

	jbool = jenv_->CallBooleanMethod( jobj_, mid_first_String_,
			                  key->getJavaObject());

	oogabool = (jbool == JNI_TRUE) ? 1 : 0;

	return oogabool;
}



int _WmIDataCursor :: last(){
	jboolean result = JNI_FALSE;
	int amc = 0;

	try
	{
		result = jenv_->CallBooleanMethod( jobj_ ,
				                   mid_last_ );

		checkExceptions();
	} catch (WmException &ex){
		throw ex;
	}

	amc = (result == JNI_TRUE) ? 1 : 0;

        return amc;
}

int _WmIDataCursor::last(char* key){
	int oogaboola = 0;
	WmString amc = new _WmString(jenv_, key);
 	oogaboola = last(amc);
	delete amc;
	return oogaboola;
}

int _WmIDataCursor::last(WmString key){
	jboolean jbool;
	int oogabool;

	jbool = jenv_->CallBooleanMethod( jobj_, mid_last_String_,
								key->getJavaObject());

	oogabool = (jbool == JNI_TRUE) ? 1 : 0;

	return oogabool;
}


int _WmIDataCursor :: hasMoreData(){
	jboolean result = JNI_FALSE;
	int amc = 0;

	try
	{
		result = jenv_->CallBooleanMethod( jobj_ ,
				                   mid_hasMoreData_ );

		checkExceptions();
	} catch (WmException &ex){
		throw ex;
	}

	amc = (result == JNI_TRUE) ? 1 : 0;

        return amc;
}

void _WmIDataCursor :: destroy(){
	jenv_->CallVoidMethod(jobj_ , mid_destroy_ );

	checkExceptions();
}

WmObject _WmIDataCursor :: getCursorClone(){
	jobject result = NULL;
	WmObject boom = NULL;

	try{
		result = jenv_->CallObjectMethod(jobj_, mid_getCursorClone_);

		boom   = WmGlobal::createWmObject( jenv_, result, 1);

		checkExceptions();

	}
	catch( WmException &ex){
		throw ex;
	}

	return boom;
}

void _WmIDataCursor :: initializeMethods()
//	throw( WmException )
{
	if( mid_constructor_ == NULL ){
		try{
			WmGlobal::monitorEnter( jenv_ );

			if(mid_constructor_ != NULL ){
				WmGlobal::monitorExit(jenv_);
				return;
			}

			cid_ = WmGlobal::getClassRef( WMIDATACURSOR );

			mid_getKey_ = jenv_->GetMethodID( cid_,
							  "getKey",
							  "()Ljava/lang/String;");

			checkExceptions();

			mid_getValue_ = jenv_->GetMethodID( cid_,
					 		    "getValue",
							    "()Ljava/lang/Object;");

			checkExceptions();

			mid_setKey_String_ = jenv_->GetMethodID( cid_,
					                         "setKey",
						"(Ljava/lang/String;)V" );

			checkExceptions();

			mid_setValue_Object_ = jenv_->GetMethodID(
					         cid_,
						 "setValue",
						 "(Ljava/lang/Object;)V");
			checkExceptions();

			mid_delete_ = jenv_->GetMethodID( cid_,
							  "delete",
							  "()Z");

			checkExceptions();

			mid_insertBefore_String_Object_ =
				jenv_->GetMethodID( cid_,
						    "insertBefore",
						    "(Ljava/lang/String;Ljava/lang/Object;)V" );

			checkExceptions();

			mid_insertAfter_String_Object_ =
				jenv_->GetMethodID(
						cid_,
						"insertAfter",
						"(Ljava/lang/String;Ljava/lang/Object;)V" );

			checkExceptions();

			mid_insertDataBefore_String_ =
				jenv_->GetMethodID( cid_,
						    "insertDataBefore",
						    "(Ljava/lang/String;)Lcom/wm/data/IData;" );

			checkExceptions();

			mid_insertDataAfter_String_ =
				jenv_->GetMethodID(
						cid_,
						"insertDataAfter",
						"(Ljava/lang/String;)Lcom/wm/data/IData;" );

			checkExceptions();

			mid_next_ = jenv_->GetMethodID( cid_,
					 		"next",
							"()Z" );
			checkExceptions();

			mid_next_String_ = jenv_->GetMethodID( cid_,
							"next",
							"(Ljava/lang/String;)Z" );
			checkExceptions();

			mid_previous_ = jenv_->GetMethodID( cid_,
							    "previous",
							    "()Z" );

			checkExceptions();

			mid_previous_String_ = jenv_->GetMethodID( cid_,
							    "previous",
							    "(Ljava/lang/String;)Z" );
			checkExceptions();

			mid_first_ = jenv_->GetMethodID(cid_,
					 		"first",
							"()Z" );

			checkExceptions();

			mid_first_String_ = jenv_->GetMethodID( cid_,
					 		 "first",
							 "(Ljava/lang/String;)Z");
			checkExceptions();


			mid_last_ = jenv_->GetMethodID(cid_,
						       "last",
						       "()Z" );
			checkExceptions();

			mid_last_String_ = jenv_->GetMethodID( cid_,
							"last",
							"(Ljava/lang/String;)Z");
			checkExceptions();


			mid_hasMoreData_ = jenv_->GetMethodID(
					    cid_,
					    "hasMoreData",
					    "()Z" );
			checkExceptions();

			mid_destroy_ = jenv_->GetMethodID(
					cid_,
					"destroy",
					"()V" );
			checkExceptions();

			mid_getCursorClone_ = jenv_->GetMethodID(
					cid_,
					"getCursorClone",
					"()Lcom/wm/data/IDataCursor;" );
			checkExceptions();

			/*mid_constructor_ = jenv_->GetMethodID(
					cid_,
					"<init>",
					"()V");

			checkExceptions();*/

			WmGlobal::monitorExit(jenv_);
		}
		catch( WmException &ex )
		{
			throw ex;
		}
	}
}



