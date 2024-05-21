#!/bin/bash

source /opt/nwcsaf/.nwcgeo

SAFNWCTM

# SAFNWCTM command is started to the background, so wait for 10 years
# so the container doesn't exit immediately
sleep 315360000
