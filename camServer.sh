#!/bin/bash
ipBroadcast(){
        echo "Starting broadcast"
        while true; do
                IP=$(hostname -I |  grep -E -o '([0-9]{1,3}[\.]){3}[0-9]{1,3}')
                echo -n "$IP 5801"   | socat - udp-datagram:255.255.255.255:5800,broadcast;
                sleep 1;
        done
}

ipBroadcast &

while true; do
        until raspivid -l -o tcp://0.0.0.0:5801 -t 999999 -w 1280 -h 720 -fps 24 --ISO 800 -md 5 --profile high --imxfx blur --colfx 128:128 -b 2500000 -fl -ex                                   off -ss 10000 --analoggain 12.0 -vf --nopreview; do
                echo "Camserver Crashed and exited with code $?. Respawning...">&2
                sleep 1
        done
        echo "Camserver exited cleanly but we want it to keep running"
        sleep 1
done
