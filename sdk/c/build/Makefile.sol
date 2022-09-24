# To build the shared libaries with Java 1.1 VM, you will have
# to make following changes:
# (1) Change JDKDIR on line 17 to reflect the location of your 
#     JDK 1.1 VM
# (2) Change INCLUDES on line 18 to reflect the location of the
#     required JDK header files
# (3) Change THRDIR on line 19 to reflect the location of the
#     required shared libaries. For JDK 1.1, the name of the
#     library is libjava.so. For JDK 1.2, the name was changed to
#     libjvm.so. So you need to link with libjava.so under JDK 1.1.
# (4) Comment out statement
#         #define JAVA2
#     in wmJNIc.c on line 92
#

COPT = -g 
JDKDIR = /usr/local/java/1.2.2
INCLUDES = -I$(JDKDIR)/include -I$(JDKDIR)/include/solaris
THRDIR = $(JDKDIR)/jre/lib/sparc
SRCDIR = ../src/
CC = gcc

all: clean sol_wmJNIlib sol_wmJNIclib

libwmJNI.obj: $(SRCDIR)wmJNI.c $(SRCDIR)wmJNI.h 
	$(CC) $(COPT) -fpic $(INCLUDES) \
		-c $(SRCDIR)wmJNI.c -o libwmJNI.obj

sol_wmJNIlib: libwmJNI.obj
	ar r libwmJNI.a libwmJNI.obj;
	$(CC) -shared libwmJNI.obj -o libwmJNI.so

libwmJNIc.obj: $(SRCDIR)wmJNIc.c $(SRCDIR)wmJNIc.h $(SRCDIR)wmJNI.h $(SRCDIR)wmUtil.h
	$(CC) $(COPT) -fpic $(INCLUDES) \
		-c $(SRCDIR)wmJNIc.c -o libwmJNIc.obj
		
sol_wmJNIclib:	libwmJNIc.obj
	ar r libwmJNIc.a libwmJNIc.obj;
	$(CC) -shared libwmJNIc.obj -o libwmJNIc.so

clean:
	rm -f lib* core 
