/*
 *  wmJNIc.h:  API for C/C++ clients.
 *
 * Copyright (C) 1996-1999, webMethods, Inc. All Rights Reserved.
 */

/*
 *  This module is used in conjunction with wmJNI.h to provide C client
 *  access to B2B services.  It uses JNI to wrap the Java-based APIs
 *  implemented as Context (for normal invocations) and TContext (for
 *  guaranteed delivery or transactional invocations).
 *
 *  See wmJNI.h for details on the WmContext and the various context
 *  types used by the client API; wmJNI.h also provides details on
 *  working with WmRecords which are used for service input and output.
 *
 *  Normally, you will first call initWmClient() to initialize the
 *  JNI environment.  However, if you need to modify the standard
 *  JVM arguments, or pass properties to the JVM, you will need to do
 *  so before initialization.  To set JVM options, construct your own
 *  JDK1_1InitArgs (see jni.h) and set the external variable wm_jvm_args.
 *  To pass properties, call initJVM1_1Args(char** properties) with a
 *  zero-terminated array of strings in "name=value" form; classpath
 *  is set directly from the CLASSPATH environment variable.  When done
 *  make sure to call shutdownWmClient().
 *
 *  All API calls are tagged with the type of context that is being
 *  used.  Note that the TContext shares some calls with the normal client
 *  context - in particular setting rpc types, connection attributes, and
 *  security credentials.  Also note that the transactional calls (Tx)
 *  can only be used with TContext as they all require a transaction id
 *  (WmTid) whereas the sync and async calls are only used with a normal
 *  context.
 *
 *  When using the TContext (from a client not embedded in a B2B service)
 *  you will also have to initialize the transaction manager, as well as
 *  shut it down when you are done.
 *
 *  If you intend to share contexts between threads, make sure to clone
 *  your context.  This allows you to specify connection attributes once in
 *  a master thread and to leverage those settings when constructing new
 *  contexts in spawned threads.  For TContext, make sure to initWMTContext()
 *  from same master thread after initWMClient().
 *
 *  Also, remember to clean up all retrieved references with freeWmName() for
 *  objects and freeWmString() for strings.
 *
 */

#ifndef WMJNIC_H
#define WMJNIC_H

#include "wmJNI.h"
#include "wmUtil.h"

/* JVM globals - use if leveraging JNI directly */
extern JavaVM 	*wm_jvm;
extern JNIEnv 	*wm_jvm_env;

/* JVM-specific globals - must be cast; default types are for 1.1 */
extern void		*wm_jvm_args;	/* JDK1_1InitArgs */
extern void		*wm_thr_args;	/* JDK1_1AttachArgs */

/* RPC Types for Client Context and TContext */
#define WM_RPC_BIN		0
#define WM_RPC_XML		1

/* WmTContext Tx Status Values */
#define WM_TX_NEW		0
#define WM_TX_PENDING	1
#define WM_TX_DONE		2
#define WM_TX_FAILED	3


/************************** API  *************************************/

#ifdef __cplusplus
extern "C" {
#endif

PREFIX jint			initJVM1_1Args(char** properties);	/* setup JVM before init */

PREFIX jint			initWmClient();			/* for all clients */
PREFIX void			shutdownWmClient();

PREFIX jint			initWmTContext();		/* after client init */
PREFIX jint			initWmTContextWithArgs(const char *jobdir,
						const char *logpath);
PREFIX jint			shutdownWmTContext(jint force);

PREFIX jint			resetWmTContext();
PREFIX jint			resetWmTContextWithArgs(const char *jobdir,
						const char *logpath);
PREFIX jint			resetWmTContextLog();
PREFIX jint			resetWmTContextLogWithArgs(const char *logpath);

PREFIX WmCContext *	newWmClientContext();
PREFIX WmTContext *	newWmTContext();
PREFIX WmContext *	cloneWmContext(WmContext *con);
PREFIX void			freeWmContext(WmContext **con);

PREFIX jint			setCcRPCType(WmCContext *con, jint type);
PREFIX jint			setCcSecure(WmCContext *con, jint flag);
PREFIX jint 		setCcProxy(WmCContext *con, const char *host,
						const char *user, const char *pass);
PREFIX jint			setCcSecureProxy(WmCContext *con, const char *host,
						const char *user, const char *pass);
PREFIX jint			setCcSSLCertificates(WmCContext *con,
						const char *cert, const char *privkey,
						const char *ca);
PREFIX jint			setScFixedUri(WmSContext *con, const char *uri);

PREFIX jint			isCcSecure(WmCContext *con);
PREFIX jint 		isCcConnected(WmCContext *con);

PREFIX jint			connectCcUserPass(WmCContext *con, const char *host,
						const char *user, const char *pass);
PREFIX jint			connectCcCert(WmCContext *con, const char *host,
						const char *cert);
PREFIX jint			connectCcCertPath(WmCContext *con, const char *host,
						const char *cert_path);
PREFIX jint			disconnectCc(WmCContext *con);

PREFIX WmRecord *	invokeWmSync(WmSContext *con, const char *ifc,
						const char *svc, WmRecord *in);
PREFIX WmAContext *	invokeWmAsync(WmSContext *con, const char *ifc,
						const char *svc, WmRecord *in);
PREFIX WmRecord *	getWmAsyncData(WmAContext *con);

PREFIX WmTid		startWmTx(WmTContext *con);
PREFIX WmTid		startWmTxTtl(WmTContext *con, jlong ttlInMins);
PREFIX WmTid		startWmTxRetries(WmTContext *con, jlong ttlInMins,
						jlong retries);
PREFIX jint			restartWmTx(WmTContext *con, WmTid tid);
PREFIX jint			endWmTx(WmTContext *con, WmTid tid);

PREFIX WmTid		chainWmTx(WmTContext *con, WmTid chainid);
PREFIX WmTid		chainWmTxTtl(WmTContext *con, WmTid chainid, jlong ttlInMins);
PREFIX WmTid		chainWmTxRetries(WmTContext *con, WmTid chainid,
						jlong ttlInMins, jlong retries);

PREFIX WmRecord *	invokeWmTx(WmTContext *con, WmTid tid, const char *ifc,
						const char *svc, WmRecord *in);
PREFIX jint			submitWmTx(WmTContext *con, WmTid tid, const char *ifc,
						const char *svc, WmRecord *in);
PREFIX WmRecord *	retrieveWmTx(WmTContext *con, WmTid tid, jint block);

PREFIX WmEContext *	getWmTxIds(WmTContext *con);
PREFIX WmTid		getNextWmTxId(WmEContext *con);
PREFIX char *		getWmTxStatus(WmTContext *con, WmTid tid);
PREFIX jint			getWmTxStatusVal(WmTContext *con, WmTid tid);

PREFIX WmTid		getWmTxRmtId(WmTContext *con, WmTid tid);
PREFIX WmTid        getWmTxChainId(WmTContext *con, WmTid tid);

#ifdef __cplusplus
}
#endif

#endif /* WMJNIC_H */
