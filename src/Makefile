# Fortran Compiler
F90 = ifort 
# Library (must be compiled with the same Fortran compiler)
LIBS = -I./lib -L./lib -lioapi -lnetcdf

# compiler flags for debugging code
FFLAGS = -check all -C -g -warn all,nodec,interfaces -gen_interfaces -traceback -O0 -132 -gopenmp 

# compiler flags for production code with openMP
#FFLAGS = -g -ipo -O3 -static -mp1 -xT -132 -openmp
# compiler flags for production code without openMP
#FFLAGS = -g -traceback -132 -fpe0 -check all

exec = ncf2gnuplot.exe 
default = $(exec)
all: ncf2gnuplot.exe

objects = ncf2gnuplot.o
	
ncf2gnuplot.exe: $(objects)
	 $(F90) $(FFLAGS) -o ncf2gnuplot.exe $(objects) $(LIBS) 

.f.o :
	$(F90) $(FFLAGS) -c $< $(LIBS) 
clean:
	rm -fr *.o *.oo *.mod *~

