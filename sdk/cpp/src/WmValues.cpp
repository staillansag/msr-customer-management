#include "WmValues.h"
#include "WmGlobal.h"
#include "WmIData.h"

jmethodID _WmValues::mid_getValueKeys_Object_;
jmethodID _WmValues::mid_contains_Object_;
jmethodID _WmValues::mid_containsKey_String_;
jmethodID _WmValues::mid_get_int_;
jmethodID _WmValues::mid_isEmpty_;
jmethodID _WmValues::mid_toString_;
jmethodID _WmValues::mid_remove_String_;
jmethodID _WmValues::mid_get_String_;
jmethodID _WmValues::mid_put_Object_;
jmethodID _WmValues::mid_put_String_Object_;
jmethodID _WmValues::mid_size_;
jmethodID _WmValues::mid_constructor_;
jmethodID _WmValues::mid_use_IData_;
jclass _WmValues::cid_;

_WmValues::_WmValues( JNIEnv *jenv ) : _WmObject( jenv )
{
	initializeMethods();

	jobj_ = jenv_->NewObject(
		cid_,
		mid_constructor_ );

	manage_ref_ = 1;

	checkExceptions();

	size_ = jenv_->CallIntMethod(
		jobj_,
		mid_size_ );

	type_ = WMVALUES;

	checkExceptions();
}

_WmValues::_WmValues( JNIEnv *jenv, jobject values, int manage_ref ) : 
	_WmObject(jenv, values, manage_ref)
{
	initializeMethods();

	size_ = jenv_->CallIntMethod(
		jobj_,
		mid_size_ );

	type_ = WMVALUES;

	checkExceptions();
}

_WmValues::~_WmValues()
{
}

int _WmValues::contains( WmObject obj ) const
{
	jboolean jresult = JNI_FALSE;
	int result = 0;

	jresult = jenv_->CallBooleanMethod(
		jobj_,
		mid_contains_Object_,
		obj->getJavaObject() );

	checkExceptions();

	result = (jresult == JNI_TRUE) ? 1 : 0;

	return result;
}

WmValues _WmValues::use(JNIEnv *jenv, WmIData data){
	jclass cid = WmGlobal::getClassRef( WMVALUES );
	mid_use_IData_ = jenv->GetStaticMethodID(
		cid,
		"use",
		"(Lcom/wm/data/IData;)Lcom/wm/util/Values;");

	WmGlobal::checkExceptions(jenv);
	jobject jobj;
	WmValues obj;

	jobj = jenv->CallStaticObjectMethod(cid, mid_use_IData_, data->getJavaObject());

	obj = (WmValues)WmGlobal::createWmObject(jenv, jobj, 1);
	return obj;
}

WmString _WmValues::toString(){
	jobject jresult;
	WmString result;

	jresult = jenv_->CallObjectMethod(jobj_, mid_toString_ );

	result = (WmString)WmGlobal::createWmObject(jenv_, jresult, 1);
	return result;
}

int _WmValues::containsKey(char* key) const
{
	WmString amc = new _WmString(jenv_, key);
	int val = containsKey(amc);
	delete amc;
	return val;
}

int _WmValues::containsKey( jstring key ) const
{
	jboolean jresult = JNI_FALSE;
	int result = 0;

	jresult = jenv_->CallBooleanMethod(
		jobj_,
		mid_containsKey_String_,
		key );

	checkExceptions();

	result = (jresult == JNI_TRUE) ? 1 : 0;

	return result;
}

int _WmValues::containsKey( WmString key ) const
{
	jboolean jresult = JNI_FALSE;
	int result = 0;

	jresult = jenv_->CallBooleanMethod(
		jobj_,
		mid_containsKey_String_,
		key->getJavaObject() );

	checkExceptions();

	result = (jresult == JNI_TRUE) ? 1 : 0;

	return result;
}

WmObject _WmValues::get( int idx ) const
{
	WmObject value = NULL;
	jobject jobj = NULL;
		
	try
	{
		jobj = jenv_->CallObjectMethod(
			jobj_,
			mid_get_int_,
			idx );

		checkExceptions();

		value = WmGlobal::createWmObject( jenv_, jobj, 1 );
	}
	catch( WmException &ex )
	{
		throw ex;
	}
	
	return value;
}

int _WmValues::isEmpty() const
{
	jboolean jresult = JNI_FALSE;
	int result = 0;

	jresult = jenv_->CallBooleanMethod(
		jobj_,
		mid_isEmpty_ );

	checkExceptions();

	result = (jresult == JNI_TRUE) ? 1 : 0;

	return result;
}

WmObject _WmValues::remove( WmString key )
{
	WmObject value = NULL;
	
	value = remove( (jstring)key->getJavaObject() );

	return value;
}

WmObject _WmValues::remove( jobject key )
{
	WmObject value = NULL;
	jobject jobj = NULL;
		
	try
	{
		jobj = jenv_->CallObjectMethod(
			jobj_,
			mid_remove_String_,
			key );

		checkExceptions();

		value = WmGlobal::createWmObject( jenv_, jobj, 1 );
	}
	catch( WmException &ex )
	{
		throw ex;
	}
	
	return value;
}


WmObject _WmValues::remove( const char *key )
{
	jstring jkey = jenv_->NewStringUTF( key );
	WmObject value = NULL;

	checkExceptions();
	
	value = remove( jkey );

	jenv_->DeleteLocalRef( jkey );
		
	checkExceptions();
	
	return value;
}

