#include <julia.h>
#include <stdio.h>
#include <stdbool.h>

jl_value_t *gjl_typeof(jl_value_t *v) {
  return jl_typeof(v);
}

int gjl_typeis(jl_value_t *v, jl_value_t *t) {
  return jl_typeis(v, t);
}

jl_datatype_t * gjl_float64_type() {
  return jl_float64_type;
}

bool gjl_is_jl_float64_type(jl_value_t *v) {
  if (!v) {
    return false;
  }
  int result = jl_typeis(v, jl_float64_type);
  if (!result) {
    return false;
  } else {
    return true;
  }
}

jl_value_t* gjl_eval_string(char * julia_code) {
  jl_value_t* ret = jl_eval_string(julia_code);
  return ret;
}

void gjl_gc_push1(jl_value_t *v) {
  JL_GC_PUSH1(&v);
}
