#!/bin/bash
###########
# Script uninstall splunk forwarder for CentOs7
# Write by Lacoski
###########
# Variable
readonly base_file=`readlink -f "$0"`
readonly base_path=`dirname $base_file`

SPLUNK_RPM_DIRECT="lib"
SPLUNK_RPM="splunkforwarder-6.6.2-4b804538c686-linux-2.6-x86_64.rpm"
SPLUNK_DIRECT="/opt/splunkforwarder"
export SPLUNK_USERNAME=admin
export SPLUNK_PASSWORD=changeme
IPSERVER="10.0.0.160"
PORT_deploy=8089
PORT_forward=9997
# Start config

user_name=`whoami`
if [ ! $user_name = "root" ]
then
	echo "You need root permission to run this script"
	exit 1
fi

stop_splunk(){
	$SPLUNK_DIRECT/bin/splunk stop
}
remove_splunk(){
	rm -rf $SPLUNK_DIRECT
}
echo "Running script uninstalling Splunk forwarder"
stop_splunk
remove_splunk
echo "You must reboot to successful uninstalling!"
