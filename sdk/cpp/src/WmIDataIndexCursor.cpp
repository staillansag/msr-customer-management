#include "WmIDataIndexCursor.h"
#include "WmIDataCursor.h"
#include "WmGlobal.h"

jmethodID _WmIDataIndexCursor::mid_constructor_;
jmethodID _WmIDataIndexCursor::mid_seek_int_;
jmethodID _WmIDataIndexCursor::mid_count_;

jclass _WmIDataIndexCursor::cid_;

_WmIDataIndexCursor::_WmIDataIndexCursor(JNIEnv *env) : _WmIDataCursor( env ){
	initializeMethods();

	jobj_ = jenv_->NewObject( cid_, mid_constructor_ );

	manage_ref_ = 1;

	checkExceptions();

	type_ = WMIDATAINDEXCURSOR;

}

_WmIDataIndexCursor::_WmIDataIndexCursor(JNIEnv *env, jobject context, int manage_ref ) : _WmIDataCursor ( env, context, manage_ref )
{
	initializeMethods();

	type_ = WMIDATAINDEXCURSOR;
}

int _WmIDataIndexCursor :: count(){
	initializeMethods();
	int result;
	jint jresult;

	jresult = jenv_->CallIntMethod(jobj_, mid_count_);

	result = jresult;

	return result;
}

int _WmIDataIndexCursor :: seek(int index){
	initializeMethods();
	jboolean jresult;
	int result;

	jresult = jenv_->CallBooleanMethod( jobj_, mid_seek_int_ , jint(index) );
	checkExceptions();

	result = (jresult == JNI_TRUE) ? 1 : 0;

	return result;
}

void _WmIDataIndexCursor :: initializeMethods()
//  throw( WmException )
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

			cid_ = WmGlobal::getClassRef( WMIDATAINDEXCURSOR );
			checkExceptions();

			/*mid_constructor_ = jenv_->GetMethodID( cid_,
							       "<init>",
							       "()V");
			checkExceptions();*/

			mid_seek_int_ = jenv_->GetMethodID(cid_,
							   "seek",
							   "(I)Z" );
			checkExceptions();

			mid_count_ = jenv_->GetMethodID(cid_,
						        "count",
							"()I");
			checkExceptions();
		}
		catch( WmException &ex)
		{
			throw ex;
		}
	}
}

