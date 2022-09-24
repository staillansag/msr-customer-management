#ifndef _WmIDataHashCursor_H_
#define _WmIDataHashCursor_H_

#include "WmString.h"
#include "WmPrefix.h"
#include "WmObject.h"
#include "WmIDataCursor.h"

class _WmIDataHashCursor;

typedef _WmIDataHashCursor *WmIDataHashCursor;

class IMPORT_EXPORT_DLL _WmIDataHashCursor : public _WmIDataCursor {
	public:
		PREFIX _WmIDataHashCursor( JNIEnv *jenv );
		PREFIX _WmIDataHashCursor( JNIEnv *jenv, jobject hashcursor,
				    int manage_ref=0);

		PREFIX ~_WmIDataHashCursor();

	protected:
		void initializeMethods()
		  throw( WmException );

		static jmethodID mid_constructor_;

		static jclass cid_;
};

#endif /* _WmIDataHashCursor_H_ */
