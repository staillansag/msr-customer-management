/*
 *  wmJNI.h:  API for C/C++ Services and Clients.
 *
 * Copyright (C) 1996-1999, webMethods, Inc. All Rights Reserved.
 */

/*
 *  This module can be used alone to implement C Services or it can
 *  be used with wmJNIc.h to implement C clients that invoke B2B
 *  services.  Both capabilities are based on the JNI - these APIs
 *  wrap the JNI as a convenience to working with the core B2B
 *  Java APIs.  However, the JNI may be used directly in place of, or
 *  in conjunction with these APIs.
 *
 *  Since these modules provide thin wrappers over the core B2B Java
 *  APIs, please consult those APIs directly to better understand
 *  their capabilities.
 *
 *  This module defines the basic constructs used to define client
 *  and server 'contexts' which manage B2B service invocations.
 *  It also includes server-specific calls required exclusively by
 *  C Services.  The client-only API is defined in wmJNIc.h.
 *
 *  The primary structure for all service invocations is WmRecord.
 *  Virtually all API functions take one or more WmRecords
 *  as arguments and return a WmRecord (or a char *).
 *
 *  WmContext provides access to the JNI execution context - it is
 *  copied into WmRecords and therefore only needed when a function
 *  does not otherwise require a WmRecord.
 *
 *  WmRecords implement four types: records, record arrays, string
 *  arrays, and string tables.  (Strings are translated directly to
 *  and from c 'char *').
 *
 *  Make sure to deallocate all structures (WmRecord, char*) returned
 *  from the API using freeWmRec() or freeWmString().
 *
 *  The webMethods server invokes a service with a session record and
 *  an input record.  The input record is the 'root' of all input
 *  arguments.  Use the getWm<type>() functions to extract input
 *  arguments; multiple calls are needed for nested records.
 *  Use the getWm<type>ByIndex() to extract record and string arrays,
 *  and getWm<type>ByIndices() to extract string tables.  To get array
 *  and table sizes, use the appropriate function.
 *
 *  The service returns an output record.  Use setWm<type>() functions
 *  to insert output arguments.  To create nested records, use the
 *  newWm<type>() functions.  For array and table records, insert
 *  values using setWm<type>ByIdx() and setWm<type>ByIndices().
 *
 *  Note that the first argument to the get() functions is the source
 *  record, and for the set() functions is the target record.  For the
 *  ByIdx functions, the first argument is the source or target record
 *  array, string array, or string table.
 *
 *  For Services, note that the execution context is only valid during
 *  the current invocation; all JNI values that are used across
 *  invocations must be turned into global references.  To preserve
 *  application 'session' state, you can insert WmRecords into the
 *  session record, and retrieve these records on subsequent
 *  invocations.
 *
 *  The service may also invoke other services using the invokeWmService()
 *  and invokeWmServiceThreaded() function.  Simply synthesize the
 *  required input record.  For backward compatibility, the session record is
 *  used in invokeWmService().  However, it is no longer needed and therefore
 *  not used in invokeWmServiceThreaded().  Also note that threaded invoke
 *  creates a return context which must be freed with freeWmSvrContext() when
 *  no longer needed.  [The standard server context passed in to your service,
 *  however, is created (and freed) in the code generation service template
 *  and should therefore not be explicitly freed.]
 *
 *  WmRecInit() must be called to initialize this library.  makeWmRec()
 *  is used to wrap the input and output records upon service invocation.
 *
 *  makeWmName() is particularly important if you intend to work with
 *  records other than your service's input and output record.  You will
 *  need to do this to insert state into the session record or to invoke
 *  other services.  The code generator synthesizes field names for all
 *  the records used by your service using this function.  Use it directly
 *  to create the jstring global references needed to name the fields of
 *  your records.
 *
 *  Errors are flagged by returning a null (0 = false) from API calls;
 *  success by 1 (true). You can retrieve the error type and error message
 *  (if any) from the current WmContext (directly, or indirectly from the
 *  current WmRecord).  The types are defined below.  Note that the
 *  jthrowable is available in WmContext should you need to process
 *  the exception information directly. You may also create an error Record
 *  with throwWmServiceErrorMsg() or throwWmServiceError(). 
 *
 */

