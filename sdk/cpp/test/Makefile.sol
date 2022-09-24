# To build this test example with Java 1.1 VM, you will have
# to make following changes:
# (1) Change JDKDIR on line 23 to reflect the location of your 
#     JDK 1.1 VM
# (2) Change THRDIR on line 24 to reflect the location of the
#     required JDK shared libraries. 
#     For JDK 1.1, the name of the JDK library is libjava.so 
#     and resides in
#         $(JDKDIR)/lib/sparc/native_thread. 
#     For JDK 1.2, the name was changed to libjvm.so and resides
#     in
#         $(JDKDIR)/jre/lib/sparc
#     So make appropriate changes to THRDIR
# (3) Change JAVALIB on line 25 to
#         JAVALIB = java

APP_ROOT = ..
INC_ROOT = $(APP_ROOT)/include
LIB_ROOT = $(APP_ROOT)/lib

COPT = -g -fpic
JOPT = 
JDKDIR = /usr/java
THRDIR = $(JDKDIR)/jre/lib/sparc
WMDIR = /opt/softwareag/webMethods8
JAVALIB = jvm
CC = g++

CPPFLAGS = $(COPT) $(JOPT) -I$(JDKDIR)/include \
	-I$(JDKDIR)/include/solaris \
	-I$(INC_ROOT)

all: test

runtest:
	LD_LIBRARY_PATH=$(LD_LIBRARY_PATH):$(THRDIR):$(LIB_ROOT):/usr/local/lib \
	CLASSPATH=$(CLASSPATH).:$(JDKDIR)/jre/lib/rt.jar:$(JDKDIR)/lib/tools.jar:$(WMDIR)/common/lib/wm-isclient.jar:$(WMDIR)/common/lib/glassfish/gf.javax.mail.jar:$(WMDIR)/IntegrationServer/lib/wm-isserver.jar \
	./examples

test: test.o
	$(CC) -o examples test.o \
	-L$(THRDIR) \
	-L$(LIB_ROOT) \
	-lwmjni \
	-l$(JAVALIB) \
	-lpthread

clean:
	rm -f *.o core examples

.SUFFIXES: .cpp .o

test.o: test.cpp
	$(CC) $(CPPFLAGS) -c test.cpp -o test.o

