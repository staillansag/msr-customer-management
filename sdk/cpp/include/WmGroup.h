#ifndef _WmGroup_H_
#define _WmGroup_H_

class _WmGroup;
typedef _WmGroup *WmGroup;

#include <jni.h>
#include "WmPrefix.h"
#include "WmObject.h"
#include "WmUser.h"
#include "WmException.h"
#include "WmString.h"

class IMPORT_EXPORT_DLL _WmGroup : public _WmObject{
	public:
		PREFIX _WmGroup(JNIEnv* jenv);
		PREFIX _WmGroup(JNIEnv* jenv, jobject obj, int manage_ref);
		PREFIX _WmGroup(JNIEnv* jenv, WmString name);
		PREFIX _WmGroup(JNIEnv* jenv, char* name);

		PREFIX WmUser add(WmUser user);

	protected:
		void initializeMethods()
			throw (WmException);

		static jmethodID mid_constructor_;
		static jmethodID mid_add_User_;

		static jclass    cid_;
};



#endif

