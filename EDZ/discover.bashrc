
alias emacs='emacs -nw'

# SEE SANTHA's env.csh at https://github.com/sanAkel/MAP_ROSES2020-calOcn/blob/main/env.csh
# This sets up the equivalent in bash:
source /usr/share/lmod/8.4.28/init/bash
module purge

module load comp/gcc/10.1.0
module load comp/intel/2021.3.0
module load mpi/impi/2021.3.0
#module load python/GEOSpyD/Min4.10.3_py3.9_AND_Min4.8.3_py2.7
module load git/2.36.0
module load cmake/3.23.1
module load netcdf4/4.8.1-parallel
# Santha also manually sets the dylib path. Not sure if it is needed.

# Use this module to make available the FRENC-tools
module use -a /discover/swdev/gmao_SIteam/modulefiles-SLES12

module load ncview

PATH=${PATH}:${HOME}/opt/bin
