# slimerjs-fakeplugin
This plugin fakes support for PDF, Flash, Java and similiar content so SlimerJS attempts to download them. It is useful when you want to intercept above content in the `onResourceReceived` callback, but without running the real plugins.

The plugin will not execute or parse any content received, so it should be safe to use in a security sensitive environment.

## Building
To build this plugin no special dependencies are required, except a minimal C build chain (make, cc):

```
make
```
