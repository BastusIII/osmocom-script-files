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
$DIR/openbsc/openbsc/src/osmo-nitb/osmo-nitb -c $CONFIG_PATH/openbsc-virtual.cfg -l $CONFIG_PATH/hlr.sqlite3 -P -M /tmp/bsc_mncc -C 2>&1 | tee -a $LOG_PATH/openbsc.log &

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
$DIR/openggsn/ggsn/ggsn -c $CONFIG_PATH/openggsn-virtual.conf -d  2>&1 | tee -a $LOG_PATH/openggsn.log &

# start sgsn
#  -h --help	this text
#  -D --daemonize	Fork the process into a background daemon
#  -d option --debug	enable Debugging
#  -s --disable-color
#  -c --config-file	The config file to use [osmo_sgsn.cfg]
#  -e --log-level number	Set a global log level
$DIR/openbsc/openbsc/src/gprs/osmo-sgsn -c $CONFIG_PATH/osmosgsn-virtual.cfg -d  2>&1 | tee -a $LOG_PATH/osmosgsn.log &

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
$DIR/osmo-bts/src/osmo-bts-virtual/osmo-bts-virtual -c $CONFIG_PATH/osmobts-virtual.cfg -i 127.0.0.1 2>&1 | tee -a $LOG_PATH/osmobts.log &

# start osmopcu
#  -h	--help		this text
#  -c	--config-file 	Specify the filename of the config file
#  -m	--mcc MCC	use given MCC instead of value provided by BTS
#  -n	--mnc MNC	use given MNC instead of value provided by BTS
#  -V   --version	print version
#  -r   --realtime PRIO Use SCHED_RR with the specified priority
#  -i	--gsmtap-ip	The destination IP used for GSMTAP.
$DIR/osmo-pcu/src/osmo-pcu -c $CONFIG_PATH/osmopcu-virtual.cfg -i 127.0.0.1 2>&1 | tee -a $LOG_PATH/osmopcu.log &
