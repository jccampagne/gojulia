package main

// #cgo CFLAGS: -I. 
// #cgo LDFLAGS: -L. gjl.o
// #include <julia.h>
// #include <gjl.h>
import "C"
import "log"

func do_stuff() {
	C.jl_init()
	julia_code := C.CString("sqrt(2.0)")
	var ret *C.struct__jl_value_t
	ret = C.gjl_eval_string(julia_code)
	C.gjl_gc_push1(ret);
	if C.gjl_is_jl_float64_type(ret) == 1 {
		var d C.double
		d = C.jl_unbox_float64(ret)
		log.Printf("%o", d)
	}
	C.jl_atexit_hook(0)
}

func main() {
	do_stuff()
}
