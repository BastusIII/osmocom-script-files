#!/bin/bash

LOG_PATH="/home/basti/Osmocom/log-files"
CONFIG_PATH="/home/basti/Osmocom/config-files"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEBUG="DSQL:DLSMS:DRLL:DCC:DMM:DRR:DMSC:DHO:DGPRS:DNS:DLLC:DCTRL"

# start osmobsc in nitb mode
#  -h --help                  This text.
#  -d option --debug=DRLL:DCC:DMM:DRR:DRSL:DNM  Enable debugging.
#  -D --daemonize             Fork the process into a background daemon.
#  -c --config-file filename  The config file to use.
#  -s --disable-color
#  -l --database db-name      The database to use.
#  -a --authorize-everyone    Authorize every new subscriber. Dangerous!
#  -T --timestamp             Prefix every log line with a timestamp.
#  -V --version               Print the version of OpenBSC.
#  -P --rtp-proxy             Enable the RTP Proxy code inside OpenBSC.
#  -e --log-level number      Set a global loglevel.
#  -M --mncc-sock-path PATH   Disable built-in MNCC handler and offer socket.
#  -m --mncc-sock 	      Same as `-M /tmp/bsc_mncc' (deprecated).
#  -C --no-dbcounter          Disable regular syncing of counters to database.
#  -r --rf-ctl PATH           A unix domain socket to listen for cmds.
$DIR/openbsc/openbsc/src/osmo-nitb/osmo-nitb -c $CONFIG_PATH/openbsc-virtual-nogprs.cfg -l $CONFIG_PATH/hlr.sqlite3 -P -M /tmp/bsc_mncc -C 2>&1 -d $DEBUG| tee -a $LOG_PATH/openbsc.log
