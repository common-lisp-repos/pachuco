# Introduction

Pachuco is a self-hosting compiler for a dialect of the Lisp
programming language (and it also has a lot in common with Scheme).
It generates i386 or x86-64 assembly code directly, rather than
compiling to another high-level language or virtual machine.  The
system is about 5000 lines of code, including the compiler, runtime,
garbage collector, and interpreter (used in the macro system).  The
whole system is written in the Pachuco language, except for a minimal
amount of C and Common Lisp code to allow the system to be
bootstrapped.

The Pachuco language is very modest in comparison to Common Lisp and
Scheme, lacking facilities and conveniences not required for the
compiler.  Nonetheless, the concise implementation of the compiler
demonstrates the expressive power of such a simple dialect of Lisp.

The language is briefly described in the LANGUAGE file.  Like Scheme,
the language features a small core, lexically-scoped variables, and
supports proper tail recursion.  But the macro system and the library
functions in the runtime are based on Common Lisp.

Like a C compiler, the Pachuco compiler produces stand-alone
executables.  Unlike traditional Lisps, it is not integrated into a
read-eval-print loop, although the system does include a simple
interpreter-based REPL.

The current implementation of Pachuco has a number of limitations, and
it is very spartan in comparison to production compilers (e.g. its
error reporting is almost non-existent).  It is probably not yet
suitable for other applications.


# Getting Started

Pachuco currently targets the i386 and x86-64 instruction set
architectures, and builds and runs under Linux.  It requires basic
development tools to be installed, such as gcc, binutils, and make.
It also uses the sbcl implementation of Common Lisp to bootstrap
itself.  This is available as the sbcl package on Debian, Ubuntu and
Fedora, or see [sbcl.org](http://sbcl.org).

Running `make all` bootstraps the compiler and runs some tests.  The
resulting compiler executable is in `build/stage2`, but it is normally
invoked via the shell script `scripts/compile`.  Among other things,
this script includes the standard runtime files into the compilation,
and invokes gcc to assemble the compiler output into a working
executable.

There is a simple example program to generate the Fibonacci sequence
in `examples/fib.pco`.  Compile it with:

    $ scripts/compile examples/fib.pco -o build/fib

(The `-o` option specifies the name of the destination executable.)

The result is a stand-alone executable that you can run from the
command line:

    $ build/fib 10
    89

To start the interpreter-based REPL, do `make repl`:

    $ make repl
    build/repl runtime/runtime.pco runtime/runtime2.pco runtime/gc.pco
    Reading runtime/runtime.pco
    Reading runtime/runtime2.pco
    Reading runtime/gc.pco
    >>>

You can type Pachuco expressions and programs at the `>>>` prompt:

    >>> (define (fact n)
          (if (= n 0)
              1
              (* n (fact (- n 1)))))
    #<function>
    >>> (fact 10)
    3628800

Type control-D to quit the REPL.