#include "WmIDataHashCursor.h"
#include "WmGlobal.h"
#include "WmString.h"

jmethodID _WmIDataHashCursor::mid_constructor_;

jclass _WmIDataHashCursor::cid_;

_WmIDataHashCursor::_WmIDataHashCursor( JNIEnv *env ) : _WmIDataCursor( env )
{
	initializeMethods();

	jobj_ = jenv_->NewObject( cid_,
				  mid_constructor_ );

	manage_ref_ = 1;

	checkExceptions();

	type_ = WMIDATAHASHCURSOR;
}

_WmIDataHashCursor::_WmIDataHashCursor( JNIEnv *env, jobject context, int manage_ref ) : _WmIDataCursor( env , context, manage_ref)
{
	initializeMethods();

	type_ = WMIDATAHASHCURSOR;
}

_WmIDataHashCursor::~_WmIDataHashCursor() { }


void _WmIDataHashCursor :: initializeMethods()
	throw( WmException )
{
	if(cid_ == NULL)
	{
		try
		{
			WmGlobal::monitorEnter( jenv_ );

			if( cid_ != NULL )
			{
				WmGlobal::monitorExit( jenv_ );
				return;
			}

			cid_ = WmGlobal::getClassRef( WMIDATAHASHCURSOR );
			checkExceptions();

			/*mid_constructor_ = jenv_->GetMethodID(cid_,
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


