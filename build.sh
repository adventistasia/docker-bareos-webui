#!/bin/bash

docker build --no-cache --force-rm -t ssdit/bareos-webui:experimental-17.1.3 -t ssdit/bareos-webui:experimental-latest -f ./Dockerfile-experimental .
