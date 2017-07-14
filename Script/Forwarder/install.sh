#!/bin/bash
###########
# Script install splunk forwarder for CentOs7
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
check_pre_install(){
	if [ -f "SPLUNK_DIRECT" ]
	then
		echo "You has allready installed Puppet!"
		exit 1
	fi
}
extra_rpm_splunk(){

	if [ -f "$base_path/$SPLUNK_RPM_DIRECT/$SPLUNK_RPM" ]
	then
		rpm -iv --replacepkgs "$base_path/$SPLUNK_RPM_DIRECT/$SPLUNK_RPM"
	else
		echo "Package not exist!"
		exit 0
	fi
}
run_splunk(){
	$SPLUNK_DIRECT/bin/splunk start --accept-license
}
deploy_splunk(){
	$SPLUNK_DIRECT/bin/splunk set deploy-poll $IPSERVER:$PORT_deploy
}
add_forwarder_splunk(){
	$SPLUNK_DIRECT/bin/splunk add forward-server $IPSERVER:$PORT_forward
}
echo "Installing splunk forwarding"
check_pre_install
extra_rpm_splunk
run_splunk
deploy_splunk
add_forwarder_splunk
echo "Done!"
