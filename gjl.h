jl_value_t* gjl_eval_string(char * julia_code);

int gjl_typeis(jl_value_t *v, jl_datatype_t *t);

jl_datatype_t * gjl_float64_type();

int gjl_is_jl_float64_type(jl_value_t*v);

void gjl_gc_push1(jl_value_t *v);
