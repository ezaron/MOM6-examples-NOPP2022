
# How-To Bugfix and Pull-Request on GFDL MOM6-dev

## Preliminaries:

My `https://github.com/ezaron/MOM6-NOPP2022` is a fork from `https://github.com/mom-ocean/MOM6`.

Is `https://github.com/mom-ocean/MOM6` an alias of "MOM6-dev" that Santha et al refer to?

What is the relation of `https://github.com/NOAA-GFDL/MOM6` and `https://github.com/mom-ocean/MOM6`?
Aha! `https://github.com/mom-ocean/MOM6` is forked from `https://github.com/NOAA-GFDL/MOM6` and it is
ahead of it. Thus, to make a pull request, I need to fork `https://github.com/mom-ocean/MOM6`.

Delete my old `https://github.com/ezaron/MOM6-NOPP2022`, and recreate it as a fork of `https://github.com/NOAA-GFDL/MOM6`

Same for my other repos forked from the mainline ones. Delete them.

## Building the MOM-NOPP2022

Here we checkout the MOM-NOPP2022 source code inside my MOM-examples-flat tree and try to build and run it.

cd

git config --global http.sslVerify true

cd MOM6-examples-flat/src

git clone --config http.sslVerify=false https://secure_token@github.com/ezaron/MOM6-NOPP2022 MOM6-NOPP2022

cd MOM6-NOPP2022

git submodule update --init --recursive

cd ~/MOM6-examples-flat/build/ocean_only

make clean

rm -f list_paths

../../src/mkmf/bin/list_paths -l ./ ../../src/MOM6-NOPP2022/{config_src/infra/FMS1,config_src/memory/dynamic_symmetric,config_src/drivers/solo_driver,config_src/external,src/{*,*/*}}/

../../src/mkmf/bin/mkmf -t ../../src/mkmf/templates/cheyenne-intel.mk -o '-I../fms' -p MOM6-NOPP2022 -l '-L../fms -lfms' path_names

make REPRO=1 MOM6-NOPP2022

## Running the Test Cases Prior to Making Any Code Changes

cd ~/MOM6-examples-flat/src/MOM6-NOPP2022

cd .testing

make all

Read the README! There may be some complications.

make test

Everything is saying PASS. I might want to run all this on casper instead of cheyenne, since the code appears to be running on the login node, and not submitted to the queue.

tc3.openmp fails.

tc2 seems to pass. Look inside the tc2 directory to see what is being compared.

cd work/tc2/asymmetric








