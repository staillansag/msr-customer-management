#include "WmString.h"
#include "WmGlobal.h"
#include <stdlib.h>
#include <string.h>

jclass _WmString::cid_;

_WmString::_WmString( JNIEnv *env, const char *str ) : _WmObject(env)
{
	initializeMethods();

	jstring_ = jenv_->NewStringUTF( str );
	type_ = WMSTRING;
	jobj_ = jstring_;

	manage_ref_ = 1;

	checkExceptions();

	string_ = jenv_->GetStringUTFChars( jstring_, &is_copy_ );

	checkExceptions();
}

_WmString::_WmString( JNIEnv *env, jstring str, int manage_ref ) :
	_WmObject(env, str, manage_ref)
{
	initializeMethods();

	type_ = WMSTRING;
	jstring_ = (jstring)str;//jobj_;

	jobj_ = jstring_;

	string_ = jenv_->GetStringUTFChars( str, &is_copy_ );

	checkExceptions();
}

int _WmString :: equals(WmString obj){
	return (!strcmp(string_, obj->string_)) ? 1 : 0;
}

_WmString::~_WmString()
{
	if( is_copy_ )
	{
		jenv_->ReleaseStringUTFChars( jstring_, string_ );

		checkExceptions();
	}
}

const char *_WmString::toString()
{
	return string_;
}

int _WmString :: equals(char* str){
	return (!strcmp(string_, str)) ? 1 : 0;
}

void _WmString::initializeMethods()
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

			cid_ = WmGlobal::getClassRef( WMSTRING );
			checkExceptions();

			WmGlobal::monitorExit( jenv_ );
		}
		catch( WmException &ex )
		{
			throw ex;
		}
	}
}

/*ostream &operator << (ostream &stream, WmString s )
{
	stream << s->toString();

	return stream;
}*/
