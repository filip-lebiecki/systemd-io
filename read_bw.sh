#!/bin/bash
/usr/bin/fio --ioengine=libaio --iodepth=64 --filename=/root/testfiobw.tmp --size=10G --direct=1 --bs=1M --rw=read --name=read_bw
