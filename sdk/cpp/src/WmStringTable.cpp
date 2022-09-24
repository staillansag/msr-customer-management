#include "WmStringTable.h"
#include "WmGlobal.h"

jclass _WmStringTable :: cid_;
jclass _WmStringTable :: cid_java_lang_String_;
jclass _WmStringTable :: cid_java_lang_String_Array_;

_WmStringTable :: _WmStringTable(JNIEnv *jenv) : _WmObject(jenv)
{
	_WmStringTable(jenv, 0 , 0);
}

_WmStringTable :: _WmStringTable( JNIEnv *env, jobjectArray o, int manage_ref):
	_WmObject(env, (jobject)o, manage_ref)
{
	initializeMethods();

	type_ = WMSTRINGARRAY;
	jstrtable_ = o;

	jobj_ = jstrtable_;

	checkExceptions();
}

_WmStringTable:: _WmStringTable( JNIEnv *env, int rows, int cols ) :
	_WmObject(env)
{
	initializeMethods();
	rows_ = rows; cols_ = cols;
	type_ = WMSTRINGTABLE;

	WmString ogString = new _WmString(env, "");

	jarray jtmp = jenv_->NewObjectArray(cols, cid_java_lang_String_, 
			                    ogString->getJavaObject());


	jstrtable_ = jenv_->NewObjectArray(rows, 
			                   cid_java_lang_String_Array_, 
					   jtmp);
	jobj_ = jstrtable_;

	manage_ref_ = 1;

	checkExceptions();
}

int _WmStringTable :: rows(){ 
	return rows_; 
}

int _WmStringTable :: columns(){ 
	return cols_; 
}

WmStringArray _WmStringTable :: getRow(int row){
	if(row > rows_ || row < 0) return NULL;

        jobject jstrarray = jenv_->GetObjectArrayElement(jstrtable_, row);

	return (WmStringArray)WmGlobal::createWmObject(jenv_, jstrarray, 1);
}

WmString _WmStringTable :: getValue(int row, int column){
	if(row > rows_ || column > cols_ || row*column < 0 ) return NULL;

	jobjectArray jstrarray = 
		(jobjectArray)jenv_->GetObjectArrayElement(jstrtable_, row);

	jobject jstr = jenv_->GetObjectArrayElement(jstrarray, column);

	return (WmString)WmGlobal::createWmObject(jenv_, jstr, 1);
}

void _WmStringTable :: setRow(int row, WmStringArray strarray){
	jenv_->SetObjectArrayElement(jstrtable_, row, 
			             strarray->getJavaObject());
	checkExceptions();
}

void _WmStringTable :: setElement(int row, int cols, WmString str){
	jobjectArray jstrarray = 
		(jobjectArray)jenv_->GetObjectArrayElement(jstrtable_, row);
  
	// jstrarray is a local copy...

	jenv_->SetObjectArrayElement(jstrarray, cols, str->getJavaObject());

	jenv_->SetObjectArrayElement(jstrtable_, row, jstrarray);

	checkExceptions();
}
	

void _WmStringTable :: initializeMethods()
  throw( WmException )
{
	if( cid_ == NULL )
	{
		try
		{
			WmGlobal::monitorEnter(jenv_);

			if(cid_ != NULL)
			{
				WmGlobal::monitorExit(jenv_);
				return;
			}

			cid_ = WmGlobal::getClassRef( WMSTRINGTABLE );
			if(cid_ == NULL){
				throw WmException("Can't get reference to String[][]");
			}
			cid_java_lang_String_ =
				WmGlobal::getClassRef( WMSTRING );
			if(cid_java_lang_String_ == NULL){
				throw WmException("Can't get reference to String");
			}
			cid_java_lang_String_Array_ = 
			   	WmGlobal::getClassRef( WMSTRINGARRAY );
			if(cid_java_lang_String_Array_ == NULL){
				throw WmException("Can't get reference to String");
			}
			checkExceptions();

			WmGlobal :: monitorExit(jenv_);
		}
		catch( WmException &ex){
			throw ex;
		}
	}
}




	
			                    
