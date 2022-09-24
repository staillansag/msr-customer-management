#ifndef WmException_h
#define WmException_h

#include "WmPrefix.h"

class IMPORT_EXPORT_DLL WmException
{
	public:
		PREFIX WmException();
		PREFIX WmException(const char *msg );
		PREFIX WmException(const WmException& rhs);
		PREFIX WmException& operator=(const WmException& rhs);
		PREFIX ~WmException();

		PREFIX void setMessage(const char *msg );

		PREFIX char *getMessage();
		PREFIX char *getExceptionType();

		PREFIX WmException(int a, char* type_);
		// arbitrary int paramenter to differentiate from
		// WmException(char* msg);

		PREFIX WmException(char* msg, char *type_);
		PREFIX WmException(char* msg, char* java_class, int a);

	private:
		char* ExtractErrorType(char* java_class);
		char* message_;
		char* message_backup_;
		char* exception_type_;
		static const char* empty_msg;
		static int empty_msg_len;
};

#endif