#ifndef WMJNI_H
#define WMJNI_H

#include <stdlib.h>
#include <string.h>
#include <jni.h>

/* Context Object Types:
	Server (Service thread)
    Sync (Standard Client)
    Async (ClientAsyncThread)
	Tran (Transactional Client)
	Enum (Enumeration)
	Svr_Async (ServerAsyncThread)
*/
#define WM_SVR_CONTEXT			0
#define WM_SYNC_CONTEXT			1
#define WM_ASYNC_CONTEXT		2
#define WM_TRAN_CONTEXT			3
#define WM_ENUM_CONTEXT			4
#define WM_SVR_ASYNC_CONTEXT	5

typedef struct WmContext {
    JNIEnv*		env;        /* JNI environment when created */
	jint		type;		/* determines jobject following */
	jobject		ref;		/* global reference to associated object */
	jthrowable	err;		/* error object */
	jint		errType;	/* error or exception type */
	char*		errMsg;		/* error or exception message */
} WmContext;

/* Record types */
#define WM_RECORD      1
#define WM_RECARRAY    2
#define WM_STRARRAY    3
#define WM_STRTABLE    4

/* deprecated */
#define RECORD      1
#define RECARRAY    2
#define STRARRAY    3
#define STRTABLE    4

typedef struct WmRecord {
	WmContext	*con;	/* invocation context when created */
    JNIEnv		*env;	/* JNI environment from context */
    jobject		ref;    /* local reference to this record's Values object */
    jint		type;   /* {RECORD|RECARRAY|STRARRAY|STRTABLE} */
    jsize		size1;  /* array (1st) dimension */
    jsize		size2;  /* table (2nd) dimension */
} WmRecord;

/* typedefs for pseudo types (& clarity) */
typedef jstring	  WmName;		/* record and field names */
typedef WmName	  WmTid;		/* alias for TContext tid */

typedef WmContext WmCContext;	/* WmSContext or WmTContext */
typedef WmContext WmSContext;	/* Sync context */
typedef WmContext WmAContext;	/* Async context */
typedef WmContext WmTContext;	/* Transactional context */
typedef WmContext WmEContext;   /* Enumeration */
typedef WmContext WmSAContext;  /* Server Async context */

/* Exception/Error types
	Internal error - within this API
	Throwable - non-specific exception within the java code
	Service Exception - application error
	Delivery Exception - failure in guaranteed delivery engine
		(must be administratively corrected, then reset via API)
	Access Exception - user lacks authorization to requested services
	Tx Expired - guaranteed delivery failed due to expiration of TTL
		or exceeding retry limit
	Tx Heuristic Error - see guaranteed delivery docs for details
 */
#define WM_NO_ERROR				0
#define WM_INTERNAL_ERROR		1
#define WM_THROWABLE			2
#define WM_SERVICE_EXCEPTION	3
#define WM_DELIVERY_EXCEPTION   4
#define WM_INVALID_ARG_ERROR	5
#define WM_ACCESS_EXCEPTION		6
#define WM_TX_EXPIRED			7
#define WM_TX_HEURISTIC_ERROR	8


/********************* Setup Exports *********************************/

#ifdef WIN32
#define PREFIX    __declspec( dllexport )
#else
#define PREFIX
#endif

/************************** API  *************************************/

