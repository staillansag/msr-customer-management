#ifndef WmContext_h
#define WmContext_h

#include "WmObject.h"
#include "WmPrefix.h"
#include "WmValues.h"
#include "WmIData.h"
#include "WmString.h"
#include "WmBaseContext.h"
#include "WmInvokeThread.h"

class _WmContext;

typedef _WmContext *WmContext;

class IMPORT_EXPORT_DLL _WmContext : public _WmBaseContext
{
	public:
		PREFIX _WmContext( JNIEnv *env );
		PREFIX _WmContext( JNIEnv *env, jobject context, 
			    int manage_ref=0 );
		PREFIX ~_WmContext();

		PREFIX WmIData invoke(WmString ifc, WmString svc, WmIData idata);	
		PREFIX WmIData invoke(jstring ifc, jstring svc, WmIData idata);	
		PREFIX WmIData invoke(char* ifc, char* svc, WmIData idata);	
		PREFIX WmIData clusterSvcInvoke(WmString ifc, WmString svc, WmIData in);
		PREFIX WmIData clusterSvcInvoke(char* ifc, char* svc, WmIData in);
		PREFIX WmIData invoke(WmString ifc, WmString svc, 
				WmIData idata, int isConnect);
		PREFIX WmIData invoke(char* ifc, char* svc, WmIData idata, 
			       int isConnect);
		PREFIX int isConnected();
		PREFIX int isSecure();
		PREFIX void setFixedUri(WmString uri);
		PREFIX void connect(WmString host, WmString user, WmString pwd);
		PREFIX void connect(jstring host, jstring user, jstring pwd);
		PREFIX void connect(char *host, char *user, char *pwd);
		PREFIX void disconnect();
		PREFIX void setFixedUri(jstring uri);
		PREFIX void setFixedUri(char *uri);
		PREFIX void setProxy(WmString proxy, WmString user=NULL, 
			      WmString pass=NULL);
		PREFIX void setProxy(jstring proxy, jstring user=NULL, 
			      jstring pass=NULL);
		PREFIX void setProxy(char *proxy, char *user=NULL, char *pass=NULL);
		PREFIX void setSecure(int setting);
		PREFIX void setSecureProxy(WmString proxy, WmString user=NULL, 
				    WmString pass=NULL);
		PREFIX void setSecureProxy(jstring proxy, jstring user=NULL, 
				    jstring pass=NULL);
		PREFIX void setSecureProxy(char *proxy, char *user=NULL, 
				    char *pass=NULL);

		// For backwards compatibility
		
		PREFIX WmInvokeThread invokeThreaded(jstring ifc, jstring svc, WmValues vals);
		PREFIX WmInvokeThread invokeThreaded(char* ifc, char* svc, WmValues vals);
		PREFIX WmValues invoke(WmString ifc, WmString svc, WmValues vals);
		PREFIX WmValues invoke(jstring ifc, jstring svc, WmValues vals);
		PREFIX WmValues invoke(char *ifc, char *svc, WmValues vals);
		PREFIX WmValues clusterSvcInvoke(WmString ifc, WmString svc, 
				          WmValues in);
		PREFIX WmValues clusterSvcInvoke(char* ifc, char* svc, WmValues in);



	protected:
		void initializeMethods()
			throw( WmException );

		static jmethodID	mid_constructor_;
		static jmethodID	mid_connect_String_String_String_;
		static jmethodID	mid_disconnect_;
		static jmethodID	mid_invoke_String_String_Values_;
		static jmethodID	mid_invokeThreaded_String_String_Values_;
		static jmethodID	mid_isConnected_;
		static jmethodID	mid_isSecure_;
		static jmethodID	mid_setFixedUri_String_;
		static jmethodID	mid_setProxy_String_String_String_;
		static jmethodID	mid_setSecure_int_;
		static jmethodID	mid_setSecureProxy_String_String_String_;

		static jmethodID 	mid_invoke_String_String_IData_;	
		static jmethodID 	mid_clusterSvcInvoke_String_String_Values_;
		static jmethodID 	mid_clusterSvcInvoke_String_String_IData_;
		static jmethodID 	mid_invoke_String_String_IData_int_;

		static jclass	cid_;

};

#endif
