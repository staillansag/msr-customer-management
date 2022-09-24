#include <string.h>
#include <iostream>
#include "WmGlobal.h"

using namespace std;

// comment out the following line when compiling with JDK 1.1
#define JAVA2

jclass WmGlobal::cid_watt_util_Values_;
jclass WmGlobal::cid_watt_util_Values_Array_;
jclass WmGlobal::cid_java_util_Date_;
jclass WmGlobal::cid_app_server_User_;
jclass WmGlobal::cid_app_server_Group_;
jclass WmGlobal::cid_watt_util_Table_;
jclass WmGlobal::cid_java_lang_String_;
jclass WmGlobal::cid_java_lang_String_Array_;
jclass WmGlobal::cid_java_lang_String_Table_;
jclass WmGlobal::cid_java_lang_Object_;
jclass WmGlobal::cid_java_lang_Class_;
jclass WmGlobal::cid_java_lang_Object_Array_;
jclass WmGlobal::cid_watt_client_BaseContext_;
jclass WmGlobal::cid_watt_client_Context_;
jclass WmGlobal::cid_watt_client_TContext_;
jclass WmGlobal::cid_java_util_Vector_;
jclass WmGlobal::cid_watt_data_IData_;
jclass WmGlobal::cid_watt_data_IData_Array_;
jclass WmGlobal::cid_watt_data_IDataCursor_;
jclass WmGlobal::cid_watt_data_IDataIndexCursor_;
jclass WmGlobal::cid_watt_data_IDataHashCursor_;
jclass WmGlobal::cid_watt_data_IDataFactory_;
jclass WmGlobal::cid_watt_data_IDataTreeCursor_;
jclass WmGlobal::cid_watt_data_IDataUtil_;
jclass WmGlobal::cid_watt_util_coder_IDataCodable_;
jclass WmGlobal::cid_watt_client_util_GenUtil_;
jclass WmGlobal::cid_watt_util_coder_CoderHelper_;
jclass WmGlobal::cid_watt_client_InvokeThread_;

jclass WmGlobal::  cid_watt_client_Exception_;


jclass WmGlobal::cid_java_lang_Throwable_;
jmethodID WmGlobal::mid_getMessage_;
jmethodID WmGlobal::mid_toString_;
jmethodID WmGlobal::mid_getClass_;
jmethodID WmGlobal::mid_getName_;

jobject WmGlobal::class_ref_monitor_;
jobject WmGlobal::exception_monitor_;
jobject WmGlobal::global_monitor_;

JavaVM *WmGlobal::jvm_ = 0;

int WmGlobal::initialized_ = 0;

//static char classpath_[4096];
const char* EmptyExceptionMessage="<Empty Exception Message>";

#ifdef WIN32
#define SEP ";"
#else
#define SEP ":"
#endif

void WmGlobal::initVars(JNIEnv *jenv)
  throw( WmException )
{

	jclass clazz = jenv->FindClass( "java/lang/Object" );
	checkExceptions( jenv );
	jobject obj = jenv->AllocObject( clazz );
	checkExceptions( jenv );

	class_ref_monitor_ = jenv->NewGlobalRef( obj );
	checkExceptions( jenv );

	obj = jenv->AllocObject( clazz );
	checkExceptions( jenv );

	global_monitor_ = jenv->NewGlobalRef( obj );
	checkExceptions( jenv );

	initClassRefs( jenv );
	checkExceptions( jenv );

	// initialize some static classes....
	WmIDataFactory::initializeJEnv(jenv);
	WmUtil::initializeJEnv(jenv);

}

