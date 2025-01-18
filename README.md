[Youtube Video](https://youtu.be/N7mGchZkHGQ?si=6A3ZMB3roUiGNzHa)

# systemd-io

### Bandwidth

```
vi read_iops.sh
#!/bin/bash
/usr/bin/fio --ioengine=libaio --iodepth=64 --filename=/root/testfiobw.tmp --size=10G --direct=1 --bs=1M --rw=read --name=read_bw

chmod +x read_bw.sh
./read_bw.sh
```

```
systemctl edit --force --full read_bw.service

[Unit]
Description=Disk bandwidth
[Service]
ExecStart=/root/read_bw.sh

systemctl daemon-reload
systemctl start read_bw
journalctl -u read_bw
```

```
df testfiobw.tmp
systemctl edit --force --full read_bw.service
IOAccounting=yes
IOReadBandwidthMax=/dev/nvme0n1 100M
systemctl daemon-reload
systemctl start read_bw
watch -n1 systemctl status read_bw
```

### IOPS

```
vi read_iops.sh

#!/bin/bash
/usr/bin/fio --ioengine=libaio --iodepth=64 --filename=/root/testfioiops.tmp --size=1G --direct=1 --bs=4k --rw=randread --name=read_iops
./read_iops.sh

systemctl cat io_parent.slice
systemctl cat read_iops


```

### Transient units

```
systemd-run --scope -p "IOReadIOPSMax=/dev/nvme0n1 1000" -p "MemoryMax=1G"  -p "CPUQuota=100%" -p "IOAccounting=yes" ./read_iops.sh
systemctl status run-r5f2fb3c63f6e4f1ebc00695ca9651fdd.scope
systemd-run -p "IOReadIOPSMax=/dev/nvme0n1 1000" -p "MemoryMax=1G"  -p "CPUQuota=100%" -p "IOAccounting=yes" ./read_iops.sh
watch -n1 systemctl status run-rf62fe415be83499d909c285ef3c7228f.service
journalctl -u run-rf62fe415be83499d909c285ef3c7228f.service
```


