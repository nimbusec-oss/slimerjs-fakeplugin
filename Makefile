flash_vars = \
	-DPLUGIN_NAME='"Shockwave Flash"'\
	-DPLUGIN_DESCRIPTION='"Shockwave Flash 19.0 r0"'\
	-DPLUGIN_VERSION='"19.0.0.185"'\
	-DMIME_TYPES='"application/x-shockwave-flash:swf:Flash"'

pdf_vars = \
	-DPLUGIN_NAME='"Adobe Acrobat"'\
	-DPLUGIN_DESCRIPTION='"Adobe PDF Plug-In 11.0.7"'\
	-DPLUGIN_VERSION='"11.0.7"'\
	-DMIME_TYPES='"application/pdf:pdf:Adobe Portable Document Format"'

#java_vars = \
#	-DPLUGIN_NAME='"Java(TM) Platform SE 8 U66"'\
#	-DPLUGIN_DESCRIPTION='"Next Generation Java Plug-in 11.66.2 for Mozilla browsers"'\
#	-DPLUGIN_VERSION='"11.66.2.18"'\
#	-DMIME_TYPES='"application/x-java-applet:class,jar:Java"'

CFLAGS = -Wall -DXP_UNIX=1 -DMOZ_X11=1 -fPIC -g
OBJS = libflash.so libpdf.so

.PHONY: all
all: $(OBJS) ## Compile mozilla fake plugins (default target)

.PHONY: install
install: $(OBJS) ## Install mozilla fake plugins for the current user
	cp $^ ~/.mozilla/plugins/

clean: ## Remove build artifacts
	rm -f libflash.so libpdf.so
	rm -f libflash.o libpdf.o

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

libflash.o: vars=$(flash_vars)
libpdf.o: vars=$(pdf_vars)

%.so: %.o
	cc $(CFLAGS) -shared $< -o $@

%.o: plugin.c
	cc $(CFLAGS) $(vars) -c $< -o $@
