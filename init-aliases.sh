#!/bin/bash

ifconfig ${2} ${1}.48 netmask 255.255.255.0
ifconfig ${2}:0 ${1}.49
ifconfig ${2}:1 ${1}.50
ifconfig ${2}:2 ${1}.51
ifconfig ${2}:3 ${1}.53

