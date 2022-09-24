#include "WmObjectArrayT.h"
#include "WmGlobal.h"


template <class ObjType> _WmObjectArrayT<ObjType>::_WmObjectArrayT( JNIEnv *env, WmObjectType element_type, jint size ) :
	_WmObject( env )
{
	size_ = size;
	type_ = WMOBJECTARRAY;
	element_type_ = element_type;

	jobj_array_ = jenv_->NewObjectArray(
		size_,
		WmGlobal::getClassRef( element_type_ ),
		NULL );

	manage_ref_ = 1;

	checkExceptions();

	jobj_ = jobj_array_;

	wmobj_array_ = NULL;
}

template <class ObjType> _WmObjectArrayT<ObjType>::_WmObjectArrayT( JNIEnv *env, jobjectArray obj_array, WmObjectType element_type, int manage_ref ) :
	_WmObject( env, obj_array, manage_ref )
{
	type_ = WMOBJECTARRAY;
	element_type_ = element_type;

	jobj_array_ = obj_array;
	size_ = length();

	wmobj_array_ = new ObjType[size_];

	for( int i = 0; i < size_; i++ )
	{
		wmobj_array_[i] = NULL;
	}
}

template <class ObjType> _WmObjectArrayT<ObjType>::~_WmObjectArrayT()
{
	delete [] wmobj_array_;
}

template <class ObjType> jobjectArray _WmObjectArrayT<ObjType>::getJavaObjectArray()
{
	return jobj_array_;
}

template <class ObjType> ObjType _WmObjectArrayT<ObjType>::getElement( jint idx )
{
	ObjType element = NULL;
	jobject jobj = NULL;

	jobj = jenv_->GetObjectArrayElement( jobj_array_, idx );

	checkExceptions();

	element = (ObjType)WmGlobal::createWmObject( jenv_, jobj, 1 );

	return element;
}

template <class ObjType> void _WmObjectArrayT<ObjType>::setElement( jint idx, ObjType obj )
{
	jenv_->SetObjectArrayElement( jobj_array_, idx, obj->getJavaObject() );

	checkExceptions();
}

template <class ObjType> jint _WmObjectArrayT<ObjType>::length()
{
	jint len = jenv_->GetArrayLength( jobj_array_ );

	checkExceptions();

	return len;
}

template class _WmObjectArrayT<WmObject>;
template class _WmObjectArrayT<WmValues>;
template class _WmObjectArrayT<WmIData>;
template class _WmObjectArrayT<WmString>;
template class _WmObjectArrayT<WmStringArray>;
