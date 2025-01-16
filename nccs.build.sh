
#export MYFLAGS="NETCDF=3 REPRO=1"
#export MYFLAGS="NETCDF=3 DEBUG=1"
export MYFLAGS="NETCDF=3"
#export MYFLAGS="DEBUG=1" # My comments in the grid.F90 file are not displayed!

#SRCDIR=~/MOM6-examples-flat
SRCDIR=/home/ezaron/nobackup/MOM6-examples-NOPP2022
#TMPL=../../src/mkmf/templates/cheyenne-intel.mk
#TMPL=../../src/mkmf/templates/derecho-intel.mk
#TMPL=../../src/mkmf/templates/derecho-intel.mk
#TMPL=../../src/mkmf/templates/nccs-intel.mk ; source ~/MOM6-examples-flat/EDZ/env-scu15.sh
#TMPL=../../src/mkmf/templates/nccs-intel.mk
TMPL=../../src/mkmf/templates/nccs-scu17.mk
source ${SRCDIR}/EDZ/env-scu17.sh

echo "CLEAN = ${CLEAN}"

if [ -n "${CLEAN}" ]; then
cd ${SRCDIR}
mkdir -p build/fms/
cd build/fms/
rm -f path_names
../../src/mkmf/bin/list_paths -l ../../src/FMS
../../src/mkmf/bin/mkmf -t ${TMPL} -p libfms.a -c "-Duse_libMPI -Duse_netCDF" path_names
make clean
make ${MYFLAGS} libfms.a
fi

cd ${SRCDIR}
mkdir -p build/ocean_only
cd build/ocean_only/
if [ -n "${CLEAN}" ]; then
rm -f path_names
#../../src/mkmf/bin/list_paths -l ./ ../../src/MOM6/{config_src/infra/FMS1,config_src/memory/dynamic_symmetric,config_src/drivers/solo_driver,config_src/external,src/{*,*/*}}/
../../src/mkmf/bin/list_paths -l ./ ../../src/MOM6-NOPP2022/{config_src/infra/FMS1,config_src/memory/dynamic_symmetric,config_src/drivers/solo_driver,config_src/external,src/{*,*/*}}/
../../src/mkmf/bin/mkmf -t ${TMPL} -o '-I../fms' -p MOM6 -l '-L../fms -lfms' path_names
make clean
fi
make ${MYFLAGS} MOM6

exit

cd ${SRCDIR}
mkdir -p build/ice_ocean_SIS2
cd build/ice_ocean_SIS2/
make clean
rm -f path_names
../../src/mkmf/bin/list_paths -l ./ ../../src/MOM6/config_src/{infra/FMS1,memory/dynamic_symmetric,drivers/FMS_cap,external}/ ../../src/MOM6/src/{*,*/*}/ ../../src/{atmos_null,coupler,land_null,ice_param,icebergs,SIS2,FMS/coupler,FMS/include}/
../../src/mkmf/bin/mkmf -t ${TMPL} -o '-I../fms' -p MOM6 -l '-L../fms -lfms' -c '-Duse_AM3_physics -D_USE_LEGACY_LAND_' path_names
make ${MYFLAGS} MOM6

exit

# Santha showing me how to build his executable:
ssh -XY discover-mil
-XYC -t
ssh -XYC -t  ezaron@login.nccs.nasa.gov discover-mil
SCU17 and SLES15 discover nccs web page says how to setup the OS_VERSION

/discover/nobackup/sakella/SCU17/apps/MOM6-examples_11Oct2023/build/intel/ice_ocean_SIS2/repro/MOM6
/discover/nobackup/sakella/SCU17/apps/MOM6-examples_11Oct2023/build/intel/ocean_only/repro/MOM6
SEE env.csh in /discover/nobackup/sakella/SCU17/apps/MOM6-examples_11Oct2023/build/intel/
### To get an interactive node on discover sccu15:
### salloc -n 1840 -t 0:10:00 --constraint=mil


export MYFLAGS="NETCDF=3 REPRO=1"
#export MYFLAGS="NETCDF=3 DEBUG=1"
#export MYFLAGS="NETCDF=3"
#export MYFLAGS="DEBUG=1" # My comments in the grid.F90 file are not displayed!

SRCDIR=~/MOM6-examples-flat
#TMPL=../../src/mkmf/templates/cheyenne-intel.mk
#TMPL=../../src/mkmf/templates/derecho-intel.mk
#TMPL=../../src/mkmf/templates/nccs-intel.mk ; source ~/MOM6-examples-flat/EDZ/env-scu15.sh
TMPL=../../src/mkmf/templates/nccs-scu17.mk ; source ~/MOM6-examples-flat/EDZ/env-scu17.sh

cd ${SRCDIR}
mkdir -p build/fms_scu17/
cd build/fms_scu17/
make clean
rm -f path_names
../../src/mkmf/bin/list_paths -l ../../src/FMS
../../src/mkmf/bin/mkmf -t ${TMPL} -p libfms.a -c "-Duse_libMPI -Duse_netCDF" path_names
make ${MYFLAGS} libfms.a |& tee fms-scu17.log

cd ${SRCDIR}
mkdir -p build/scu17/
cd build/scu17/
make clean
rm -f path_names
../../src/mkmf/bin/list_paths -l ./ ../../src/MOM6/{config_src/infra/FMS1,config_src/memory/dynamic_symmetric,config_src/drivers/solo_driver,config_src/external,src/{*,*/*}}/
../../src/mkmf/bin/mkmf -t ${TMPL} -o '-I../fms_scu17' -p MOM6 -l '-L../fms_scu17 -lfms' path_names
make ${MYFLAGS} MOM6 |& tee mom6-scu17.log

