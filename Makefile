CFLAGS = -Wall -DXP_UNIX=1 -DMOZ_X11=1 -fPIC -g

slimerjs-fakeplugin.so: slimerjs-fakeplugin.o
	cc $(CFLAGS) -shared $< -o $@

slimerjs-fakeplugin.o: slimerjs-fakeplugin.c
	cc $(CFLAGS) -c slimerjs-fakeplugin.c

clean:
	rm -f slimerjs-fakeplugin.so
	rm -f slimerjs-fakeplugin.o
