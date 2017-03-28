#!/bin/bash

if [ ! -f /etc/firstrun ]
then

        if [ ! -f /etc/bareos-webui/directors.ini ]
        then
                tar xfvz /etc.tgz
        fi

        # cleanup
        touch /etc/firstrun
        rm /etc.tgz
fi

exec "$@"
