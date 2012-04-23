#!/bin/bash

if [ ! $DECAL ] ; then # first time script is executed in a session
    export DECAL=true # makes the above test work
    export DECALPORT=10002 # further connections will start here
fi
kill `lsof -i :$DECALPORT | tail -n +2 | sed -e 's,[ \t][ \t]*, ,g' | cut -f2 -d' '` 2>/dev/null # clears junk on DECALPORT
\rm ~/aber/pipe 2>/dev/null; mknod ~/aber/pipe p && nc -l $DECALPORT 0<~/aber/pipe | ./execute-commands.sh 1>~/aber/pipe & # space for one user connection
kill `lsof -i :10001 | tail -n +2 | sed -e 's,[ \t][ \t]*, ,g' | cut -f2 -d' '` 2>/dev/null # clears junk on port 10001
clientresp=`echo $DECALPORT | nc -l 10001` #wait for more users
export DECALPORT=$(expr $DECALPORT + 1) # further users will go on higher ports
if [ $clientresp ]; then
    $0
fi