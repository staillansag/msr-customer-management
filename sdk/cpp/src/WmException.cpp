
#include <string.h>
#include <iostream>
#include "WmException.h"
#include <ctype.h>

const char* WmException::empty_msg="Unknown exception";
int WmException::empty_msg_len = strlen(empty_msg)+1;

WmException::~WmException()
{
	if(message_ != NULL)
		delete [] message_;
	if(message_backup_ != NULL)
		delete [] message_backup_;
	if(exception_type_ != NULL)
		delete [] exception_type_;
}

WmException::WmException(const WmException &rhs)
{
	message_backup_ = NULL;
	message_ = NULL;

	if(rhs.message_ != NULL) {
		message_ = new char[strlen(rhs.message_)+1];
		strcpy(message_,rhs.message_);
	}

	if(rhs.message_backup_ != NULL) {
		message_backup_ = new char[strlen(rhs.message_backup_)+1];
		strcpy(message_backup_,rhs.message_backup_);
	}

	if(rhs.exception_type_ != NULL) {
		exception_type_ = new char[strlen(rhs.exception_type_)+1];
		strcpy(exception_type_,rhs.exception_type_);
	}
}

WmException::WmException()
{
	message_backup_ = NULL;
	exception_type_ = new char[empty_msg_len];
	strcpy(exception_type_, empty_msg);
	message_ = NULL;
}

WmException::WmException(const char *msg )
{
	message_ = NULL;
	message_backup_ = NULL;
	exception_type_ = new char[empty_msg_len];
	strcpy(exception_type_, empty_msg);
	setMessage(msg);
}

WmException :: WmException(int nothing, char* type_)
{
	message_ = NULL;
	message_backup_ = NULL;
	exception_type_ = new char[strlen(type_)+1];
	strcpy(exception_type_, type_);
}

WmException :: WmException(char* msg1, char* type_)
{
	message_ = NULL;
	message_backup_ = NULL;
	exception_type_ = new char[strlen(type_)+1];
	strcpy(exception_type_, type_);
	setMessage(msg1);
}

WmException :: WmException(char* msg1, char* java_class, int a){
	message_ = NULL;
	setMessage(msg1);

	exception_type_ = new char[strlen(java_class)+1];
	strcpy(exception_type_,java_class);
}

WmException& WmException ::operator=(const WmException& rhs)
{
	if (this != &rhs) {
		// Clean this object
		if(message_ != NULL) {
			delete [] message_;
			message_ = NULL; 
		}
		if(message_backup_ != NULL) {
			delete [] message_backup_;
			message_backup_ = NULL;
		}
		if(exception_type_ != NULL) {
			delete [] exception_type_;
			exception_type_ = NULL; 
		}

		// make a copy of messages.
		if(rhs.message_ != NULL) {
			message_ = new char[strlen(rhs.message_)+1];
			strcpy(message_,rhs.message_);
		}
		if(rhs.message_backup_ != NULL) {
				message_backup_ = new char[strlen(rhs.message_backup_)+1];
				strcpy(message_backup_,rhs.message_backup_);
		}
		if(rhs.exception_type_ != NULL) {
			exception_type_ = new char[strlen(rhs.exception_type_)+1];
			strcpy(exception_type_,rhs.exception_type_);
		}
	}

	return *this;
}

char *WmException::getExceptionType()
{
	return exception_type_;
}

char *WmException::getMessage()
{
	return message_;
}

void WmException::setMessage(const char *msg )
{
	if(msg == NULL) return;

	if(message_ != NULL) {
		delete []message_;
	}

	int len = strlen(msg) + 1;

	message_ = new char[len];
	strcpy( message_, msg );
	message_backup_ = new char[len];
	strcpy( message_backup_, msg);
}

