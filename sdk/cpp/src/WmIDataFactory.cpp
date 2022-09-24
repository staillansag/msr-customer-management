#include "WmIData.h"
#include "WmGlobal.h"
#include "WmIDataFactory.h"

jmethodID WmIDataFactory::mid_constructor_;
jmethodID WmIDataFactory::mid_create_;
jmethodID WmIDataFactory::mid_create_int_;
jmethodID WmIDataFactory::mid_create_Object_;
jmethodID WmIDataFactory::mid_create_String_;
jmethodID WmIDataFactory::mid_register_String_String_;
JNIEnv*   WmIDataFactory::Sjenv_;

jclass WmIDataFactory::cid_;

void WmIDataFactory :: initializeJEnv(JNIEnv* jenv){ Sjenv_ = jenv; }

WmIData WmIDataFactory :: create(){
	initializeMethods();
	WmIData result;
	jobject jresult;

	try
	{
		JNIEnv *javaEnv = WmGlobal::attachCurrentThread();

		jresult = javaEnv->CallStaticObjectMethod(cid_,
			mid_create_ );

		WmGlobal::checkExceptions(javaEnv);
		result = (WmIData)WmGlobal::createWmObject(javaEnv, jresult, 1);
	}
	catch( WmException &ex )
	{
		throw ex;
	}

	return result;
}

WmIData WmIDataFactory :: create(int size){
	initializeMethods();
	WmIData result;
	jobject jresult;

	try
	{
		JNIEnv *javaEnv = WmGlobal::attachCurrentThread();

		jresult = javaEnv->CallStaticObjectMethod(cid_,
				mid_create_int_, size);
		WmGlobal::checkExceptions(javaEnv);

		result = (WmIData)WmGlobal::createWmObject(javaEnv, jresult, 1);
	}
	catch( WmException &ex )
	{
		throw ex;
	}

	return result;
}

WmIData WmIDataFactory :: create( WmString name){
	initializeMethods();
	WmIData result;
	jobject jresult;

	try{
		JNIEnv *javaEnv = WmGlobal::attachCurrentThread();

		jresult = javaEnv->CallStaticObjectMethod(
				cid_,
				mid_create_String_,
				(jstring)name->getJavaObject() );
		WmGlobal::checkExceptions(javaEnv);

		result = (WmIData)WmGlobal :: createWmObject(javaEnv, jresult, 1);

	}
	catch( WmException &ex ){
		throw ex;
	}

	return result;
}

void WmIDataFactory :: Register(char* name, char* className){
	WmString n1, c1;

	JNIEnv *javaEnv = WmGlobal::attachCurrentThread();

	n1 = new _WmString(javaEnv, name);
	c1 = new _WmString(javaEnv, className);

	Register(n1, c1);
	delete n1; delete c1;

}

void WmIDataFactory :: Register(WmString name, WmString className){
	initializeMethods();
	try{

		JNIEnv *javaEnv = WmGlobal::attachCurrentThread();
		
		javaEnv->CallStaticVoidMethod(cid_,
				        mid_register_String_String_,
					(jstring)name->getJavaObject(),
					(jstring)className->getJavaObject() );
		WmGlobal::checkExceptions(javaEnv);

        }
	catch( WmException &ex )
	{
		throw ex;
	}

}

void WmIDataFactory :: initializeMethods()
	throw( WmException )
{
	if(Sjenv_ == NULL){
		throw WmException("NULL java environment!!!");
	}
	if( cid_ == NULL ){
		try{
			WmGlobal::monitorEnter( Sjenv_ );

			if( cid_ != NULL )
			{
				WmGlobal::monitorExit(Sjenv_);
				return;
			}

			cid_ = WmGlobal::getClassRef( WMIDATAFACTORY );

			WmGlobal::checkExceptions(Sjenv_);

			mid_register_String_String_ =
				Sjenv_->GetStaticMethodID(
				   cid_,
	      			   "register",
	                           "(Ljava/lang/String;Ljava/lang/String;)V"
				 );

			WmGlobal::checkExceptions(Sjenv_);

			mid_create_ = Sjenv_->GetStaticMethodID( cid_,
					                  "create",
							  "()Lcom/wm/data/IData;");

			WmGlobal::checkExceptions(Sjenv_);

			mid_create_int_ = Sjenv_->GetStaticMethodID(
					              cid_,
				                      "create",
							  "(I)Lcom/wm/data/IData;");

			WmGlobal::checkExceptions(Sjenv_);

			mid_create_Object_ = Sjenv_->GetStaticMethodID(
					             cid_,
						     "create",
					     "([[Ljava/lang/Object;)Lcom/wm/data/IData;");

			WmGlobal::checkExceptions(Sjenv_);

			mid_create_String_ = Sjenv_->GetStaticMethodID(
					             cid_,
						     "create",
						     "(Ljava/lang/String;)Lcom/wm/data/IData;" );
			WmGlobal::checkExceptions(Sjenv_);

			WmGlobal::monitorExit( Sjenv_ );
		}
		catch( WmException &ex){
			throw ex;
		}
	}
}




