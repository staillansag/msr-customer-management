#ifndef _WmUser_H_
#define _WmUser_H_

class _WmUser;
typedef _WmUser *WmUser;

#include <jni.h>
#include "WmPrefix.h"
#include "WmObject.h"
#include "WmGroup.h"
#include "WmString.h"

class IMPORT_EXPORT_DLL _WmUser : public _WmObject{
	public:
		PREFIX _WmUser(JNIEnv* jenv);
		PREFIX _WmUser(JNIEnv* jenv, jobject obj, int manage_ref);
		PREFIX _WmUser(JNIEnv* jenv, WmString name);
		PREFIX _WmUser(JNIEnv* jenv, char* name);

		PREFIX WmGroup add(WmGroup group);

		PREFIX int isAdministrator();
	protected:
		void initializeMethods()
			throw (WmException);

		static jmethodID mid_constructor_;
		static jmethodID mid_add_Group_;
		static jmethodID mid_isAdministrator_;

		static jclass    cid_;
};



#endif

