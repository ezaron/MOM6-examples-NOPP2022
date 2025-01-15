#!/bin/csh

### following something like:
# https://github.com/NOAA-GFDL/MOM6-examples/wiki/Gaea-compiler-environment
###

set arch = `uname -s`
set mach = `uname -m`
set node = `uname -n`

# modules: mod1- mom7 follow those being used in GMAO's [GEOS-ESM](https://github.com/GEOS-ESM/). 
set mod1 = comp/gcc/10.1.0
set mod2 = comp/intel/2021.3.0

set basedir = /discover/swdev/gmao_SIteam/Baselibs/ESMA-Baselibs-6.2.8/x86_64-pc-linux-gnu/ifort_2021.3.0-intelmpi_2021.3.0
set mod3 = mpi/impi/2021.3.0

#set mod4 = lib/mkl/19.1.3.304
#set mod5 = python/GEOSpyD/Min4.10.3_py3.9
set mod5 = python/GEOSpyD/Min4.10.3_py3.9_AND_Min4.8.3_py2.7

set mod6 = git/2.36.0
set mod7 = cmake/3.23.1

set mods = ( $mod1 $mod2 $mod3 $mod5 $mod6 $mod7)

set modinit = /usr/share/modules/init/csh

#-------------------------------------------------------------------------
# set environment variables, BASEDIR and LD_LIBRARY_PATH; and load modules
#-------------------------------------------------------------------------

# add BASEDIR lib to LD_LIBRARY_PATH, if not already there
#---------------------------------------------------------

setenv BASEDIR $basedir

if ($?LD_LIBRARY_PATH) then
   echo $LD_LIBRARY_PATH | grep $BASEDIR/$arch/lib > /dev/null
   if ($status) then  #  == 1, if not found
      setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:$BASEDIR/$arch/lib
   endif
else
   setenv LD_LIBRARY_PATH $BASEDIR/$arch/lib
endif

# add individual $ld_libraries to LD_LIBRARY_PATH, if not already there
#----------------------------------------------------------------------
if ($?ld_libraries) then
   foreach lib ( $ld_libraries )
      if ($LD_LIBRARY_PATH !~ *$lib*) then
         setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:$lib
      endif
   end
endif

if ($?LD_LIBRARY64_PATH) then
   echo $LD_LIBRARY64_PATH | grep $BASEDIR/$arch/lib > /dev/null
   if ($status) then  #  == 1, if not found
      setenv LD_LIBRARY64_PATH ${LD_LIBRARY64_PATH}:$BASEDIR/$arch/lib
   endif
endif

# load library modules
#---------------------
source $modinit
module purge

#echo $mods
foreach mod ($mods)
  module load $mod
end

setenv PATH $BASEDIR/Linux/bin:$PATH

