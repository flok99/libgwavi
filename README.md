# README

# DISCLAIMER

Even though you can already generate AVI files, this library has not reached a
final version yet and is still a work in progress. You've been warned... ;)

# SYNOPSIS

libgwavi is a fork of libkohn-avi. It is a tiny C library aimed at creating AVI
files.

Original credits go to Michael Kohn, who released his library under the LGPL
license. He, however, allowed me to release my forked version under the less
restrictive 3-clause BSD license so... thanks to him!

Anyway, why the fork you might ask? I used it in an application that needed the
library to be reliable. So here is what has already changed from libkohn-avi:

  * added function documentation through doxygen (use `make doc` to generate it)

  * removed not useful code

  * improved error checking

# BUILD

This library has no dependencies, you only need the standard C library.
To generate `libgwavi.so`, just type the following from the root's directory:

    make

To generate the documentation of the library functions, type the following:

    make doc

The code includes a demo application that uses `libgwavi`. You can build it
using this command:

    make examples

# HOW TO USE IT

For a complete example, have a look at the demo application in the demo folder.

If your in a hurry, here is a small explanation on how to use it.

First, you need to include the header file.

    #include "gwavi.h"

There is basically four main function that you will need to use:

  * `gwavi_open()`

  * `gwavi_add_frame()`

  * `gwavi_add_audio()`

  * `gwavi_close()`

Please, note that error checking has been voluntarily omitted for the sake of
the clarification.

So first, you should declare a `gwavi_t` structure and initialize it:

    struct gwavi_t *gwavi;
    struct gwavi_audio_t audio;

    gwavi = gwavi_open(output_file,
                       frame_width,
                       frame_height,
                       fourcc,
                       frame_rate,
                       &audio);

Note that the audio channel is optional and that you can pass `NULL` as the last
argument of `gwavi_open()` if you don't need it.

Then you add your video frames:

    gwavi_add_frame(gwavi, buffer, buffer_length);

You can also add audio with `gwavi_add_audio()`.

And at the end, you can close the output file and free the allocated memory by
calling the `gwavi_close()` function.

    gwavi_close(gwavi);


<!-- vim: set filetype=markdown textwidth=80 -->
