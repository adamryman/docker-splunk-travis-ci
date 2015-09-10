#!/bin/bash

set -e

if [ "$1" = 'start-service' ]; then
  cp -fR /var/opt/splunk/etc ${SPLUNK_HOME}
  chown -R ${SPLUNK_USER}:${SPLUNK_GROUP} $SPLUNK_HOME/etc
  chown -R ${SPLUNK_USER}:${SPLUNK_GROUP} $SPLUNK_HOME/var

  sudo -HEu ${SPLUNK_USER} ${SPLUNK_HOME}/bin/splunk start --accept-license --answer-yes --no-prompt
  trap "sudo -HEu ${SPLUNK_USER} ${SPLUNK_HOME}/bin/splunk stop" SIGINT SIGTERM EXIT
  sudo -HEu ${SPLUNK_USER} tail -n 0 -f ${SPLUNK_HOME}/var/log/splunk/splunkd_stderr.log &
  wait
fi