JNIEnv *WmGlobal::initClientJVM( const char *classpath )
  throw( WmException )
{
	char jvm_classpath[4096];

    jint res;
    JNIEnv *jenv = NULL;

    if( jvm_ != NULL )
	{
		cerr << "The JVM pointer is not NULL." << endl;
		WmException wmex( "JVM_IS_NOT_NULL" );
		throw( wmex );
	}

#ifndef JAVA2

    JDK1_1InitArgs vm_args;
    // JDK 1.1.x
	vm_args.version = 0x00010001;

    JNI_GetDefaultJavaVMInitArgs(&vm_args);

	strcpy( jvm_classpath, vm_args.classpath );

	if( classpath != NULL )
	{
		strcat( jvm_classpath, SEP );
		strcat( jvm_classpath, classpath );
	}

	vm_args.classpath = jvm_classpath;

#else

	JavaVMInitArgs vm_args;
	JavaVMOption options[3];

	sprintf(&jvm_classpath[0],"-Djava.class.path=%s",classpath);
	options[0].optionString = jvm_classpath; /* user classes */

	options[1].optionString = "-Xms16M";
	options[2].optionString = "-Xmx32M";

	vm_args.version = JNI_VERSION_1_2;
	vm_args.options = options;
	vm_args.nOptions = 3;
	vm_args.ignoreUnrecognized = JNI_TRUE;

#endif

#ifdef JAVA2
    	res = JNI_CreateJavaVM(&jvm_, (void **)&jenv, &vm_args);
#else
	    res = JNI_CreateJavaVM(&jvm_, &jenv, &vm_args);
#endif
	checkExceptions( jenv );

    if (res < 0)
	{
        cerr << "Cannot create Java VM" << endl;
		WmException wmex( "CANNOT_CREATE_JVM" );
		throw( wmex );
    }

	jclass clazz = jenv->FindClass( "java/lang/Object" );
	checkExceptions( jenv );
	jobject obj = jenv->AllocObject( clazz );
	checkExceptions( jenv );

	class_ref_monitor_ = jenv->NewGlobalRef( obj );
	checkExceptions( jenv );

	obj = jenv->AllocObject( clazz );
	checkExceptions( jenv );

	global_monitor_ = jenv->NewGlobalRef( obj );
	checkExceptions( jenv );

	initClassRefs( jenv );
	checkExceptions( jenv );

	// initialize some static classes....
	WmIDataFactory::initializeJEnv(jenv);
	WmUtil::initializeJEnv(jenv);

	return jenv;
}

void WmGlobal::initClientJVM( JNIEnv* env )
  throw( WmException )
{
    jint res;
	JNIEnv* jenv = env;

    res = jenv->GetJavaVM(&jvm_);
	checkExceptions( jenv );

    if (res < 0)
	{
        cerr << "Cannot get Java VM" << endl;
		WmException wmex( "CANNOT_CREATE_JVM" );
		throw( wmex );
    }

	jclass clazz = jenv->FindClass( "java/lang/Object" );
	checkExceptions( jenv );
	jobject obj = jenv->AllocObject( clazz );
	checkExceptions( jenv );

	class_ref_monitor_ = jenv->NewGlobalRef( obj );
	checkExceptions( jenv );

	obj = jenv->AllocObject( clazz );
	checkExceptions( jenv );

	global_monitor_ = jenv->NewGlobalRef( obj );
	checkExceptions( jenv );

	initClassRefs( jenv );
	checkExceptions( jenv );

	// initialize some static classes....
	WmIDataFactory::initializeJEnv(jenv);
	WmUtil::initializeJEnv(jenv);

	return;
}


