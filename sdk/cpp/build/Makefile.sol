# To build the shared libraries with Java 1.1 VM, you will have
# to make following changes:
# (1) Change JDKDIR on line 30 to reflect the location of your 
#     JDK 1.1 VM
# (2) Change THRDIR on line 31 to reflect the location of the
#     required JDK shared libraries. 
#     For JDK 1.1, the name of the JDK library is libjava.so 
#     and resides in
#         $(JDKDIR)/lib/sparc/native_thread. 
#     For JDK 1.2, the name was changed to libjvm.so and resides
#     in
#         $(JDKDIR)/jre/lib/sparc
#     So make appropriate changes to THRDIR
# (3) Change JAVALIB on line 32 to
#         JAVALIB = java
#
# Also remember to comment line 7 in the source of WmGlobal.cpp
# to not define JAVA2 before compiling

APP_ROOT = ..
SRC_ROOT = $(APP_ROOT)/src
INC_ROOT = $(APP_ROOT)/include

VPATH = $(SRC_ROOT):$(INC_ROOT)

COPT = -g -fpic
JOPT =
LOPT = 

JDKDIR = /usr/java
THRDIR = $(JDKDIR)/jre/lib/sparc
JAVALIB = jvm

INCLUDES = -I$(JDKDIR)/include -I$(JDKDIR)/include/solaris -I$(INC_ROOT)
CC = g++
LD = ld

CPPFLAGS = $(COPT) $(JOPT) $(INCLUDES)

APP_SRC = WmContext.cpp\
	WmBaseContext.cpp\
	WmUser.cpp\
	WmDate.cpp\
	WmGroup.cpp\
	WmTContext.cpp\
	WmIDataCodable.cpp\
	WmUtil.cpp\
	WmIData.cpp\
	WmIDataArray.cpp\
	WmIDataCursor.cpp\
	WmIDataFactory.cpp\
	WmIDataIndexCursor.cpp\
	WmIDataTreeCursor.cpp\
	WmIDataUtil.cpp\
	WmIDataHashCursor.cpp\
	WmException.cpp\
	WmGlobal.cpp\
	WmObject.cpp\
	WmObjectArray.cpp\
	WmObjectArrayT.cpp\
	WmString.cpp\
	WmStringArray.cpp\
	WmStringTable.cpp\
	WmValues.cpp\
	WmValuesArray.cpp\
	WmTable.cpp\
	WmBinCoder.cpp\
	WmInvokeThread.cpp\
	WmVector.cpp	

APP_OBJS = $(APP_SRC:.cpp=.o)

all: wmJNI_lib

wmJNI_lib: $(APP_OBJS)
	ar r libwmjni.a $(APP_OBJS)
	$(CC) -shared -o libwmjni.so $(APP_OBJS) \
	-L$(THRDIR) -l$(JAVALIB)
	cp libwmjni.a libwmjni.so ../lib

clean:
	rm -f $(APP_OBJS) core *.a *.so

.SUFFIXES: .cpp .o

%.o: %.cpp
	$(CC) $(CPPFLAGS) -c -o $@ $<

