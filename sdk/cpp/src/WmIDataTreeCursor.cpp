#include "WmIDataTreeCursor.h"
#include "WmGlobal.h"

jmethodID _WmIDataTreeCursor::mid_constructor_;
jmethodID _WmIDataTreeCursor::mid_up_;
jmethodID _WmIDataTreeCursor::mid_down_;
jclass    _WmIDataTreeCursor::cid_;

_WmIDataTreeCursor :: _WmIDataTreeCursor( JNIEnv *jenv ) : _WmIDataCursor (jenv)
{
	initializeMethods();

	jobj_ = jenv_->NewObject(cid_, mid_constructor_ );

	manage_ref_ = 1;

	checkExceptions();

	type_ = WMIDATATREECURSOR;
}

_WmIDataTreeCursor :: _WmIDataTreeCursor( JNIEnv *jenv, jobject treecursor, int manage_ref ) : _WmIDataCursor( jenv, treecursor, manage_ref )
{
	initializeMethods();

	type_ = WMIDATATREECURSOR;
}

_WmIDataTreeCursor::~_WmIDataTreeCursor(){ }

int _WmIDataTreeCursor :: up(){
	initializeMethods();
	jboolean result = JNI_FALSE;
	int amc = 1;

	result = jenv_->CallBooleanMethod(jobj_, 
				          mid_up_);

	amc = (result == JNI_TRUE) ? 1 : 0;
	return amc;
}

int _WmIDataTreeCursor :: down(){
	initializeMethods();
	jboolean result = JNI_FALSE;
	int amc = 1;

	result = jenv_->CallBooleanMethod(jobj_, 
				          mid_down_);

	amc = (result == JNI_TRUE) ? 1 : 0;
	return amc;
}

void _WmIDataTreeCursor :: initializeMethods()
//  throw ( WmException )
{
	if(mid_constructor_ == NULL)
	{
		try
		{
			WmGlobal::monitorEnter( jenv_ );

			if(mid_constructor_ != NULL )
			{
				WmGlobal::monitorExit( jenv_ );
				return;
			}

			cid_ = WmGlobal::getClassRef( WMIDATATREECURSOR );
			checkExceptions();

			/*mid_constructor_ = jenv_->GetMethodID( cid_,
							       "<init>",
							       "()V");

			checkExceptions();*/

			mid_up_ = jenv_->GetMethodID( cid_,
						      "up", "()Z");


			checkExceptions();

			mid_down_ = jenv_->GetMethodID( cid_,
							"down",
							"()Z" );
			checkExceptions();
			WmGlobal::monitorExit( jenv_ );
		}
		catch( WmException &ex)
		{
			throw ex;
		}
	}
}