void WmGlobal::initClassRefs( JNIEnv *jenv )
  throw( WmException )
{
	monitorEnter( jenv, class_ref_monitor_ );

	if( initialized_ )
	{
		monitorExit( jenv, class_ref_monitor_ );
		return;
	}

	cid_java_lang_Throwable_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "java/lang/Throwable" ) );

	checkExceptions( jenv );

	cid_java_lang_Object_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "java/lang/Object" ) );

	checkExceptions( jenv );

	cid_java_lang_Class_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "java/lang/Class" ) );

	checkExceptions( jenv );

	mid_getClass_ = jenv->GetMethodID(
		cid_java_lang_Object_,
		"getClass",
		"()Ljava/lang/Class;" );

	checkExceptions( jenv );

	mid_getName_ = jenv->GetMethodID(
		cid_java_lang_Class_,
		"getName",
		"()Ljava/lang/String;" );

	checkExceptions( jenv );

	mid_toString_ = jenv->GetMethodID(
		cid_java_lang_Throwable_,
		"toString",
		"()Ljava/lang/String;" );

	checkExceptions( jenv );

	mid_getMessage_ = jenv->GetMethodID(
		cid_java_lang_Throwable_,
		"getMessage",
		"()Ljava/lang/String;" );

	checkExceptions( jenv );

	cid_java_util_Date_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "java/util/Date" ) );

	checkExceptions( jenv );

	cid_app_server_User_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "com/wm/app/b2b/server/User" ) );

	checkExceptions( jenv );

	cid_app_server_Group_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "com/wm/app/b2b/server/Group" ) );

	checkExceptions( jenv );

	cid_watt_util_Values_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "com/wm/util/Values" ) );

	checkExceptions( jenv );

	cid_watt_util_Values_Array_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "[Lcom/wm/util/Values;" ) );

	checkExceptions( jenv );

	cid_watt_util_Table_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "com/wm/util/Table" ) );

	checkExceptions( jenv );

	cid_java_lang_String_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "java/lang/String" ) );

	checkExceptions( jenv );

	cid_java_lang_String_Array_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "[Ljava/lang/String;" ) );

	checkExceptions( jenv );

	cid_java_lang_String_Table_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "[[Ljava/lang/String;" ) );

	checkExceptions( jenv );

	cid_java_lang_Object_Array_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "[Ljava/lang/Object;" ) );

	checkExceptions( jenv );

	cid_java_util_Vector_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "java/util/Vector" ) );

	checkExceptions( jenv );

	cid_watt_client_Context_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "com/wm/app/b2b/client/Context" ) );

	checkExceptions( jenv );

	cid_watt_client_BaseContext_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "com/wm/app/b2b/client/BaseContext" ) );

	checkExceptions( jenv );

	cid_watt_client_TContext_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "com/wm/app/b2b/client/TContext" ) );

	checkExceptions( jenv );

	cid_watt_data_IData_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "com/wm/data/IData" ) );

	checkExceptions( jenv );

	cid_watt_client_Exception_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass ( "com/wm/app/b2b/client/ServiceException" ));

	checkExceptions( jenv );

	cid_watt_data_IData_Array_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "[Lcom/wm/data/IData;" ) );

	checkExceptions( jenv );

	cid_watt_data_IDataCursor_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "com/wm/data/IDataCursor" ) );

	checkExceptions( jenv );

	cid_watt_data_IDataHashCursor_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "com/wm/data/IDataHashCursor" ) );

	checkExceptions( jenv );

	cid_watt_data_IDataFactory_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "com/wm/data/IDataFactory" ) );

	checkExceptions( jenv );

	cid_watt_data_IDataIndexCursor_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "com/wm/data/IDataIndexCursor" ));

	checkExceptions( jenv );

	cid_watt_data_IDataUtil_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "com/wm/data/IDataUtil" ) );

	checkExceptions( jenv );

	cid_watt_client_util_GenUtil_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "com/wm/app/b2b/util/GenUtil" ) );

	checkExceptions( jenv );

	cid_watt_util_coder_IDataCodable_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "com/wm/util/coder/IDataCodable" ) );

	checkExceptions( jenv );

	cid_watt_util_coder_CoderHelper_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "com/wm/util/coder/CoderHelper" ) );

	checkExceptions( jenv );

	cid_watt_client_InvokeThread_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "com/wm/app/b2b/client/InvokeThread" ) );

	checkExceptions( jenv );

	cid_watt_data_IDataTreeCursor_ = (jclass)jenv->NewGlobalRef(
		jenv->FindClass( "com/wm/data/IDataTreeCursor" ) );

	checkExceptions( jenv );

	initialized_ = 1;

	monitorExit( jenv, class_ref_monitor_ );
}

