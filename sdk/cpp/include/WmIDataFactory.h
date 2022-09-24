#ifndef WmIDataFactory_H
#define WmIDataFactory_H

#include <jni.h>
#include "WmIData.h"
#include "WmPrefix.h"
#include "WmObject.h"
#include "WmString.h"

class IMPORT_EXPORT_DLL WmIDataFactory{
public:

	PREFIX static WmIData create();
	PREFIX static WmIData create(int size);
	PREFIX static WmIData create(WmString name);
	PREFIX static void Register(WmString name, WmString className);
	PREFIX static void Register(char* name, char* className);
	PREFIX static void initializeJEnv(JNIEnv* jenv);

protected:
 	static void initializeMethods()
	  throw( WmException );

	static jmethodID	mid_constructor_;
	static jmethodID	mid_create_;
	static jmethodID 	mid_create_int_;
	static jmethodID	mid_create_Object_;
	static jmethodID	mid_create_String_;
	static jmethodID	mid_register_String_String_;

	static jclass		cid_;
	static JNIEnv *Sjenv_;

};

#endif
