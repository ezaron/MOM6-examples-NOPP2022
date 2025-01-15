#
#set _loaded=$?MODULESHOME               # Remember if modules already loaded
#if ($?tcsh) then
#        set modules_shell="tcsh"
#else
#        set modules_shell="csh"
#endif
#source /usr/share/modules/init/$modules_shell

# from Matt (09/22/2022)
setenv LMOD_ANCIENT_TIME 14400
# when working with new modules, clear cache in: `.lmod.d/.cache/`

# Santha's customizations
# .........................................................................
# Interative Shell variables and settings
if (! $?prompt) exit                    #exit if not interactive

# Look for the OS version and set the module path accordingly
set OS_VERSION=`grep VERSION_ID /etc/os-release | cut -d= -f2 | cut -d. -f1 | sed 's/"//g'`

# Only put module use or other module commands here
# and in the correct OS version
if ($OS_VERSION == 15) then
   setenv LMOD_SYSTEM_NAME SLES15
   module use -a /discover/swdev/gmao_SIteam/modulefiles-SLES15
   module load GEOSenv
else
   setenv LMOD_SYSTEM_NAME SLES12
   module use -a /discover/swdev/gmao_SIteam/modulefiles-SLES12
   module load GEOSenv
   module use -a ~sakella/modulefiles
endif
#module use -a /discover/swdev/gmao_SIteam/modulefiles-SLES12



set USER = `id | sed "s/)/(/" | cut -d"(" -f2`
set prompt="`uname -n`.$USER \!> "      # prompt

set noclobber                           # Don't clobber file with cp/mv
set cdpath = (. $HOME)
set history=1000                        # C shell history
set savehist=1000                       # history saved between logins
set ignoreeof                           # prevent accidental exit
set filec                               # file completion

setenv LESS " -fRimWFX "
# .........................................................................
# Standard aliases
alias rm /bin/rm -i                     # prompting remove
alias mv /bin/mv -i                     # prompting move
alias cp /bin/cp -i                     # prompting copy
alias du  du -h --max-depth=1           # summarize per-directory

alias clc 'clear'
alias ls 'ls -FN  --color=auto'
alias ll 'ls -lht --color'
alias rm 'rm  -i'
# This is is needed to set terminal type.
alias ts 'set noglob; eval `tset -sQ \!*`; unset noglob; set term=$TERM'
alias xterm '/usr/bin/X11/xterm -sb -sl 20000 -bg white -fg blue'
#--------------------------------

alias htop    '/usr/local/other/Htop/0.9/bin/htop'
alias myQuota 'showquota -h'
alias grepc   'grep --color '
#--------------------------------
#alias myQ 'squeue -a -u sakella'
alias myQ 'squeue -a -o "%.10i %.12P %.10q %.30j %.8u %.8T %.10M %.9l %.6D %.6C %R" -u sakella'
#
alias nbk        'cd /discover/nobackup/sakella'
alias nbk_vda    'cd /discover/nobackup/projects/gmao/advda/sakella/'
alias nbk_obs    'cd /discover/nobackup/projects/gmao/obsdev/sakella/'
alias nbk_soca   'cd /discover/nobackup/projects/gmao/soca/sakella/'
alias nbk_altAna 'cd /discover/nobackup/projects/gmao/alt-ana/sakella/'
alias nbk_calOcn 'cd /discover/nobackup/projects/gmao/cal_ocn/sakella/'
alias nbk_scda   'cd /discover/nobackup/projects/gmao/scda_iesa/sakella/'
alias nbk_osst   'cd /discover/nobackup/projects/gmao/osst-sss/sakella/'
#
alias css_calOcn 'cd /css/gmao/cal-ocn/'

alias milan 'ssh -XY discover-mil'
#--------------------------------
#

alias Archive  'cd /archive/u/sakella'

alias cvsxdiff         '/home/rtodling/bin/cvsxdiff -bwi'
alias xxdiff           'xxdiff -bwi'
alias cvsbranch        '/home/rtodling/bin/cvsbranch'
alias geeqie           '/home/adarmeno/local/geeqie-1.1/bin/geeqie'

alias nas              'ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 sfe1.nas.nasa.gov'

alias coaps-fsu        'ssh -XY login.coaps.fsu.edu'
alias aws              'ssh -XYC g0613.nccs.smce.nasa.gov'
#--------------------------------

alias tree     ~mathomp4/bin/tree
alias nodeStat ~mathomp4/bin/nodestats.bash
#alias ncdump  $BASEDIR/Linux/bin/ncdump
#alias ncks    $BASEDIR/Linux/bin/ncks
#alias hdfdump $BASEDIR/Linux/bin/hdfdump
#--------------------------------
umask 0022
unlimit
limit stacksize  unlimited
limit vmemoryuse unlimited

unset limits
setenv MP_STACK_SIZE 64000000

set arch = `uname`
set ARCH = `uname`
#setenv LD_LIBRARY_PATH ${LIBRARY_PATH}:${BASEDIR}/${arch}/lib

# http://www.nccs.nasa.gov/primer/slurm/slurmPBS.html 
# add native slurm manpath for native slurm help.
setenv MANPATH {$MANPATH}:/usr/slurm/share/man
#--------------------------------
set node = `uname -n | cut -c 1-4`

#..............................CVS info...........................
# talk to Matt to make this better! Apr 2014.
setenv CVS_RSH /usr/bin/ssh
setenv CVSROOT ":ext:sakella@progressdirect:/cvsroot/esma"
# --------------------------------------------------------------------

#GRADS
#set path = ( . ~/bin /home/dao_ops/operations/GrADS/current $path )
set path = ( . ~/bin ~/usr/bin $SHARE/dasilva/opengrads/Contents $path )
#set path = ( . ~/bin /share/dasilva/opengrads/Contents /usr/local/other/Python-2.5.4/bin $path )
# ------------------------------------------------------------------- 

#source /discover/nobackup/sakella/GEOSadas/src/GMAO_Shared/GEOS_Util/plots/.quickplotrc
cd $NOBACKUP
# ------------------------------------------------------------------- 
# python path
#setenv PYTHONPATH /gpfsm/dhome/sakella/python_docs/myStuff
#setenv PYTHONPATH /discover/nobackup/sakella/GEOSadas/Linux/lib/Python/
# ------------------------------------------------------------------- 