WmObject WmGlobal::createWmObject( JNIEnv *jenv, jobject jobj, int manage_ref )
  throw( WmException )
{
	WmObject wm_object = NULL;

	if( jobj == NULL ) return NULL;

	if( jenv->IsInstanceOf( jobj, cid_java_lang_String_ ) )
	{
		wm_object = new _WmString( jenv, (jstring)jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_java_util_Date_ ) )
	{
		wm_object = new _WmDate( jenv, jobj, manage_ref );

	}
	else if( jenv->IsInstanceOf( jobj, cid_app_server_Group_ ) )
	{
		wm_object = new _WmGroup( jenv, jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_app_server_User_ ) )
	{
		wm_object = new _WmUser( jenv, jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_watt_util_Values_ ) )
	{
		wm_object = new _WmValues( jenv, jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_watt_util_Table_ ) )
	{
		wm_object = new _WmTable( jenv, jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_watt_util_coder_CoderHelper_ ) )
	{
		wm_object = new _WmBinCoder( jenv, jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_watt_client_InvokeThread_ ) )
	{
		wm_object = new _WmInvokeThread( jenv, jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_watt_client_TContext_ ) )
	{
		wm_object = new _WmTContext( jenv, jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_watt_client_BaseContext_ ) )
	{
		wm_object = new _WmBaseContext( jenv, jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_watt_client_Context_ ) )
	{
		wm_object = new _WmContext( jenv, jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_watt_data_IData_ ) )
	{
		wm_object = new _WmIData( jenv, jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_watt_data_IDataCursor_ ) )
	{
		wm_object = new _WmIDataCursor( jenv, jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_watt_data_IDataHashCursor_ ) )
	{
		wm_object = new _WmIDataHashCursor( jenv, jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_watt_data_IDataIndexCursor_ ) )
	{
		wm_object = new _WmIDataIndexCursor( jenv, jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_watt_data_IDataTreeCursor_ ) )
	{
		wm_object = new _WmIDataTreeCursor( jenv, jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_watt_data_IDataUtil_ ) )
	{
		wm_object = new _WmIDataUtil( jenv, jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_watt_util_Values_Array_ ) )
	{
		wm_object = new _WmValuesArray( jenv, (jobjectArray)jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_watt_data_IData_Array_ ) )
	{
		wm_object = new _WmIDataArray( jenv, (jobjectArray)jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_java_lang_String_Array_ ) )
	{
		wm_object = new _WmStringArray( jenv, (jobjectArray)jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_java_lang_String_Table_ ) )
	{
		wm_object = new _WmStringTable( jenv, (jobjectArray)jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_java_util_Vector_ ) )
	{
		wm_object = new _WmVector( jenv, jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_java_lang_Object_Array_ ) )
	{
		wm_object = new _WmObjectArray( jenv, (jobjectArray)jobj, manage_ref );
	}
	else if( jenv->IsInstanceOf( jobj, cid_java_lang_Object_ ) )
	{
		wm_object = new _WmObject( jenv, jobj, manage_ref );
	}
	else
	{
		WmException ex( "INVALID_TYPE" );
		throw ex;
	}
	checkExceptions( jenv );

	return wm_object;
}

jclass WmGlobal::getClassRef( WmObjectType wm_type )
  throw( WmException )
{
	jclass clazz = NULL;

	switch( wm_type )
	{
		case WMVALUES :
			clazz = cid_watt_util_Values_;
			break;
		case WMDATE :
			clazz = cid_java_util_Date_;
			break;
		case WMGROUP :
			clazz = cid_app_server_Group_;
			break;
		case WMUSER :
			clazz = cid_app_server_User_;
			break;
		case WMTABLE :
			clazz = cid_watt_util_Table_;
			break;
		case WMIDATACODABLE:
			clazz = cid_watt_util_coder_IDataCodable_;
			break;
		case WMGENUTIL:
			clazz = cid_watt_client_util_GenUtil_;
			break;
		case WMSTRING :
			clazz = cid_java_lang_String_;
			break;
		case WMSTRINGARRAY :
			clazz = cid_java_lang_String_Array_;
			break;
		case WMSTRINGTABLE :
			clazz = cid_java_lang_String_Table_;
			break;
		case WMOBJECT :
			clazz = cid_java_lang_Object_;
			break;
		case WMBASECONTEXT :
			clazz = cid_watt_client_BaseContext_;
			break;
		case WMCONTEXT :
			clazz = cid_watt_client_Context_;
			break;
		case WMTCONTEXT :
			clazz = cid_watt_client_TContext_;
			break;
		case WMVECTOR :
			clazz = cid_java_util_Vector_;
			break;
		case WMIDATA :
			clazz = cid_watt_data_IData_;
			break;
		case WMIDATACURSOR :
			clazz = cid_watt_data_IDataCursor_;
			break;
		case WMIDATAHASHCURSOR :
			clazz = cid_watt_data_IDataHashCursor_;
			break;
		case WMIDATATREECURSOR :
			clazz = cid_watt_data_IDataTreeCursor_;
			break;
		case WMIDATAINDEXCURSOR :
			clazz = cid_watt_data_IDataIndexCursor_;
			break;
		case WMIDATAFACTORY :
			clazz = cid_watt_data_IDataFactory_;
			break;
		case WMEXCEPTION :
			clazz = cid_watt_client_Exception_;
			break;
		case WMIDATAUTIL :
			clazz = cid_watt_data_IDataUtil_;
			break;
		case WMBINCODER :
			clazz= cid_watt_util_coder_CoderHelper_;
			break;
		case WMINVOKETHREAD :
			clazz= cid_watt_client_InvokeThread_;
			break;
		case WMINVALID :
		default : clazz = NULL; break;
	}

	return clazz;
}


