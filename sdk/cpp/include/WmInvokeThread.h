#ifndef WmInvokeThread_h
#define WmInvokeThread_h

#include "WmObject.h"
#include "WmPrefix.h"
#include "WmValues.h"
/*
#include "WmContext.h"
*/

class WmGlobal;
class _WmInvokeThread;

typedef _WmInvokeThread *WmInvokeThread;

class IMPORT_EXPORT_DLL _WmInvokeThread : public _WmObject
{
public:
	PREFIX _WmInvokeThread( JNIEnv *jenv );

	/*
	PREFIX _WmInvokeThread( JNIEnv *jenv, WmContext ctx, 
		jstring ifc, jstring svc, WmValues data);
	*/

	PREFIX _WmInvokeThread( JNIEnv *jenv, jobject values, int manage_ref=0 );

	PREFIX ~_WmInvokeThread();

	PREFIX WmValues getData( );

protected:
	void initializeMethods()
	  throw( WmException );

	static jmethodID	mid_getData_;
	static jmethodID	mid_constructor_;

	static jclass		cid_;

};

#endif
