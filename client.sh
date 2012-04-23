#!/bin/bash

ip=$1
port1=10001
myip=`echo 1.3.4`
port2=`echo $myip | nc $ip $port1`
echo type "'usage'" to view your options
nc $ip $port2
