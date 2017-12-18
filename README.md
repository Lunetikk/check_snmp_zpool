check_snmp_zpool Plugin for Icinga

You can "install" this plugin by placing it anywhere you want. If you use the nagios-plugins, the best place might be at /usr/lib/nagios/plugins/ 

Make sure the Plugin is executeable: chmod +x check_snmp_zpool

Add to your snmpd.conf on the remotehost:
extend zfs_getdisk /scripts/zpool.sh

Add zpool.sh to /scripts/zpool.sh or edit the path in your snmpd.conf

I might edit the whole script to be dynamic later -> grep for a specific pool
