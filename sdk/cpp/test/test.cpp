#include <iostream>
#include <string.h>
#include <stdlib.h>
#include "WmGlobal.h"

using namespace std;

JNIEnv* jenv;

// The output is placed in the pipeline

WmObject extractFromPipeline(WmIData pipe, char* key){
	WmIDataCursor idc = pipe->getCursor();
	idc->first(key);
	return idc->getValue();
}

int main(int argc, char** argv)
{
	try {
		// initialize variables
		char *classpath = getenv("CLASSPATH");

		WmContext con = NULL;
		WmIData  inString;
		WmIDataCursor idc;
		WmString str = NULL;
		char *user = "Administrator", *pass = "manage", *tmp = NULL;

		// initialize java virtual machine
		jenv = WmGlobal::initClientJVM(classpath);

		// create new context
		con = new _WmContext(jenv);
		con->connect("localhost:5555", user, pass);
		cerr << "connected....\n";

		// get inputs
		tmp = new char[128];
		cerr << "inString: ";
		cin >> tmp;

		int string_length = strlen(tmp);

		cerr << "output should be: \t'" << string_length << "'" << endl;

		str = new _WmString(jenv, tmp);

		// create IData with input
		inString = WmIDataFactory::create();

		idc = inString->getCursor();
		idc->last();
		idc->insertAfter("inString", str);

		// invoke service
		WmIData out = con->invoke("pub.string", "length", inString);

		WmString outString = (WmString)extractFromPipeline(out, "value");

		cerr << "output is: \t\t'" << outString->toString() << "'" << endl;

		if(atoi(outString->toString()) == string_length){
			cerr << "\n\nOUTPUT IS CORRECT!  LIBS SUCCESSFULLY BUILT!\n\n";
		} else{
			cerr << "\n\n!! INCORRECT OUTPUT!  SERVICE ERROR!\n\n";
		}

		con->disconnect();

		delete str;
		delete []tmp;
		delete out;
		delete inString;
		delete con;

		idc->destroy();
	} catch (WmException &e){
		cerr << "Error in main." << endl << e.getExceptionType()
			<< ": " <<  e.getMessage()
			<< endl << "Exiting . . ." << endl;
	}
	return 0;
}

