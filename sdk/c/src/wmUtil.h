/*
 *  wmUtil.h:  Shared internal support routines defined in wmJNI.c and used in
 *				wmJNIc.c.
 *
 * Copyright (C) 1996-1999, webMethods, Inc. All Rights Reserved.
 */

#ifndef WMUTIL_H
#define WMUTIL_H

#ifdef __cplusplus
extern "C" {
#endif

PREFIX void			setError(WmContext *con, char *msg);
PREFIX void			setKeyError(WmContext *con, char *msg, jstring sKey);
PREFIX char *		getStringCopy(WmContext *con, jstring sStr);
PREFIX jint			clearException(WmContext *con);
PREFIX WmRecord *	makeRec(WmContext *con, jobject oRef, jint type, jsize size1,
						jsize size2);
PREFIX jint			contextMismatch(WmContext *con, jint type);
PREFIX WmContext *	makeContext(JNIEnv *env, jint type, jobject ref);

#ifdef __cplusplus
}
#endif

#endif /* WMUTIL_H */


