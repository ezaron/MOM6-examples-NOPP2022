
alias emacs='emacs -nw'

export FC=ifort
export MPIFC=mpif90
export CC=icc

ulimit -s unlimited
export PATH=/glade/u/home/ezaron/opt/bin:${PATH}

module load ncarenv
module load intel
module load ncarcompilers
module load netcdf
module load mpt
module load ncview
module load julia
#module unload python
#module load conda
#conda activate npl
