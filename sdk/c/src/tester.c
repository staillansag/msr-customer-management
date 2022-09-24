/*
 * Example simple tester client using pub.string:length
 *
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "wmJNIc.h"

static WmName Output=0; /* Output from the service */
static WmName Input=0;  /* Input to the service */

void print_LengthOutput(WmRecord *rec, int pad);
void print_LengthInput(WmRecord *rec, int pad);

int initKeys(WmCContext *cc)
{

	if ((Output = makeWmName(cc, "value")) == 0) return 0;

	if ((Input = makeWmName(cc, "inString")) == 0) return 0;
    return 1;
}



void freeKeys(WmCContext *cc)
{

	freeWmName(cc, Output);

	freeWmName(cc, Input);
}

void indentOutput(int pad)  /* A little output utility */
{
	int i;
	for (i=0; i<pad; i++)
		fprintf(stderr,"\t");
}


void print_LengthOutput(WmRecord *rec, int pad)
{
	int i,j;
	jsize x,y;
	char *tmpStr;
	WmRecord *tmpRec,*tmpRec1;

	indentOutput(pad);

    tmpStr = getWmString(rec, Output);
	indentOutput(pad);
    fprintf(stderr,"Output should be 10, the length of 'webMethods'\n");
    fprintf(stderr,"Output = %s\n", tmpStr);
    if(!strcmp(tmpStr, "10")) fprintf(stderr, "\nWe got the correct output!\n");
	freeWmString(&tmpStr);
}

void print_LengthInput(WmRecord *rec, int pad)
{
	int i,j;
	jsize x,y;
	char *tmpStr;
	WmRecord *tmpRec,*tmpRec1;

	indentOutput(pad);
    fprintf(stderr,"Record 'LengthInput' =>\n");

    tmpStr = getWmString(rec, Input);
	indentOutput(pad);
    fprintf(stderr,"  String 'inString' = %s\n", tmpStr);
	freeWmString(&tmpStr);
}

/**** Service Invocation Function ****/
int invokeSvc(WmCContext *cc)
{
	int result = 0;
	WmRecord *in, *out;
	char	 buf[80];

	/* [Declare inputs] */



	/* [setup keys for input and output records] */
	if (!initKeys(cc)) return -1;

	if ((in = newWmRec(cc)) == 0) goto error;


    /* [set inputs] */


    fprintf(stderr, "\n%s = 'webMethods' ", "inString");
	if (!setWmString(in, Input, "webMethods")) goto error;

    /* [Invoke Service] */
    out = invokeWmSync(cc, "pub.string", "length", in); // should be 'in'
	if (out == 0) goto error;
	fprintf(stderr,"\n\n ********* Successful invoke **********\n");


    /* [access outputs and print] */
	fprintf(stderr,"\n ************* OUTPUTS ****************\n\n");
	print_LengthOutput(out,0);
	goto cleanup;

error:
	result = -1;

cleanup:


	freeWmRec(&in);
	freeWmRec(&out);
	freeKeys(cc);

    return 0;
}

int main(int argc, char **argv)
{
    WmCContext	*cc = NULL;
    int result = 0;
    char        *host, *port, *server, *user, *password;
    host = (char*)malloc(24);
    port = (char*)malloc(5);
    server = (char*)malloc(30);
    user   = (char*)malloc(20);
    password = (char*)malloc(40);

    if(argc == 1){
      strcpy(host, "localhost");
      strcpy(port, "5555");
      strcpy(user, "Administrator");
      strcpy(password, "manage");
    }

    if(argc > 1){
      strcpy(host, argv[1]);
    }

    if(argc > 2){
      strcpy(port, argv[2]);
    }

    if(argc > 4){
      strcpy(user, argv[3]);
      strcpy(password, argv[4]);
    }

    strcpy(server, host);
    strcat(server, ":");
    strcat(server, port);


    fprintf(stderr, "\n\n\n---- BEGIN TEST ----\n");

    if (!initWmClient())
	return -1;

    cc = newWmClientContext();
    if (cc == 0)
	return -1;

    /* --- Connect to server --- */
    if (!connectCcUserPass(cc, server, user, password)){
	fprintf(stderr, "Error %i\n", cc->err);
	return -1;
    }

    fprintf(stderr, "Successful connection made with server\n");

    /* Uncomment and set values if you need to go through a Proxy Server */
    /* if (!setCcProxy(cc,<proxy host>,<proxy port>,<user>,<password>))
		return -1;

     */

    /* --- Invoke Service --- */
    result = invokeSvc(cc);

    /* --- Cleanup --- */
    disconnectCc(cc);
    freeWmContext(&cc);
    shutdownWmClient();
    fprintf(stderr, "\nSuccess!  Congratulations!\n");
    fprintf(stderr, "\n---- END TEST ----\n");
    return result;
}

