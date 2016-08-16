#!/bin/bash

LOG_PATH="/home/basti/Osmocom/log-files"
CONFIG_PATH="/home/basti/Osmocom/config-files"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEBUG="DSQL:DLSMS:DRLL:DCC:DMM:DRR:DMSC:DHO:DGPRS:DNS:DLLC:DCTRL"

# start osmopcu
#  -h	--help		this text
#  -c	--config-file 	Specify the filename of the config file
#  -m	--mcc MCC	use given MCC instead of value provided by BTS
#  -n	--mnc MNC	use given MNC instead of value provided by BTS
#  -V   --version	print version
#  -r   --realtime PRIO Use SCHED_RR with the specified priority
#  -i	--gsmtap-ip	The destination IP used for GSMTAP.
$DIR/osmo-pcu/src/osmo-pcu -c $CONFIG_PATH/osmopcu-virtual.cfg -i 127.0.0.1 2>&1 | tee -a $LOG_PATH/osmopcu.log
