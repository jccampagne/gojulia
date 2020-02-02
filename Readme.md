# About

Simple examples showing how to embed Julia in Go.

# Requirements

Julia, Go, Make.

`go`, `julia` and `julia-config.jl`  in your path.


You will probably have to add `julia-config.jl` to your PATH. Julia config tool on macOS, using Julia installed with [brew](https://brew.sh) is located here:

```
/Applications/Julia-1.2.app/Contents/Resources/julia/share/julia/julia-config.jl
```


# Run the examples

This was tested on macOS, but should also work on Linux.

A makefile is provide for convenience, just type:

```
make
```

This will compile the examples and run them (note: one of the example will fail on purpose).


# Description

There are 3 examples:

1. `gjl.go`: very simple example
1. `gjl_goroutines.go`: executing julia code from 2 different goroutines with synchronisation.
1. `gjl_goroutines_fail.go`: same as above example, but demonstrate failure when accessing julia from multiple goroutine without synchronization.


# C binding

Julia is embedding in Go using cgo and a couple of C binding files: `gjl.h` and `gjl.c`.
These files provide function wrappers around [Julia C API](https://docs.julialang.org/en/v1/manual/embedding/index.html) that are defined C macros in Julia. Cgo cannot use C macros directly. For example [jl_typeof(v)](https://github.com/JuliaLang/julia/blob/d249e71ef2fd59acd557f2f6c9688253f4b5a47d/src/julia.h#L107) is a macro.

# References


* [cgo](https://golang.org/cmd/cgo/)
* [Embedding Julia](https://docs.julialang.org/en/v1/manual/embedding/index.html)
* [julia.h](https://github.com/JuliaLang/julia/blob/master/src/julia.h)

