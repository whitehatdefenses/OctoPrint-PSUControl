#!/bin/bash
#
# Copyright 2017 Shawn Bruce
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# See the COPYING file in the main directory for details.
#

#SCRIPT_PATH Should point to tplink-smartplug.py provided by https://github.com/softScheck/tplink-smartplug
SCRIPT_PATH="./tplink-smartplug.py"

PLUG_ADDR=$1
ACTION=$2

case $ACTION in
    on)
        echo "Turning On..."
        ${SCRIPT_PATH} -t ${PLUG_ADDR} -c on
        exit $?
        ;;
    off)
        echo "Turning Off..."
        ${SCRIPT_PATH} -t ${PLUG_ADDR} -c off
        exit $?
        ;;
    sense)
        relay_state=`${SCRIPT_PATH} -t ${PLUG_ADDR} -c info | sed 's/,/\n/g' | grep 'relay_state' | awk -F':' ' { print $2 } '`
        if [ $relay_state -eq 1 ]
        then
            echo "On"
            exit 0
        elif [ $relay_state -eq 0 ]
        then
            echo "Off"
            exit 1
        else
            echo "Unknown Error"
            exit 1
        fi
        ;;
    *)
        echo "Usage $0: {on|off|sense}"
        exit 1
esac

