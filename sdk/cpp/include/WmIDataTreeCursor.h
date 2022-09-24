#ifndef _WmIDataTreeCursor_H_
#define _WmIDataTreeCursor_H_

#include "WmIDataCursor.h"
#include "WmPrefix.h"

class _WmIDataTreeCursor;

typedef _WmIDataTreeCursor *WmIDataTreeCursor;

class IMPORT_EXPORT_DLL _WmIDataTreeCursor : public _WmIDataCursor{
	public:
		PREFIX _WmIDataTreeCursor( JNIEnv *jenv );
		PREFIX _WmIDataTreeCursor( JNIEnv *jenv, jobject treecursor,
				    int manage_ref=0);

		PREFIX ~_WmIDataTreeCursor();

		PREFIX int up();

		PREFIX int down();
	protected:
		void initializeMethods();

		static jmethodID mid_constructor_;
		static jmethodID mid_up_;
		static jmethodID mid_down_;

		static jclass    cid_;
};

#endif
