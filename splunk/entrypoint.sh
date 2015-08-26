#!/bin/bash

set -e

if [ "$1" = 'splunk' ]; then
  shift
  sudo -HEu ${SPLUNK_USER} ${SPLUNK_HOME}/bin/splunk "$@"
elif [ "$1" = 'start-service' ]; then

  sudo mkdir -p ${SPLUNK_BACKUP_DEFAULT_ETC}/etc/system/local/
  sudo touch ${SPLUNK_BACKUP_DEFAULT_ETC}/etc/system/local/server.conf

  echo "[general]" >> ${SPLUNK_BACKUP_DEFAULT_ETC}/etc/system/local/server.conf
  echo "allowRemoteLogin = always" >> ${SPLUNK_BACKUP_DEFAULT_ETC}/etc/system/local/server.conf
  # If these files are different override etc folder (possible that this is upgrade or first start cases)
  # Also override ownership of these files to splunk:splunk
  cp -fR ${SPLUNK_BACKUP_DEFAULT_ETC}/etc ${SPLUNK_HOME}
  chown -R ${SPLUNK_USER}:${SPLUNK_GROUP} $SPLUNK_HOME/etc
  chown -R ${SPLUNK_USER}:${SPLUNK_GROUP} $SPLUNK_HOME/var

  sudo -HEu ${SPLUNK_USER} ${SPLUNK_HOME}/bin/splunk start --accept-license --answer-yes --no-prompt
  trap "sudo -HEu ${SPLUNK_USER} ${SPLUNK_HOME}/bin/splunk stop" SIGINT SIGTERM EXIT

  sudo -HEu ${SPLUNK_USER} tail -n 0 -f ${SPLUNK_HOME}/var/log/splunk/splunkd_stderr.log &
  wait
else
  "$@"
fi
