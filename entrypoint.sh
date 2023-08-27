#!/bin/bash

VEILID_CONFIG_FILE="/etc/veilid-server/veilid-server.conf"
DEFAULT_VEILID_CONFIG_FILE="/default-veilid-server.conf"

#Copies default config if it doesn't exist
if [ ! -f ${VEILID_CONFIG_FILE} ]
then
    cp ${DEFAULT_VEILID_CONFIG_FILE} ${VEILID_CONFIG_FILE}
fi

veilid-server $@
