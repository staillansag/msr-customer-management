#include "WmUtil.h"
#include <string.h>
#include <time.h>
#ifdef _WIN32
#include <process.h>
#else
#include <unistd.h>
#endif

using namespace std;

std::ofstream *WmUtil::logFile;


jmethodID WmUtil :: mid_getString_IDataCursor_;
jmethodID WmUtil :: mid_getStringArray_IDataCursor_;
jmethodID WmUtil :: mid_getStringTable_IDataCursor_;
jmethodID WmUtil :: mid_printRec_IDataCodable_String_;

jclass WmUtil :: cid_GenUtil_;
jclass WmUtil :: cid_IDataUtil_;

JNIEnv* WmUtil :: jenv_;

WmString WmUtil :: getString(WmIDataCursor idc){
	jobject jobj;
	WmString obj = NULL;

	JNIEnv *javaEnv = WmGlobal::attachCurrentThread();

	jobj = javaEnv->CallStaticObjectMethod(cid_IDataUtil_,
			                     mid_getString_IDataCursor_,
					     idc->getJavaObject());
	obj = (WmString)WmGlobal::createWmObject(javaEnv, jobj, 1);
	WmGlobal::checkExceptions(javaEnv);
	return obj;
}

WmStringArray WmUtil :: getStringArray(WmIDataCursor idc){
	jobject jobj;
	WmStringArray obj = NULL;

	JNIEnv *javaEnv = WmGlobal::attachCurrentThread();

	jobj = javaEnv->CallStaticObjectMethod(cid_IDataUtil_,
					     mid_getStringArray_IDataCursor_,
					     idc->getJavaObject());
	obj = (WmStringArray)WmGlobal::createWmObject(javaEnv, jobj, 1);
	WmGlobal::checkExceptions(javaEnv);
	return obj;
}

WmTable WmUtil :: getStringTable(WmIDataCursor idc){
	jobject jobj;
	WmTable obj;

	JNIEnv *javaEnv = WmGlobal::attachCurrentThread();

	jobj = javaEnv->CallStaticObjectMethod(cid_IDataUtil_,
					     mid_getStringTable_IDataCursor_,
					     idc->getJavaObject());

	obj = (WmTable)WmGlobal::createWmObject(javaEnv, jobj, 1);
	WmGlobal::checkExceptions(javaEnv);
	return obj;
}

void WmUtil :: printRec(WmIData idc, WmString rec_name){

	JNIEnv *javaEnv = WmGlobal::attachCurrentThread();

	javaEnv->CallStaticVoidMethod(cid_GenUtil_,
			            mid_printRec_IDataCodable_String_,
				    idc->getJavaObject(),
				    rec_name->getJavaObject());
	WmGlobal::checkExceptions(javaEnv);
}

void WmUtil :: printRec(WmIData idc, char* rec_name){

	JNIEnv *javaEnv = WmGlobal::attachCurrentThread();

	WmString amc = new _WmString(javaEnv, rec_name);

	printRec(idc, amc);

	delete amc;

}

void WmUtil :: initializeJEnv(JNIEnv* env){
	jenv_ = env;
	initializeMethods();
}

void WmUtil :: initializeMethods()
//	throw( WmException )
{
	if( cid_IDataUtil_ == NULL && cid_GenUtil_ == NULL){
		try{
			WmGlobal::monitorEnter(jenv_);

			cid_IDataUtil_ = WmGlobal::getClassRef(WMIDATAUTIL);

			WmGlobal::checkExceptions(jenv_);

			cid_GenUtil_ = WmGlobal::getClassRef(WMGENUTIL);

			WmGlobal::checkExceptions(jenv_);

			mid_getString_IDataCursor_ =
				jenv_->GetStaticMethodID(
					cid_IDataUtil_,
					"getString",
					"(Lcom/wm/data/IDataCursor;)Ljava/lang/String;" );

			if(mid_getString_IDataCursor_ == NULL){
				cerr << "NULL getString()" << endl;
			}

			WmGlobal::checkExceptions(jenv_);

			mid_getStringArray_IDataCursor_ =
				jenv_->GetStaticMethodID(
					cid_IDataUtil_,
					"getStringArray",
					"(Lcom/wm/data/IDataCursor;)[Ljava/lang/String;" );

			WmGlobal::checkExceptions(jenv_);

			mid_getStringTable_IDataCursor_ =
				jenv_->GetStaticMethodID(
					cid_IDataUtil_,
					"getStringTable",
					"(Lcom/wm/data/IDataCursor;)[[Ljava/lang/String;" );

			WmGlobal::checkExceptions(jenv_);

			mid_printRec_IDataCodable_String_ =
				jenv_->GetStaticMethodID(
					cid_GenUtil_,
					"printRec",
					"(Lcom/wm/data/IData;Ljava/lang/String;)V" );

			WmGlobal::checkExceptions(jenv_);

			WmGlobal::monitorExit(jenv_);
		}
		catch( WmException &ex){
			throw ex;
		}
	}
}

void WmUtil :: createLogFile()
{

	if(getenv("WEBM_TRACE")) {
		char fileName[128];

		// Generate the unique file name.Will work only till 2038
		sprintf(fileName, "webm-%d-%d.log", getpid(), time(NULL));

		logFile = new ofstream;
		logFile->open( fileName );
	}
	else {
		logFile = 0;
	}
}

void WmUtil :: trace( char* msg )
{
	if(!logFile)
		return;

	time_t rawtime;
	struct tm *timeinfo;
	char timeString[80];

	time (&rawtime);

	timeinfo = gmtime(&rawtime);

	// Get the time in the formated string.
	strftime(timeString, 80, "%I:%M:%S %p", timeinfo);

	*logFile << timeString << ". " << msg << endl;
}

void WmUtil::closeLogFile()
{
	if(!logFile)
		return;

	logFile->close();

	delete logFile;

	logFile = 0;
}
