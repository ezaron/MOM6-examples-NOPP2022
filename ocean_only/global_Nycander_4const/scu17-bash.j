#!/bin/bash
### THIS IS BASED ON https://github.com/sanAkel/MAP_ROSES2020-calOcn/blob/main/run_workflow/run_OM4_025_CORE.j
### Note that we are inside a csh, not my usual bash.
### Submit this script with sbatch!
#
# To get an interactive node on discover sccu15:
# salloc -t 0:10:00 --constraint=mil


#SBATCH --job-name=Global_test
#SBATCH --time=12:00:00
### #SBATCH --time=1:00:00
### #SBATCH --qos=debug

# Skylake nodes have 36 usable cores per node:
### #SBATCH --nodes=14 --ntasks-per-node=36
### #SBATCH --constraint=sky
### #SBATCH --ntasks=504

# Cascade nodes have 46 usable cores:
# Instructions recommend not asking for specific number of nodes:
# https://www.nccs.nasa.gov/nccs-users/instructional/using-slurm/best-practices#node-constraints-cas
#SBATCH --constraint=mil
#SBATCH --ntasks=1840

#SBATCH --account=s2640

#SBATCH -o mom.o%j
#SBATCH -e mom.e%j

#######################################################################
#                         System Settings
#######################################################################

umask 022
ulimit -s unlimited

#######################################################################
#             Experiment Specific Environment Variables
#######################################################################

#export ROOTDIR=/home/ezaron/MOM6-examples-flat
export ROOTDIR=/home/ezaron/nobackup/MOM6-examples-NOPP2022
export SRCDIR=${ROOTDIR}
export EXECDIR=${ROOTDIR}/build/ocean_only/
export EXEC=MOM6

#######################################################################
#           Architecture Specific Environment Variables
#######################################################################

export ARCH=`uname`
export SITE=NCCS

source ${SRCDIR}/EDZ/env-scu17.sh
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${BASEDIR}/${ARCH}/lib

# refer to mask.table to figure out num of procs (for e.g., 480)
# Look at MOM_layout
export RUN_CMD="mpirun -np 1840 "
cp scu17.MOM_layout MOM_layout

# create an output dir, if it does not exist
/usr/bin/mkdir -p OUTPUT
/usr/bin/mkdir -p RESTART
/usr/bin/mkdir -p HA
/usr/bin/mkdir -p DIAG

${RUN_CMD} ${EXECDIR}/${EXEC}
