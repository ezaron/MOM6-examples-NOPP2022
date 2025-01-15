# .bash_profile is executed only on login. The .bashrc is executed for every new shell.

# Make sure our BASH_ENV is consistent with what is used in non-interactive shells:
source /usr/share/lmod/8.4.28/init/bash

export LMOD_ANCIENT_TIME=14400
export OS_VERSION=`grep VERSION_ID /etc/os-release | cut -d= -f2 | cut -d. -f1 | sed 's/"//g'`

if [ "$OS_VERSION" == 15 ]; then
    # SCU17 refers to SLES15
    export LMOD_SYSTEM_NAME=SLES15
    module purge
    rm -rf ${HOME}/.lmod.d/.cache
#    ml --ignore-cache av
    module use -a /discover/swdev/gmao_SIteam/modulefiles-SLES15
    module load GEOSenv
    module load ffmpeg
    module load ncview
    module load julia
    module load netcdf4
else
    # SCU15 refers to SLES12
    export LMOD_SYSTEM_NAME=SLES12
    module purge
    rm -rf ${HOME}/.lmod.d/.cache
#    ml --ignore-cache av
    module use -a /discover/swdev/gmao_SIteam/modulefiles-SLES12
    module load GEOSenv
    #   module use -a ~sakella/modulefiles
    # Use this module to make available the FRENC-tools
    # module use -a /discover/swdev/gmao_SIteam/modulefiles-SLES12
    module load ffmpeg
    module load ncview
    module load julia
fi

export TMPDIR=${NOBACKUP}/tmp

export PATH=${PATH}:${HOME}/opt/bin
#export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${HOME}/opt/src/julia-1.9.1/lib

alias emacs='emacs -nw'
