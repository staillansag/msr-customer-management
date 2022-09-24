#include "WmVector.h"
#include "WmGlobal.h"

jmethodID	_WmVector::mid_addElement_Object_;
jmethodID	_WmVector::mid_elementAt_int_;
jmethodID	_WmVector::mid_size_;
jmethodID	_WmVector::mid_constructor_;

jclass		_WmVector::cid_;

_WmVector::_WmVector( JNIEnv *jenv ) : _WmObject( jenv )
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

	type_ = WMVECTOR;

	checkExceptions();
}

_WmVector::_WmVector( JNIEnv *jenv, jobject values, int manage_ref ) : 
	_WmObject(jenv, values, manage_ref)
{
	initializeMethods();

	size_ = jenv_->CallIntMethod(
		jobj_,
		mid_size_ );

	type_ = WMVECTOR;

	checkExceptions();
}

_WmVector::~_WmVector()
{
}

void _WmVector::addElement( WmObject obj )
{
	jenv_->CallVoidMethod(
		jobj_,
		mid_addElement_Object_,
		obj->getJavaObject() );

	checkExceptions();
}

WmObject _WmVector::elementAt( int index )
{
	jobject jobj = NULL;
	WmObject obj = NULL;

	try
	{
		jobj = jenv_->CallObjectMethod(
			jobj_,
			mid_elementAt_int_,
			index );

		checkExceptions();

		obj = WmGlobal::createWmObject( jenv_, jobj, 1 );
	}
	catch( WmException &ex )
	{
		throw ex;
	}

	return obj;
}

jint _WmVector::size()
{
	size_ = jenv_->CallIntMethod(
		jobj_,
		mid_size_ );

	checkExceptions();

	return size_;
}

void _WmVector::initializeMethods()
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

			cid_ = WmGlobal::getClassRef( WMVECTOR );

			mid_addElement_Object_ = jenv_->GetMethodID( 
				cid_,
				"addElement",
				"(Ljava/lang/Object;)V" );

			checkExceptions();
	
			mid_elementAt_int_ = jenv_->GetMethodID( 
				cid_,
				"elementAt",
				"(I)Ljava/lang/Object;" );

			checkExceptions();
	
			mid_size_ = jenv_->GetMethodID( 
				cid_,
				"size",
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
