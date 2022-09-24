#ifndef WmBinCoder_h
#define WmBinCoder_h

#include "WmObject.h"
#include "WmPrefix.h"

class WmGlobal;
class _WmBinCoder;

typedef _WmBinCoder *WmBinCoder;

class IMPORT_EXPORT_DLL _WmBinCoder : public _WmObject
{
public:
	PREFIX _WmBinCoder( JNIEnv *jenv );

	PREFIX _WmBinCoder( JNIEnv *jenv, jobject values, int manage_ref=0 );

	PREFIX ~_WmBinCoder();

	PREFIX jbyteArray encodeToBytes( WmObject obj );

	PREFIX WmObject decodeFromBytes( jbyteArray obj );

	PREFIX jbyteArray encodeToBytes( jobject obj );

	PREFIX jobject decodeFromBytesJ( jbyteArray obj );

protected:
	void initializeMethods()
	  throw( WmException );

	static jmethodID	mid_encodeToBytes_Object_;
	static jmethodID	mid_decodeFromBytes_byteArray_;
	static jmethodID	mid_constructor_;

	static jclass		cid_;
};

#endif
