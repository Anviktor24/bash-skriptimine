#!/bin/bash
# Pesastatud until-tsükkel
valine=1
until [ $valine -gt 5 ]; do
    sisemine=1
    until [ $sisemine -gt 5 ]; do
        echo "$valine$sisemine"
        sisemine=$((sisemine + 1))
    done
    valine=$((valine + 1))
done