#ifdef __cplusplus
extern "C" {
#endif


/***** Record API *************/

PREFIX WmRecord *	newWmRec(WmContext *con);
PREFIX WmRecord *	newWmRecArray(WmContext *con, jsize size);
PREFIX WmRecord *	newWmStringArray(WmContext *con, jsize size);
PREFIX WmRecord *	newWmStringTable(WmContext *con, jsize size1,
						jint size2);

PREFIX void			freeWmRec(WmRecord **rec);

PREFIX jsize		getWmArraySize(WmRecord *rec);
PREFIX void			getWmTableSize(WmRecord *rec, jsize *size1,
						jsize *size2);

PREFIX WmRecord *	getWmRec(WmRecord *rec, WmName recName);
PREFIX WmRecord *	getWmRecArray(WmRecord *rec, WmName recArrayName);
PREFIX char *		getWmString(WmRecord *rec, WmName stringName);
PREFIX WmRecord *	getWmStringArray(WmRecord *rec,
						WmName strArrayName);
PREFIX WmRecord *	getWmStringTable(WmRecord *rec,
						WmName strTableName);

PREFIX WmRecord *	getWmRecByIdx(WmRecord *recArray, jint idx);
PREFIX WmRecord *	getWmRecArrayByIdx(WmRecord *recArray, jint idx);
PREFIX char *		getWmStringByIdx(WmRecord *strArray, jint idx);
PREFIX char *		getWmStringByIndices(WmRecord *strTable, jint idx1,
						jint idx2);
PREFIX WmRecord *	getWmStringArrayByIdx(WmRecord *strTable, jint idx);

PREFIX jint			setWmRec(WmRecord *targetRec, WmName recName,
						WmRecord *rec);
PREFIX jint			setWmRecArray(WmRecord *targetRec,
						WmName recArrayName, WmRecord *recArray);
PREFIX jint			setWmString(WmRecord *targetRec, WmName stringName,
						const char *value);
PREFIX jint			setWmStringArray(WmRecord *targetRec,
						WmName stringArrayName, WmRecord *strArray);
PREFIX jint			setWmStringTable(WmRecord *targetRec,
						WmName stringTableName, WmRecord *strTable);

PREFIX jint			setWmRecByIdx(WmRecord *targetRecArray, jint idx,
						WmRecord *rec);
PREFIX jint			setWmRecArrayByIdx(WmRecord *targetRecArray,
						jint idx, WmRecord *recArray);
PREFIX jint			setWmStringByIdx(WmRecord *targetStrArray, jint idx,
						const char *value);
PREFIX jint			setWmStringByIndices(WmRecord *targetStrTable,
						jint idx1, jint idx2, const char *value);
PREFIX jint			setWmStringArrayByIdx(WmRecord *targetStrTable,
						jint idx, WmRecord *strArray);

/*** Context API ***/

PREFIX void			freeWmSvrContext(WmContext **con);

/*** Server-only usage ***/

PREFIX jint			invokeWmService(const char *ifc, const char *svc,
						WmRecord *session, WmRecord *input,
						WmRecord *output);
PREFIX WmSAContext*	invokeWmServiceThreaded(const char *ifc,
						const char *svc, WmRecord *input);
PREFIX WmRecord *	getWmServiceThreadData(WmSAContext *con);
PREFIX jint			logWmServiceError(WmContext *con, const char *msg);
PREFIX WmRecord *   throwWmServiceErrorMsg(WmContext *con, const char *msg);
PREFIX WmRecord *	throwWmServiceError(WmContext *con, jthrowable exc);

/******************* String Support ********************************/

PREFIX WmName		makeWmName(WmContext *con, const char *str);
PREFIX void			freeWmName(WmContext *con, WmName name);
PREFIX char *		getWmName(WmContext *con, WmName str);

PREFIX void			freeWmString(char **str);

/******************* Support Routines *******************************/

PREFIX jint			WmRecInit(WmContext *con);

PREFIX WmRecord *	makeWmRec(WmContext *con, jobject oValues,
						jint type, jint size1, jint size2);

PREFIX void			initWmContext(WmContext *con, JNIEnv *env, jint type);
PREFIX void			clearWmContext(WmContext *con);

/******************* Error Routines *********************************/

PREFIX jint			getWmErrType(WmContext *con);
PREFIX char *		getWmErrMsg(WmContext *con);

/******************* Compatibility Routines (Deprecated) ************/

PREFIX jint         WmInit(WmContext *con, jobject values);

#ifdef __cplusplus
}
#endif

#endif /* WMJNI_H */
