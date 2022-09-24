#include "WmIData.h"
#include "WmIDataCursor.h"
#include "WmGlobal.h"

jmethodID _WmIData::mid_getCursor_;
jmethodID _WmIData::mid_getIndexCursor_;
jmethodID _WmIData::mid_getHashCursor_;
jmethodID _WmIData::mid_getTreeCursor_;
jmethodID _WmIData::mid_constructor_;

jclass    _WmIData::cid_;

_WmIData::_WmIData( JNIEnv *jenv ) : _WmObject( jenv )
{
	initializeMethods();

	jobj_ = jenv_->NewObject(
		cid_, 
		mid_constructor_ );

	manage_ref_ = 1;

	checkExceptions();

        type_ = WMIDATA;

	checkExceptions();
}

_WmIData::_WmIData( JNIEnv *jenv, jobject idata, int manage_ref ) :
          _WmObject(jenv, idata, manage_ref)
{
	initializeMethods();

	type_ =  WMIDATA;

	checkExceptions();
}

_WmIData::~_WmIData(){ }

WmIDataCursor _WmIData::getCursor()
{
	WmIDataCursor  cursor  = NULL;
	jobject        jcursor = NULL;

	try
	{
	 	jcursor = jenv_->CallObjectMethod(
			          jobj_,
				  mid_getCursor_);

		checkExceptions();

		cursor = (WmIDataCursor)WmGlobal::createWmObject( jenv_, jcursor, 1);

	} catch( WmException &ex ){
		throw ex;
	}

	return cursor;
}

WmString _WmIData::toString(){
	WmValues vals = _WmValues::use(jenv_, this);
	checkExceptions();
	return vals->toString();
}

WmIDataIndexCursor _WmIData::getIndexCursor()
{
	WmIDataIndexCursor  cursor  = NULL;
	jobject             jcursor = NULL;

	try
	{
	 	jcursor = jenv_->CallObjectMethod(
			          jobj_,
				  mid_getIndexCursor_,
			 	 NULL );

		checkExceptions();

		cursor = (WmIDataIndexCursor)WmGlobal::createWmObject( jenv_, jcursor, 1);

	} catch( WmException &ex ){
		throw ex;
	}

	return cursor;
}

WmIDataHashCursor _WmIData::getHashCursor()
{
	WmIDataHashCursor  cursor  = NULL;
	jobject        jcursor = NULL;

	try
	{
	 	jcursor = jenv_->CallObjectMethod(
			          jobj_,
				  mid_getHashCursor_);

		checkExceptions();

		cursor = (WmIDataHashCursor)WmGlobal::createWmObject( jenv_, jcursor, 1);

	} catch( WmException &ex ){
		throw ex;
	}

	return cursor;
}

WmIDataTreeCursor _WmIData::getTreeCursor()
{
	WmIDataTreeCursor  cursor  = NULL;
	jobject        jcursor = NULL;

	try
	{
	 	jcursor = jenv_->CallObjectMethod(
			          jobj_,
				  mid_getTreeCursor_,
			 	 NULL );

		checkExceptions();

		cursor = (WmIDataTreeCursor)WmGlobal::createWmObject( jenv_, jcursor, 1);

	} catch( WmException &ex ){
		throw ex;
	}

	return cursor;
}

void _WmIData::initializeMethods()
  throw( WmException )
{
	if( cid_ == NULL )
	{
		try
		{
			WmGlobal::monitorEnter( jenv_ );

			if( cid_ != NULL )
			{
				WmGlobal::monitorExit( jenv_ );
				return;
			}

			cid_ = WmGlobal::getClassRef( WMIDATA );

			checkExceptions();
			
			/*mid_constructor_ = jenv_->GetMethodID(
					 cid_,
					 "<init>",
					 "()V");

			checkExceptions();*/

			mid_getCursor_ = jenv_->GetMethodID(
					 cid_,
					 "getCursor",
					 "()Lcom/wm/data/IDataCursor;");


			checkExceptions();

			mid_getIndexCursor_ = jenv_->GetMethodID(
					 cid_,
					 "getIndexCursor",
					 "()Lcom/wm/data/IDataIndexCursor;");

			checkExceptions();

			mid_getHashCursor_ = jenv_->GetMethodID(
					 cid_,
					 "getHashCursor",
					 "()Lcom/wm/data/IDataHashCursor;");

			checkExceptions();

			mid_getTreeCursor_ = jenv_->GetMethodID(
					 cid_,
					 "getTreeCursor",
					 "()Lcom/wm/data/IDataTreeCursor;");

			checkExceptions();

			WmGlobal::monitorExit( jenv_ );
		}
		catch( WmException &ex )
		{
			throw ex;
		}
	}
}


			
