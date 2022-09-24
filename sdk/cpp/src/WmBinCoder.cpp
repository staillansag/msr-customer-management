#include "WmBinCoder.h"
#include "WmGlobal.h"

jmethodID	_WmBinCoder::mid_encodeToBytes_Object_;
jmethodID	_WmBinCoder::mid_decodeFromBytes_byteArray_;
jmethodID	_WmBinCoder::mid_constructor_;

jclass		_WmBinCoder::cid_;

_WmBinCoder::_WmBinCoder( JNIEnv *jenv ) : _WmObject( jenv )
{
	initializeMethods();

	jobj_ = jenv_->NewObject(
		cid_,
		mid_constructor_ );

	manage_ref_ = 1;

	type_ = WMBINCODER;

	checkExceptions();
}

_WmBinCoder::_WmBinCoder( JNIEnv *jenv, jobject values, int manage_ref ) : 
	_WmObject(jenv, values, manage_ref)
{
	initializeMethods();

	jobj_ = values;

	type_ = WMBINCODER;

	checkExceptions();
}

_WmBinCoder::~_WmBinCoder()
{
#if 0
	if(manage_ref_)
		jenv_->DeleteLocalRef(jobj_);
#endif
}

jbyteArray _WmBinCoder::encodeToBytes( WmObject obj )
{
	jobject jobj = NULL;

	try
	{
		jobj = jenv_->CallObjectMethod(
			jobj_,
			mid_encodeToBytes_Object_,
			obj->getJavaObject() );

		checkExceptions();
	}
	catch( WmException &ex )
	{
		throw ex;
	}

	return ((jbyteArray)jobj);
}

jbyteArray _WmBinCoder::encodeToBytes( jobject obj )
{
	jobject jobj = NULL;

	try
	{
		jobj = jenv_->CallObjectMethod(
			jobj_,
			mid_encodeToBytes_Object_,
			obj );

		checkExceptions();
	}
	catch( WmException &ex )
	{
		throw ex;
	}

	return ((jbyteArray)jobj);
}

WmObject _WmBinCoder::decodeFromBytes( jbyteArray jba )
{
	jobject jobj = NULL;
	WmObject obj = NULL;

	try
	{
		jobj = jenv_->CallObjectMethod(
			jobj_,
			mid_decodeFromBytes_byteArray_,
			jba );

		checkExceptions();

		obj = WmGlobal::createWmObject( jenv_, jobj, 1 );

		jenv_->DeleteLocalRef(jobj);
	}
	catch( WmException &ex )
	{
		throw ex;
	}

	return obj;
}

jobject _WmBinCoder::decodeFromBytesJ( jbyteArray jba )
{
	jobject jobj = NULL;

	try
	{
		jobj = jenv_->CallObjectMethod(
			jobj_,
			mid_decodeFromBytes_byteArray_,
			jba );

		checkExceptions();
	}
	catch( WmException &ex )
	{
		throw ex;
	}

	return jobj;
}

void _WmBinCoder::initializeMethods()
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

			cid_ = WmGlobal::getClassRef( WMBINCODER );

			mid_encodeToBytes_Object_ = jenv_->GetMethodID( 
				cid_,
				"encodeToBytes",
				"(Ljava/lang/Object;)[B" );

			checkExceptions();
	
			mid_decodeFromBytes_byteArray_ = jenv_->GetMethodID( 
				cid_,
				"decodeFromBytes",
				"([B)Ljava/lang/Object;" );

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
