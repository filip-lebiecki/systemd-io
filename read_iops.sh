#!/bin/bash
/usr/bin/fio --ioengine=libaio --iodepth=64 --filename=/root/testfioiops.tmp --size=1G --direct=1 --bs=4k --rw=randread --name=read_iops
