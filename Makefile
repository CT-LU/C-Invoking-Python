INC = -I/usr/include/python2.7 -I/usr/include/x86_64-linux-gnu/python2.7 `pkg-config --cflags opencv`
LIBS = -L/usr/lib/python2.7/config-x86_64-linux-gnu -L/usr/lib -lpthread -ldl -lutil -lm -lpython2.7 `pkg-config --libs opencv`
CFLAGS = -fno-strict-aliasing -D_FORTIFY_SOURCE=2 -g -fstack-protector --param=ssp-buffer-size=4 -Wformat \
	 -Werror=format-security  -DNDEBUG -g -fwrapv -O2 -Wall -Wstrict-prototypes \
	 -Xlinker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions -fpermissive

all: c_invoke_py

c_invoke_py: main.cpp CPythonUtil.o
	g++ $? $(INC) $(LIBS) $(CFLAGS) -o $@ 

CPythonUtil.o: CPythonUtil.cpp
	g++ $< $(INC) $(LIBS) $(CFLAGS) -c
	
clean:
	rm -f  *.o c_invoke_py 

#use following instructions to get the argumets above
#python-config --cflags
#python-config --ldflags 
