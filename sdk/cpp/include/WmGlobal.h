#ifndef WmGlobal_h
#define WmGlobal_h

#include <jni.h>
#include "WmPrefix.h"
#include "WmException.h"
#include "WmIDataCodable.h"
#include "WmDate.h"
#include "WmUser.h"
#include "WmGroup.h"
#include "WmUtil.h"
#include "WmObject.h"
#include "WmObjectArray.h"
#include "WmValues.h"
#include "WmValuesArray.h"
#include "WmTable.h"
#include "WmString.h"
#include "WmStringArray.h"
#include "WmStringTable.h"
#include "WmBaseContext.h"
#include "WmVector.h"
#include "WmIData.h"
#include "WmIDataArray.h"
#include "WmIDataUtil.h"
#include "WmIDataIndexCursor.h"
#include "WmIDataTreeCursor.h"
#include "WmIDataHashCursor.h"
#include "WmIDataFactory.h"
#include "WmIDataCursor.h"
#include "WmTContext.h"
#include "WmContext.h"
#include "WmBaseContext.h"
#include "WmBinCoder.h"
#include "WmInvokeThread.h"

class IMPORT_EXPORT_DLL WmGlobal
{
public:
	PREFIX static JNIEnv *initClientJVM( const char *classpath=NULL )
	  throw( WmException );

	PREFIX static void initClientJVM( JNIEnv* env )
	  throw( WmException );

    PREFIX static WmObject createWmObject( JNIEnv *env, jobject jobj, int manage_ref=0 )
	  throw( WmException );

	PREFIX static JavaVM *getJVMRef();

	PREFIX static void monitorEnter( JNIEnv *jenv, jobject monitor=global_monitor_ )
	  throw( WmException );

PREFIX 	static void monitorExit( JNIEnv *jenv, jobject monitor=global_monitor_ )
	  throw( WmException );

PREFIX 	static jclass getClassRef( WmObjectType wm_type )
	  throw( WmException );

PREFIX 	static void checkExceptions( JNIEnv *jenv )
	  throw( WmException );

PREFIX 	static JNIEnv *attachCurrentThread()
	  throw( WmException );

PREFIX 	static void detachCurrentThread()
	  throw( WmException );

PREFIX static void destroyJavaVM();

PREFIX static JNIEnv *GetCreatedVM(const char *classpath)
	  throw( WmException );

PREFIX static void initVars(JNIEnv *jenv)
  throw( WmException );

private:
	static void describeException(WmException & wmex);
    static void initClassRefs( JNIEnv *jenv )
      throw( WmException );

    static JavaVM	*jvm_;

	static jclass	cid_watt_util_Values_;
	static jclass	cid_java_util_Date_;
	static jclass	cid_app_server_User_;
	static jclass	cid_app_server_Group_;
	static jclass	cid_watt_util_Values_Array_;
	static jclass	cid_watt_util_Table_;
	static jclass	cid_java_lang_String_;
	static jclass	cid_java_lang_String_Array_;
	static jclass	cid_java_lang_String_Table_;
	static jclass	cid_java_lang_Object_;
	static jclass	cid_java_lang_Object_Array_;
	static jclass	cid_java_util_Vector_;
	static jclass	cid_watt_client_Context_;
	static jclass	cid_watt_client_BaseContext_;

	static jclass 	cid_watt_data_IData_;
	static jclass 	cid_watt_data_IData_Array_;
	static jclass 	cid_watt_data_IDataCursor_;
	static jclass 	cid_watt_data_IDataFactory_;
	static jclass 	cid_watt_data_IDataHashCursor_;
	static jclass 	cid_watt_data_IDataIndexCursor_;
	static jclass 	cid_watt_data_IDataTreeCursor_;
	static jclass 	cid_watt_data_IDataUtil_;
	static jclass	cid_watt_util_coder_IDataCodable_;
	static jclass   cid_watt_client_util_GenUtil_;
	static jclass 	cid_watt_client_TContext_;
	static jclass	cid_watt_util_coder_CoderHelper_;
	static jclass	cid_watt_client_InvokeThread_;

	static jclass   cid_watt_client_Exception_;
	static jclass	cid_java_lang_Class_;

	static jclass		cid_java_lang_Throwable_;
	static jmethodID	mid_getMessage_;
	static jmethodID	mid_toString_;
	static jmethodID	mid_getClass_;
	static jmethodID	mid_getName_;

	static jobject	class_ref_monitor_;
	static jobject	exception_monitor_;
	static jobject	global_monitor_;

	static int		initialized_;
};

#endif
