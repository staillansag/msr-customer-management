#ifndef _WmIDataCodable_H_
#define _WmIDataCodable_H_

#include "WmObject.h"
#include "WmPrefix.h"
#include "WmIData.h"

class _WmIDataCodable;
typedef _WmIDataCodable *WmIDataCodable;

class IMPORT_EXPORT_DLL _WmIDataCodable : public _WmObject{
	public:
		PREFIX _WmIDataCodable(JNIEnv* jenv);
		PREFIX _WmIDataCodable(JNIEnv* jenv, jobject idc, int manage_ref=0);

		PREFIX void setIData(WmIData idata);
		PREFIX WmIData getIData();
	protected:
		void initializeMethods();

		static jclass cid_;
		static jmethodID mid_setIData_IData_;
		static jmethodID mid_getIData_;
		static jmethodID mid_constructor_;
};

#endif 
	

