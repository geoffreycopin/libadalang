Libadalang
==========

Libadalang is a project to build a high performance semantic engine for the Ada
programming language.

Dependencies
------------

To generate and build the library itself:

- Quex version 0.64.8 - http://sourceforge.net/projects/quex/files/HISTORY/0.64
  Follow the installation guide in the quex `README`
- The mako template system for Python (see `REQUIREMENTS.dev`)
- Clang-format

You will need GNATpython in order to run the testsuite.

To develop comfortably:

- If you want interactive debugging when code is generated, install IPython
- If you want to compute code coverage for the code generator, install
  coverage.py (see `REQUIREMENTS.dev`)
- If you want to check memory issues, the testsuite has an option to track them
  using Valgrind.

Building
--------

First, let's generate code for libadalang itself. In the top-level directory,
run:

    $ python ada/manage.py generate

You can also pass a `-c` flag in order to get a code coverage report in the
"coverage" directory.

Then, let's build it:

    $ python ada/manage.py build

If you satisfied all the above dependencies and if you did set `QUEX_PATH` and
the quex executable as said in quex's `README`, it should build fine.

Also, while developing libadalang you might be happy to use the

    $ python ada/manage.py make

command, that will wrap the two previous commands in one, generating the code
and building it in one step

Install
-------

Once you built libadalang, you can install the library in any place you want:

    $ python ada/manage.py install $INSTALL_DIR

Testing
-------

First, make sure you have the `build/bin` directory in your PATH so the
test cases can access the `parse` program. Then, in the top-level directory,
run:

    $ python testsuite/testsuite.py

If you want to learn more about this test driver's options (for instance to run
tests under Valgrind), add a `-h` flag.

Because adding `build/bin` to the PATH is not very convenient, `ada/manage.py`
provides a shortcut to run the testsuite:

    $ python ada/manage.py test

It runs the testsuite with the `--enable-color` option. It is also possible to
pass other arguments to `testsuite.py`. For instance, if you want to run under a
debugger only the `factor_0` test case, execute:

    $ python ada/manage.py test -- -g ada/testsuite/tests/parser/factor_0

Documentation
-------------

The developer and user's documentation for Libadalang is in `ada/doc`. You can
consult it as a text files or you can build it.  For instance, to generate HTML
documents, run from the top directory:

    $ make -C ada/doc html

And then open the following file in your favorite browser:

    ada/doc/_build/html/index.html
