check_snmp_zpool Plugin for Icinga

You can "install" this plugin by placing it anywhere you want. If you use the nagios-plugins, the best place might be at /usr/lib/nagios/plugins/ 

Make sure the Plugin is executeable: chmod +x check_snmp_zpool

Add to your snmpd.conf on the remotehost:
extend zfs_getdisk /scripts/zpool.sh

Script in /scripts/zpool.sh:

###############################

#!/bin/sh

ZPOOL=`/sbin/zpool list | tr -s ' ' | sed 1d | sed 2d`

echo $ZPOOL

###############################

I might edit the whole script to be dynamic later -> grep for a specific pool
