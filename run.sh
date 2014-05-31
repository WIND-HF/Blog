#!/bin/bash
if [[ -z $1 ]]; then
    port=3000
else
    port=$1
fi

./getAddr.rb | { read ipAddr; rails server -b $ipAddr -p $port ; }
