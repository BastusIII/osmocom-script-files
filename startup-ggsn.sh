#!/bin/bash

LOG_PATH="/home/basti/Osmocom/log-files"
CONFIG_PATH="/home/basti/Osmocom/config-files"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEBUG="DSQL:DLSMS:DRLL:DCC:DMM:DRR:DMSC:DHO:DGPRS:DNS:DLLC:DCTRL"

# start openggsn
#  -h, --help             Print help and exit
#  -V, --version          Print version and exit
#  -f, --fg               Run in foreground  (default=off)
#  -d, --debug            Run in debug mode  (default=off)
#  -c, --conf=STRING      Read configuration file  (default=`/etc/ggsn.conf')
#      --pidfile=STRING   Filename of process id file  
#                           (default=`/var/run/ggsn.pid')
#      --statedir=STRING  Directory of nonvolatile data  
#                           (default=`/var/lib/ggsn/')
#  -l, --listen=STRING    Local interface
#  -n, --net=STRING       Network  (default=`192.168.0.0/24')
#      --ipup=STRING      Script to run after link-up
#      --ipdown=STRING    Script to run after link-down
#      --dynip=STRING     Dynamic IP address pool
#      --statip=STRING    Static IP address pool
#      --pcodns1=STRING   PCO DNS Server 1  (default=`0.0.0.0')
#      --pcodns2=STRING   PCO DNS Server 2  (default=`0.0.0.0')
#      --timelimit=INT    Exit after timelimit seconds  (default=`0')
#  -a, --apn=STRING       Access point name  (default=`internet')
#  -q, --qos=INT          Requested quality of service  (default=`0x0b921f')
#      --logfile=STRING   Logfile for errors
#      --loglevel=STRING  Global log ldevel  (default=`error')
#  -g, --gtpnl=STRING     GTP kernel support  (default=`eth0')
$DIR/openggsn/ggsn/ggsn -c $CONFIG_PATH/openggsn-virtual.conf -d -f 2>&1 | tee -a $LOG_PATH/openggsn.log
