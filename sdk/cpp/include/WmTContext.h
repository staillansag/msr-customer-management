#ifndef WmTContext_H
#define WmTContext_H

#include "WmBaseContext.h"
#include "WmPrefix.h"

class _WmTContext;

typedef _WmTContext *WmTContext;

class IMPORT_EXPORT_DLL _WmTContext : public _WmBaseContext
{
	public:
		PREFIX _WmTContext();
		PREFIX _WmTContext(JNIEnv* jenv);
		PREFIX _WmTContext(JNIEnv* env, jobject context, int manage_ref);
		PREFIX _WmTContext(jobject context, int manage_ref);
		PREFIX ~_WmTContext();

		PREFIX static void init();
		PREFIX static void init(JNIEnv* env);
		PREFIX static void init(JNIEnv* env,WmString jobdir, WmString logfile);
		PREFIX static void init(JNIEnv* env, char* jobdir, char* logfile);
		PREFIX static void shutdown();
		PREFIX static void shutdown(int force);
		PREFIX static void resetJobMgr();
		PREFIX static void resetJobMgr(WmString jobdir, WmString logfile);
		PREFIX static void resetLogFile();
		PREFIX static void resetLogFile(WmString logfile);
		PREFIX void connect(WmString server, WmString user, WmString pass);
		PREFIX void connect(char* server, char* user, char* pass);
		PREFIX void connect(WmString server, char certificate[]);
		PREFIX void connect(WmString server, WmString certificate);
		PREFIX void disconnect();
		PREFIX WmString startTx();
		PREFIX WmString startTx(long ttl);
		PREFIX WmString startTx(long ttl, int retries);
 		PREFIX WmString startTx(WmString followTid);
     		PREFIX WmString startTx(WmString followTid, long ttl);
	     	PREFIX WmString startTx(WmString followTid, long ttl, int retries);
     		PREFIX WmIData invokeTx(WmString tid, WmString ifc, WmString svc, 
				 WmIData data);
     		PREFIX void submitTx(WmString tid, WmString ifc, WmString svc, 
			      WmIData data);
     		PREFIX void sendTx(WmString tid, WmString ifc, WmString svc, 
		            WmIData data);
     		PREFIX WmIData retrieveIDTx(WmString tid);
     		PREFIX WmIData retrieveIDTx(WmString tid, int block);
     		PREFIX void endTx(WmString tid);
     		PREFIX void restartTx(WmString tid);
     		PREFIX WmString getTxStatus(WmString tid);
     		PREFIX int getTxStatusVal(WmString tid);
     		PREFIX WmValues getTxData(WmString tid);
     		PREFIX WmIData getTxIData(WmString tid);
     		PREFIX WmString getRemoteTxId(WmString tid);
     		PREFIX WmString getChainedTxId(WmString tid);
     		PREFIX WmIData invokeJob(WmString ifc, WmString svc, WmIData data);
     		PREFIX WmIData clusterInvokeJob(WmString ifc, WmString svc, 
				         WmIData data);
     		PREFIX void dumpJobs();
     		PREFIX WmStringArray getValueKeys();
     		PREFIX WmObject getValue(WmString key);
     		PREFIX void setValue(WmString key, WmObject value);
    		PREFIX void setSSLCertificates(WmString keyPath, WmStringArray certPaths);
     		PREFIX void updateCredentials();

		// For backwards compatibility

     		PREFIX WmValues retrieveTx(WmString tid);
     		PREFIX void submitTx(WmString tid, WmString ifc, WmString svc, 
			      WmValues data);
     		PREFIX void sendTx(WmString tid, WmString ifc, WmString svc, 
			    WmValues data);
     		PREFIX WmValues retrieveTx(WmString tid, int block);
     		PREFIX WmValues invokeTx(WmString tid, WmString ifc, WmString svc, 
				  WmValues data);
     		PREFIX WmValues clusterInvokeJob(WmString ifc, WmString svc, 
				          WmValues data);
     		PREFIX WmValues invokeJob(WmString ifc, WmString svc, WmValues data);

	protected:
		void initializeMethods();
		static void initializeStaticMethods();

		static int initialized;
		static jclass Scid_;

		static jmethodID mid_constructor_;
		static jmethodID mid_init_;
		static jmethodID mid_init_String_String_;
		static jmethodID mid_shutdown_;
		static jmethodID mid_shutdown_int_;
		static jmethodID mid_resetJobMgr_;
		static jmethodID mid_resetJobMgr_String_String_;
		static jmethodID mid_resetLogFile_;
		static jmethodID mid_resetLogFile_String_;
		static jmethodID mid_connect_String_String_String_;
		static jmethodID mid_connect_String_char_;
		static jmethodID mid_connect_String_String_;
		static jmethodID mid_disconnect_;
		static jmethodID mid_startTx_;
		static jmethodID mid_startTx_long_;
		static jmethodID mid_startTx_long_int_;
		static jmethodID mid_startTx_String_;
		static jmethodID mid_startTx_String_long_;
		static jmethodID mid_startTx_String_long_int_;
		static jmethodID mid_invokeTx_String_String_String_Values_;
		static jmethodID mid_invokeTx_String_String_String_IData_;
		static jmethodID mid_submitTx_String_String_String_Values_;
		static jmethodID mid_submitTx_String_String_String_IData_;
		static jmethodID mid_sendTx_String_String_String_Values_;
		static jmethodID mid_sendTx_String_String_String_IData_;
		static jmethodID mid_retrieveTx_String_;
		static jmethodID mid_retrieveIDTx_String_;
		static jmethodID mid_retrieveTx_String_int_;
		static jmethodID mid_retrieveIDTx_String_int_;
		static jmethodID mid_endTx_String_;
		static jmethodID mid_restartTx_String_;
		static jmethodID mid_getTxStatus_String_;
		static jmethodID mid_getTxStatusVal_String_;
		static jmethodID mid_getTxData_String_;
		static jmethodID mid_getTxIData_String_;
		static jmethodID mid_getRemoteTxId_String_;
     		static jmethodID mid_getChainedTxId_String_;
		static jmethodID mid_invokeJob_String_String_Values_;
		static jmethodID mid_invokeJob_String_String_IData_;
		static jmethodID mid_clusterInvokeJob_String_String_Values_;
		static jmethodID mid_clusterInvokeJob_String_String_IData_;
		static jmethodID mid_dumpJobs_;
		static jmethodID mid_getValueKeys_;
		static jmethodID mid_getValue_String_;
		static jmethodID mid_setValue_String_Object_;
		static jmethodID mid_setSSLCertificates_String_StringArray_;
		static jmethodID mid_updateCredentials_;

		static jclass cid_;
		static JNIEnv* Sjenv_;
};

#endif /* WmTContext_H */
		
		



