#!/bin/bash

./getAddr.rb | { read ipAddr; rails server -b $ipAddr ; }
