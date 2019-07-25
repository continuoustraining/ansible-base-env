#!/bin/bash
# get ansible env variables
source $1
state=${state:-present}
if [[ $state == "present" ]]; then
    if [[ $(service $service status) != 0 ]]; then
        service $service start > /dev/null
        echo { \"changed\": true }
        exit 0
    else
        echo { \"changed\": false }
        exit 0
    fi
fi

if [[ $state == "absent" ]]; then
    if [ [ $(service $service status) == 0 ] ]; then
        service $service stop > /dev/null
        echo { \"changed\": true }
        exit 0
    else
        echo { \"changed\": false }
        exit 0
    fi
fi
