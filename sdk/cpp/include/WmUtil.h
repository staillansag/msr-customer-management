#ifndef _WmUtil_H_
#define _WmUtil_H_

#include <jni.h>
#include "WmGlobal.h"
#include "WmPrefix.h"
#include "WmStringArray.h"
#include "WmString.h"
#include "WmTable.h"
#include "WmIDataCursor.h"
#include "WmIDataCodable.h"
#include <fstream>

class IMPORT_EXPORT_DLL WmUtil{
	public:
		PREFIX static WmString getString(WmIDataCursor idc);
		PREFIX static WmStringArray getStringArray(WmIDataCursor idc);
		PREFIX static WmTable getStringTable(WmIDataCursor idc);
		PREFIX static void printRec(WmIData idc, WmString rec_name);
		PREFIX static void printRec(WmIData idc, char* rec);
		PREFIX static void initializeJEnv(JNIEnv* env);

		/////////////////////
		static std::ofstream *logFile;
		PREFIX static void createLogFile();
		PREFIX static void trace( char* msg );
		PREFIX static void closeLogFile();
		/////////////////////

	private:
		static void initializeMethods();
		static JNIEnv *jenv_;

		static jclass cid_GenUtil_;
		static jclass cid_IDataUtil_;

		static jmethodID mid_getString_IDataCursor_;
		static jmethodID mid_getStringArray_IDataCursor_;
		static jmethodID mid_getStringTable_IDataCursor_;
		static jmethodID mid_printRec_IDataCodable_String_;
};

#endif

