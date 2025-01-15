
# Moved these from my .bashrc so that I call from build script and
# job submission script instead:
#module purge
module load comp/gcc/12.3.0
module load comp/intel/2021.6.0
module load mpi/openmpi/4.1.5/intel-2021.6.0
module load python/GEOSpyD/Min23.5.2-0_py3.11
#module load git/2.42.0
#module load cmake/3.27.4
module load git
module load cmake

export BASEDIR=/discover/swdev/gmao_SIteam/Baselibs/ESMA-Baselibs-7.14.0/x86_64-pc-linux-gnu/ifort_2021.6.0-openmpi_4.1.5-SLES15
export arch=Linux
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$BASEDIR/$arch/lib
export LD_LIBRARY64_PATH=${LD_LIBRARY64_PATH}:$BASEDIR/$arch/lib
PATH=${BASEDIR}/Linux/bin:${PATH}

