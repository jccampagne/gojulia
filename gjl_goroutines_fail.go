package main

// #cgo CFLAGS: -I. 
// #cgo LDFLAGS: -L. gjl.o
// #include <julia.h>
// #include <gjl.h>
import "C"
import "log"

func do_stuff() {
	log.Printf("do_stuff")
	C.jl_init()
	julia_code := C.CString("sqrt(2.0)")
	var ret *C.struct__jl_value_t
	ret = C.gjl_eval_string(julia_code)
	C.gjl_gc_push1(ret);
	if C.gjl_is_jl_float64_type(ret) == 1 {
		var d C.double
		d = C.jl_unbox_float64(ret)
		log.Printf("do_stuff d = ", d)
	}
	log.Printf("do_stuff done")
}

func do_something_else() {
	log.Printf("do_something_else")
	var f *C.jl_function_t = C.jl_get_function(C.jl_base_module, C.CString("log"))
	var argument *C.jl_value_t = C.jl_box_float64(2.0)
	var ret2 *C.jl_value_t = C.jl_call1(f, argument)
	d := C.jl_unbox_float64(ret2)
	log.Println("do_something_else d = ", d)
	log.Printf("do_something_else done")
}

func main() {
	log.Printf("This example will fail")
	go do_stuff()
	go do_something_else()
	C.jl_atexit_hook(0)
}
