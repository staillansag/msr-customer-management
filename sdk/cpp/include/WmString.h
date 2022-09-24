#ifndef WmString_h
#define WmString_h

#include "WmObject.h"
#include "WmPrefix.h"
#include <iostream>

using namespace std;

class _WmString;

typedef _WmString *WmString;

class IMPORT_EXPORT_DLL _WmString : public _WmObject
{
public:
	PREFIX _WmString( JNIEnv *env, const char *str );
	PREFIX _WmString( JNIEnv *env, jstring str, int manage_ref=0 );
	PREFIX virtual ~_WmString();

	PREFIX int equals(char*);
	PREFIX int equals(WmString);

	PREFIX const char *toString();

protected:
	void initializeMethods()
	  throw( WmException );

	jboolean	is_copy_;
	jstring		jstring_;
	const char		*string_;

	static jclass	cid_;
};

//ostream & operator << (ostream &stream, WmString s);

#endif
