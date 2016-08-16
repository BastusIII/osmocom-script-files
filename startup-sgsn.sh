#!/bin/bash

LOG_PATH="/home/basti/Osmocom/log-files"
CONFIG_PATH="/home/basti/Osmocom/config-files"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEBUG="DSQL:DLSMS:DRLL:DCC:DMM:DRR:DMSC:DHO:DGPRS:DNS:DLLC:DCTRL"

# start sgsn
#  -h --help	this text
#  -D --daemonize	Fork the process into a background daemon
#  -d option --debug	enable Debugging
#  -s --disable-color
#  -c --config-file	The config file to use [osmo_sgsn.cfg]
#  -e --log-level number	Set a global log level
$DIR/openbsc/openbsc/src/gprs/osmo-sgsn -c $CONFIG_PATH/osmosgsn-virtual.cfg -d  2>&1 | tee -a $LOG_PATH/osmosgsn.log