WmObject _WmValues::get( jstring key ) const
{
	WmObject value = NULL;
	jobject jobj = NULL;
		
	try
	{
		jobj = jenv_->CallObjectMethod(
			jobj_,
			mid_get_String_,
			key );

		checkExceptions();

		value = WmGlobal::createWmObject( jenv_, jobj, 1 );
	}
	catch( WmException &ex )
	{
		throw ex;
	}
	
	return value;
}

WmObject _WmValues::get( const char *key ) const
{
	jstring jkey = jenv_->NewStringUTF( key );
	WmObject value = NULL;

	checkExceptions();
	
	value = get( jkey );

	jenv_->DeleteLocalRef( jkey );
		
	checkExceptions();
	
	return value;
}

WmObject _WmValues::get( WmString key ) const
{
	WmObject value = NULL;
	
	value = get( (jstring)key->getJavaObject() );

	return value;
}

jobject _WmValues::put( WmObject value )
{
	jobject jobj = NULL;

	jobj = jenv_->CallObjectMethod(
		jobj_,
		mid_put_Object_,
		value->getJavaObject() );

	checkExceptions();
	
	return jobj;
}

jobject _WmValues::put( WmString key, WmObject value )
{
	jobject jobj = NULL;

	jobj = jenv_->CallObjectMethod(
		jobj_,
		mid_put_String_Object_,
		(jstring)key->getJavaObject(),
		value->getJavaObject() );

	checkExceptions();
	
	return jobj;
}

jobject _WmValues::put( const char *key, WmObject value )
{
	jobject jobj = NULL;
	jstring jkey = jenv_->NewStringUTF( key );

	checkExceptions();
	
	jobj = jenv_->CallObjectMethod(
		jobj_,
		mid_put_String_Object_,
		jkey,
		value->getJavaObject() );

	checkExceptions();
	
	jenv_->DeleteLocalRef( jkey );

	checkExceptions();
	
	return jobj;
}

jobject _WmValues::put( const char *key, const char *value )
{
	jobject jobj = NULL;
	WmObject obj = NULL;
	jstring jkey = jenv_->NewStringUTF( key );

	checkExceptions();
	
	jstring jvalue = jenv_->NewStringUTF( value );

	checkExceptions();
	
	jobj = jenv_->CallObjectMethod(
		jobj_,
		mid_put_String_Object_,
		jkey,
		jvalue );

	checkExceptions();
	
	jenv_->DeleteLocalRef( jkey );
	jenv_->DeleteLocalRef( jvalue );

	checkExceptions();
	
	return jobj;
}

jobject _WmValues::put( jstring key, jobject value )
{
	jobject jobj = NULL;
	
	jobj = jenv_->CallObjectMethod(
		jobj_,
		mid_put_String_Object_,
		key,
		value );

	checkExceptions();
	
	return jobj;
}

jint _WmValues::size()
{
	size_ = jenv_->CallIntMethod(
		jobj_,
		mid_size_ );

	checkExceptions();

	return size_;
}

WmStringArray _WmValues::getValueKeys()
{
	jobject jsa = NULL;

	jsa = jenv_->CallObjectMethod(
		jobj_,
		mid_getValueKeys_Object_ );

	WmStringArray wsa = new _WmStringArray(jenv_,(jobjectArray)jsa,1);

	checkExceptions();

	return wsa;
}

void _WmValues::initializeMethods()
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

			cid_ = WmGlobal::getClassRef( WMVALUES );

			mid_contains_Object_ = jenv_->GetMethodID(
				cid_,
				"contains",
				"(Ljava/lang/Object;)Z" );

			checkExceptions();

	
			mid_containsKey_String_ = jenv_->GetMethodID(
				cid_,
				"containsKey",
				"(Ljava/lang/String;)Z" );

			checkExceptions();
	
			mid_get_int_ = jenv_->GetMethodID(
				cid_,
				"get",
				"(I)Ljava/lang/Object;" );

			checkExceptions();
	
			mid_isEmpty_ = jenv_->GetMethodID(
				cid_,
				"isEmpty",
				"()Z" );

			checkExceptions();
	
			mid_remove_String_ = jenv_->GetMethodID(
				cid_,
				"remove",
				"(Ljava/lang/String;)Ljava/lang/Object;" );

			checkExceptions();
	
			mid_get_String_ = jenv_->GetMethodID( 
				cid_,
				"get",
				"(Ljava/lang/String;)Ljava/lang/Object;" );

			checkExceptions();
	
			mid_put_Object_ = jenv_->GetMethodID( 
				cid_,
				"put",
				"(Ljava/lang/Object;)Ljava/lang/Object;" );

			checkExceptions();
	
			mid_put_String_Object_ = jenv_->GetMethodID( 
				cid_,
				"put",
				"(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;" );

			checkExceptions();
	
			mid_size_ = jenv_->GetMethodID( 
				cid_,
				"size",
				"()I" );

			checkExceptions();
	
			mid_toString_ = jenv_->GetMethodID( 
				cid_,
				"toString",
				"()Ljava/lang/String;" );

			checkExceptions();
	
			mid_constructor_ = jenv_->GetMethodID( 
				cid_,
				"<init>",
				"()V" );

			checkExceptions();
	
			mid_getValueKeys_Object_ = jenv_->GetMethodID(
				cid_,
				"getValueKeys",
				"()[Ljava/lang/String;" );

			checkExceptions();
			
			WmGlobal::monitorExit( jenv_ );
		}
		catch( WmException &ex )
		{
			throw ex;
		}
	}
}
