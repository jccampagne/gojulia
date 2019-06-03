# Julia config tool should be located somewhere here:
# export PATH=/Applications/Julia-1.1.app/Contents/Resources/julia/share/julia/:$PATH

CFLAGS=`julia-config.jl --cflags            | sed s/\'//g`
LDFLAGS=`julia-config.jl --ldflags --ldlibs | sed s/\'//g`


#
# We need to remove single quotes from the ouput of julia-config to get something like:
#     CFLAGS=-std=gnu99 -I/Applications/Julia-1.1.app/Contents/Resources/julia/include/julia -DJULIA_ENABLE_THREADING=1 -fPIC
#     LDFLAGS=-L/Applications/Julia-1.1.app/Contents/Resources/julia/lib -Wl,-rpath,/Applications/Julia-1.1.app/Contents/Resources/julia/lib -Wl,-rpath,/Applications/Julia-1.1.app/Contents/Resources/julia/lib/julia -ljulia
#
# otherwise they would be:
#     CLFAGS=-std=gnu99 -I'/Applications/Julia-1.1.app/Contents/Resources/julia/include/julia' -DJULIA_ENABLE_THREADING=1 -fPIC
#     LDFLAGS=-L'/Applications/Julia-1.1.app/Contents/Resources/julia/lib' -Wl,-rpath,'/Applications/Julia-1.1.app/Contents/Resources/julia/lib' -Wl,-rpath,'/Applications/Julia-1.1.app/Contents/Resources/julia/lib/julia' -ljulia
#
# Note the single quotes (') around paths. It will result in an error like:
#     ld: warning: directory not found for option '-L'/Applications/Julia-1.1.app/Contents/Resources/julia/lib''
#


# set CGo flags
CGO_CFLAGS=${CFLAGS}
CGO_LDFLAGS=${LDFLAGS}

all:
	gcc -c -fPIC ${CFLAGS} gjl.c
	CGO_CFLAGS="${CGO_CFLAGS}" CGO_LDFLAGS="${CGO_LDFLAGS}" go build gjl.go
	CGO_CFLAGS="${CGO_CFLAGS}" CGO_LDFLAGS="${CGO_LDFLAGS}" go build gjl_goroutines.go
	CGO_CFLAGS="${CGO_CFLAGS}" CGO_LDFLAGS="${CGO_LDFLAGS}" go build gjl_goroutines_fail.go
	@printf "\n\nrunning example 1\n"
	./gjl
	@printf "\n\nrunning example 2\n"
	./gjl_goroutines
	@printf "\n\nrunning example 3 - this will fail\n"
	./gjl_goroutines_fail


.PHONY: clean
clean:
	rm -f *.o gjl gjl_goroutines gjl_goroutines_fail
