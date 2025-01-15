
alias emacs='emacs -nw'

export FC=ifort
export MPIFC=mpif90
export CC=icc

ulimit -s unlimited

if [[ $HOST == *"casper"* ]]; then
echo "Loading modules for casper"
module load ncarenv
module load ncview
module load nco
module load julia
#module unload python
#module load conda
#conda activate npl
fi

if [[ $HOST == *"derecho"* ]]; then
echo "Loading modules for derecho"
module load ncarenv/23.09  intel/2023.2.1
module load ncarcompilers
#module load intel-mpi
module load cray-mpich
module load netcdf
module load ncview
module load nco
module load julia
fi

export PATH=/glade/u/home/ezaron/opt/bin:${PATH}

