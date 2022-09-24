#ifndef _WmDate_H_
#define _WmDate_H_

#include "WmObject.h"
#include "WmPrefix.h"
#include "WmString.h"

class _WmDate;

typedef _WmDate *WmDate;

class IMPORT_EXPORT_DLL _WmDate : public _WmObject{
	public:
		PREFIX _WmDate(JNIEnv* jenv);
		PREFIX _WmDate(JNIEnv* jenv, jobject obj, int manage_ref);
		PREFIX _WmDate(JNIEnv* jenv, long date);
		PREFIX _WmDate(JNIEnv* jenv, WmString date);
		PREFIX _WmDate(JNIEnv* jenv, char* date);

		PREFIX WmString toString();
	protected:
		void initializeMethods()
			throw( WmException );

		static jmethodID mid_constructor_;
		static jmethodID mid_toString_;

		static jclass    cid_;
};


#endif