void WmGlobal::checkExceptions( JNIEnv *jenv )
	  throw( WmException )

{

	jthrowable ex = NULL;
	WmException *wmex = NULL;

	if( (ex=jenv->ExceptionOccurred()) != NULL )
	{
		jstring jmsg = (jstring)jenv->CallObjectMethod(
				ex,
				mid_getMessage_ );
		jobject clas = jenv->CallObjectMethod(
				ex,
				mid_getClass_ );
		jstring c_name = (jstring)jenv->CallObjectMethod(
				clas,
				mid_getName_ );

		jboolean is_copy, is_copy2;
		const char *msg;
		if(!jmsg)
			msg = EmptyExceptionMessage;
		else
			msg = jenv->GetStringUTFChars( jmsg, &is_copy );
		const char *name = jenv->GetStringUTFChars(c_name, &is_copy2 );

		WmException wmex((char*) msg, (char*)name, 502 );

		if( is_copy == JNI_TRUE )
		{
			jenv->ReleaseStringUTFChars( jmsg, msg );
		}
		jenv->DeleteLocalRef( jmsg );
		if( is_copy2 == JNI_TRUE )
		{
			jenv->ReleaseStringUTFChars( c_name, name );
		}
		jenv->DeleteLocalRef( c_name );
		jenv->ExceptionClear();

		describeException(wmex);

		throw wmex;
	}

}

void WmGlobal::describeException(WmException & wmex){
	cerr << wmex.getExceptionType() << ": ";
	cerr << wmex.getMessage() << endl;
}

void WmGlobal::monitorEnter( JNIEnv *jenv, jobject monitor )
  throw( WmException )
{
	jenv->MonitorEnter( monitor );
}

void WmGlobal::monitorExit( JNIEnv *jenv, jobject monitor )
  throw( WmException )
{
	jenv->MonitorExit( monitor );
}

JNIEnv *WmGlobal::attachCurrentThread()
  throw( WmException )
{
	JNIEnv *jenv = NULL;
#ifdef JAVA2
	JavaVMAttachArgs t_args;
	t_args.version=JNI_VERSION_1_2;
	t_args.name=NULL;
	t_args.group=0;

	if( jvm_->AttachCurrentThread((void **)&jenv, &t_args ) < 0 )
	{
		cerr << "Failed to attach the current thread" << endl;
		WmException wmex( "COULD_NOT_ATTACH_THREAD" );
		throw wmex;
	}
#else
	JDK1_1AttachArgs *t_args = NULL;
	if( jvm_->AttachCurrentThread(&jenv, &t_args) < 0 )
	{
		cerr << "Failed to attach the current thread" << endl;
		WmException wmex( "COULD_NOT_ATTACH_THREAD" );
		throw wmex;
	}
#endif
	return jenv;
}

void WmGlobal::detachCurrentThread()
  throw( WmException )
{
	if( jvm_->DetachCurrentThread() < 0 )
	{
		cerr << "Failed to detach the current thread" << endl;
		WmException wmex( "COULD_NOT_DETACH_THREAD" );
		throw wmex;
	}
}

void WmGlobal::destroyJavaVM()
{
	// always returns an error
	jint result = jvm_->DestroyJavaVM();
}

JNIEnv *WmGlobal::GetCreatedVM(const char *classpath)
  throw( WmException )
{
	jsize numVMToGet=1;
	jsize numVMExist=0;
	JNIEnv *jenv=0;

	if(!JNI_GetCreatedJavaVMs(&jvm_, numVMToGet, &numVMExist))
	{
		if(numVMExist==1)
		{
#ifdef JAVA2
			if(!jvm_->AttachCurrentThread((void**)&jenv, 0))
#else
			if(!jvm_->AttachCurrentThread(&jenv, 0))
#endif
			{
				initVars(jenv);
				initialized_ = 1;
			}
		}
	}

	if(!jenv)
	{
		jenv = initClientJVM( classpath );

	}

	return jenv;
}

JavaVM *WmGlobal::getJVMRef() 
{
	return jvm_; 
}