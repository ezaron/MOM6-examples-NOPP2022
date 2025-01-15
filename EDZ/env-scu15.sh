
# Moved these from my .bashrc so that I call from build script and
# job submission script instead:
#module purge
module load comp/gcc/10.1.0
module load comp/intel/2021.3.0
module load mpi/impi/2021.3.0
module load git/2.36.0
module load cmake/3.23.1
module load netcdf4/4.8.1-parallel
# Santha also manually sets the dylib path. Not sure if it is needed.

export BASEDIR=/discover/swdev/gmao_SIteam/Baselibs/ESMA-Baselibs-6.2.8/x86_64-pc-linux-gnu/ifort_2021.3.0-intelmpi_2021.3.0

export ARCH=Linux
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$BASEDIR/$ARCH/lib
export LD_LIBRARY64_PATH=${LD_LIBRARY64_PATH}:$BASEDIR/$arch/lib
PATH=${BASEDIR}/Linux/bin:${PATH}
