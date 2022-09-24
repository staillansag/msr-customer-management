#ifndef WmVector_h
#define WmVector_h

#include "WmObject.h"
#include "WmPrefix.h"
#include "WmString.h"

class WmGlobal;
class _WmVector;

typedef _WmVector *WmVector;

class IMPORT_EXPORT_DLL _WmVector : public _WmObject
{
public:
	PREFIX _WmVector( JNIEnv *jenv );

	PREFIX _WmVector( JNIEnv *jenv, jobject values, int manage_ref=0 );

	PREFIX ~_WmVector();

	PREFIX void addElement( WmObject obj );

	PREFIX WmObject elementAt( int index );

	PREFIX jint size();

protected:
	void initializeMethods()
	  throw( WmException );

	jint		size_;

	static jmethodID	mid_addElement_Object_;
	static jmethodID	mid_elementAt_int_;
	static jmethodID	mid_size_;
	static jmethodID	mid_constructor_;

	static jclass		cid_;
};

#endif
