#ifndef _WmBaseContext_H_
#define _WmBaseContext_H_

#include <jni.h>
#include "WmPrefix.h"
#include "WmObject.h"
#include "WmString.h"
#include "WmValues.h"
#include "WmIData.h"
#include "WmStringArray.h"

class _WmBaseContext;

typedef _WmBaseContext *WmBaseContext;

const int RPC_BIN  = 1;     // RPC Types
const int RPC_XML  = 2;
const int RPC_IDAT = 3;


class IMPORT_EXPORT_DLL _WmBaseContext : public _WmObject
{
	public:
		PREFIX _WmBaseContext( JNIEnv *env );
		PREFIX _WmBaseContext( JNIEnv *env, jobject boom,
				int manage_ref=0 );
		PREFIX ~_WmBaseContext();

		PREFIX void setRpc2Ver(int v);
		PREFIX void setServers(WmValues servers);
		PREFIX WmValues getServers();
		PREFIX WmString getConnectedServer();
		PREFIX int getNumHosts();
		PREFIX int isClusteredEnv();
		PREFIX void setRetryServer(WmString svr);
		PREFIX void setAllowRedir(int);

		PREFIX void setSecure(int sec);
		PREFIX int isSecure();
		PREFIX int isConnected();
		PREFIX void setFixedUri(WmString uri);
		PREFIX void setRPCType(int);
		PREFIX void setProxy(WmString host, WmString user, WmString pass);
		PREFIX void setSecureProxy(WmString host, WmString user, WmString pass);
		PREFIX void setAuthentication(WmString user, WmString pass);
		PREFIX char* getCertificate(WmString certPath);
		PREFIX void setSSLCertificates(WmString cert, WmString pk, WmString crt);
		PREFIX void setSSLCertificates(WmString pKey, WmStringArray crtChn);
		PREFIX void setInvokeDirective(WmString directive);
		PREFIX int isPipeBroken(WmString ifc, WmString svc);



	protected:
		void initializeMethods();
		void loadWmHandler();
		void checkConnection();
		WmString getHost(WmString hostport);
		WmString getPort(WmString hostport, WmString defPort);
		void cleanupSession();
		WmObject getCoder();
		WmIData clusterInvoke(WmValues cServers, WmString cSession,
				      WmString cServer, int max, WmString ifc,
				      WmString svc, WmIData inData);
		WmIData clusterInvoke(WmValues clusterServers, int maxTries,
				       WmString ifc, WmString svc,
				       WmIData inData);


		WmValues clusterInvoke(WmValues clusterServers, WmString SesID,
				      WmString cServer, int max, WmString ifc,
				      WmString svc, WmValues inData);
		WmValues clusterInvoke(WmValues clusterServers, int maxTries,
				       WmString ifc, WmString svc,
				       WmValues inData);

		static jmethodID mid_constructor_;
		static jmethodID mid_setRpc2Ver_int_;
		static jmethodID mid_setServers_Values_;
		static jmethodID mid_getServers_;
		static jmethodID mid_getConnectedServer_;
		static jmethodID mid_getNumHosts_;
		static jmethodID mid_isClusteredEnv_;
		static jmethodID mid_setRetryServer_String_;
		static jmethodID mid_setAllowRedir_int_;
		static jmethodID mid_setSecure_int_;
		static jmethodID mid_isSecure_;
		static jmethodID mid_isConnected_;
		static jmethodID mid_setFixedUri_String_;
		static jmethodID mid_setRPCType_int_;
		static jmethodID mid_setProxy_String_String_String_;
		static jmethodID mid_setSecureProxy_String_String_String_;
		static jmethodID mid_setAuthentication_String_String_;
		static jmethodID mid_getCertificate_String_;
		static jmethodID mid_setSSLCertificates_String_String_String_;
		static jmethodID mid_setSSLCertificates_String_StringArray_;
		static jmethodID mid_setInvokeDirective_String_;
		static jmethodID mid_isPipeBroken_String_String_;
		static jmethodID mid_loadWmHandler_;
		static jmethodID mid_checkConnection_;
		static jmethodID mid_getHost_String_;
		static jmethodID mid_getPort_String_String_;
		static jmethodID mid_cleanupSession_;
		static jmethodID mid_getCoder_;
		static jmethodID mid_clusterInvoke_Values_String_String_int_String_String_IData_;
		static jmethodID mid_clusterInvoke_Values_int_String_String_IData_;
	 	static jmethodID mid_clusterInvoke_Values_String_String_int_String_String_Values_;
	 	static jmethodID mid_clusterInvoke_Values_int_String_String_Values_;

		static jclass cid_;


};


#endif
