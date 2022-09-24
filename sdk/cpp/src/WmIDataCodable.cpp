#include "WmIDataCodable.h"
#include "WmGlobal.h"

jmethodID _WmIDataCodable :: mid_setIData_IData_;
jmethodID _WmIDataCodable :: mid_getIData_;
//jmethodID _WmIDataCodable :: mid_constructor_;
jclass _WmIDataCodable :: cid_;


_WmIDataCodable :: _WmIDataCodable(JNIEnv *jenv) : _WmObject(jenv){
	initializeMethods();

	manage_ref_ = 1;

	type_ = WMIDATACODABLE;

	checkExceptions();
}

_WmIDataCodable :: _WmIDataCodable(JNIEnv *jenv, jobject idc, int manage_ref):
	_WmObject(jenv, idc, manage_ref)
{
	initializeMethods();

	type_ = WMIDATACODABLE;

	checkExceptions();
}

void _WmIDataCodable :: setIData(WmIData idata){
	jenv_->CallVoidMethod(jobj_, mid_setIData_IData_, 
			      idata->getJavaObject());
	checkExceptions();
}

WmIData _WmIDataCodable :: getIData(){
	jobject jobj;
	WmIData obj;

	jobj = jenv_->CallObjectMethod(jobj_, mid_getIData_ );

	obj = (WmIData)WmGlobal::createWmObject(jenv_, jobj, 1);
	checkExceptions();

	return obj;
}

void _WmIDataCodable :: initializeMethods()
//  throw( WmException )
{
	if(cid_ == NULL)
	{
		try
		{
			WmGlobal::monitorEnter( jenv_ );

			if(cid_ != NULL)
			{
				WmGlobal ::monitorExit( jenv_ );
				return;
			}

			cid_ = WmGlobal :: getClassRef( WMIDATACODABLE );

//			mid_constructor_ = jenv_->GetMethodID(
//					cid_,
//					"<init>",
//					"()V" );

			checkExceptions();

			mid_setIData_IData_ = jenv_->GetMethodID(
					cid_,
					"setIData",
					"(Lcom/wm/data/IData;)V" );

			checkExceptions();

			mid_getIData_ = jenv_->GetMethodID(
					cid_,
					"getIData",
					"()Lcom/wm/data/IData;" );

			checkExceptions();

			WmGlobal::monitorExit( jenv_ );
		}
		catch( WmException &ex)
		{
			throw ex;
		}
	}
}

