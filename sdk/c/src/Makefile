
JDKDIR    = /usr/local/java/jdk1.2.2
LIBDIR    = /usr/local/webmethods/Developer/lib
CC        = gcc
ARCH	  = i386
THREADTYPE= native_threads
THRDIR    = $(JDKDIR)/jre/lib/$(ARCH)
INCLUDES  = -I$(LIBDIR) -I$(JDKDIR)/include -I$(JDKDIR)/include/linux
CLASSES   = $(JDKDIR)/jre/lib/rt.jar:.:$(LIBDIR)/client.jar
LIBS      = .:$(LIBDIR):$(THRDIR):$(THRDIR)/classic:$(THRDIR)/$(THREADTYPE):$(PATH)

CFLAGS    = $(INCLUDES) -g -static
OBJS      = ../build/libwmJNI.a ../build/libwmJNIc.a
JAVALIB   = jvm

all: tester

tester.obj:  tester.c
	$(CC) $(CFLAGS) -fPIC -c tester.c -o tester.obj

# Set the following for JDK 1.1 on Linux
#tester: tester.obj
#	$(CC) tester.obj ../build/libwmJNI.so ../build/libwmJNIc.so \
#	-L$(THRDIR) -l$(JAVALIB) -lnet \
#	-L$(THRDIR) -L../build -pthread -lc -o tester

tester: tester.obj
	$(CC) tester.obj ../build/libwmJNI.so ../build/libwmJNIc.so \
	-L$(THRDIR)/classic -l$(JAVALIB) \
	-L$(THRDIR)/$(THREADTYPE) -L../build -lhpi -o tester


# Set approriate LD_LIBRARY_PATH to reflect the shared libaries PATH
runtest: tester
	export LD_LIBRARY_PATH=$(LD_LIBRARY_PATH):$(LIBS)
	export CLASSPATH=$(CLASSPATH):$(CLASSES)
	./tester
clean:
	rm -f tester tester.o *.obj

