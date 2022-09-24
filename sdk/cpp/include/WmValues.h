#ifndef WmValues_h
#define WmValues_h

// NOTICE:  	Values is an out-of-date interface that is simply here for 
// 		backwards compatibility.

#include "WmObject.h"
#include "WmPrefix.h"
#include "WmString.h"
#include "WmIData.h"
#include "WmStringArray.h"


class WmGlobal;
class _WmValues;

typedef _WmValues *WmValues;

class IMPORT_EXPORT_DLL _WmValues : public _WmObject
{
public:
	PREFIX _WmValues( JNIEnv *jenv );

	PREFIX _WmValues( JNIEnv *jenv, jobject values, int manage_ref=0 );

	PREFIX virtual ~_WmValues();

	PREFIX int contains( WmObject obj ) const;

	PREFIX int containsKey( WmString key ) const;
	PREFIX int containsKey( char* key ) const;
	PREFIX int containsKey( jstring key ) const;

	PREFIX WmObject get( int idx ) const;

	PREFIX WmObject get( jstring key ) const;

	PREFIX WmObject get( WmString key ) const;

	PREFIX WmObject get( const char *key ) const;

	PREFIX int isEmpty() const;

	PREFIX int equals(WmValues);
	
	PREFIX jobject put( WmObject value );

	PREFIX jobject put( WmString key, WmObject value );

	PREFIX jobject put( const char *key, WmObject value );
	
	PREFIX jobject put( const char *key, const char *value );

	PREFIX jobject put( jstring key, jobject value );

	PREFIX WmObject remove( WmString key );

	PREFIX WmObject remove( jobject key );

	PREFIX WmObject remove( const char *key );

	PREFIX jint size();
	PREFIX WmString toString();
	PREFIX WmStringArray getValueKeys();

	// static utility method, used to add IData::toString()
	PREFIX static WmValues use(JNIEnv* jenv, WmIData data);

protected:
	void initializeMethods()
	  throw( WmException );

	jint		size_;

	static jmethodID	mid_use_IData_;
	static jmethodID	mid_contains_Object_;
	static jmethodID	mid_toString_;
	static jmethodID	mid_containsKey_String_;
	static jmethodID	mid_get_int_;
	static jmethodID	mid_isEmpty_;
	static jmethodID	mid_remove_String_;
	static jmethodID	mid_get_String_;
	static jmethodID	mid_equals_Values_;
	static jmethodID	mid_put_Object_;
	static jmethodID	mid_put_String_Object_;
	static jmethodID	mid_size_;
	static jmethodID	mid_constructor_;
	static jmethodID	mid_getValueKeys_Object_;

	static jclass		cid_;
};

#endif
