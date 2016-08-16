#!/bin/bash

LOG_PATH="/home/basti/Osmocom/log-files"
CONFIG_PATH="/home/basti/Osmocom/config-files"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEBUG="DSQL:DLSMS:DRLL:DCC:DMM:DRR:DMSC:DHO:DGPRS:DNS:DLLC:DCTRL"

# start osmobts
#  -h	--help		this text
#  -d	--debug MASK	Enable debugging (e.g. -d DRSL:DOML:DLAPDM)
#  -D	--daemonize	For the process into a background daemon
#  -c	--config-file 	Specify the filename of the config file
#  -s	--disable-color	Don't use colors in stderr log output
#  -T	--timestamp	Prefix every log line with a timestamp
#  -V	--version	Print version information and exit
#  -e 	--log-level	Set a global log-level
#  -r	--realtime PRIO	Use SCHED_RR with the specified priority
#  -i	--gsmtap-ip	The destination IP used for GSMTAP.
#  -t	--trx-num	Set number of TRX (default=1)
$DIR/osmo-bts/src/osmo-bts-virtual/osmo-bts-virtual -c $CONFIG_PATH/osmobts-virtual.cfg -i 127.0.0.1 -d $DEBUG 2>&1 | tee -a $LOG_PATH/osmobts.log
