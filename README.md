# check_snmp_zpool Plugin for Icinga

You can "install" this plugin by placing it anywhere you want. If you use the nagios-plugins, the best place might be at /usr/lib/nagios/plugins/ 

***Make sure the Plugin is executeable:***

```chmod +x check_snmp_zpool```

***Add to your snmpd.conf on the remotehost:***

```extend zfs_getdisk /scripts/zpool.sh```

Add zpool.sh to /scripts/zpool.sh or edit the path in your snmpd.conf

***Possible CheckCommand***

```
object CheckCommand "check_snmp_zpool" {

  import "plugin-check-command"
  command = ["/usr/lib/nagios/plugins/check_snmp_zpool.sh"]
  arguments = {
        "-H" = "$address$"
        "-c" = "$community$"
  }

}
```

***Possible Service***

```
apply Service "snmpzpool" for (procs_name => config in host.vars.snmpzpool) {

  import "generic-service"
  display_name = "SNMP ZPOOL"
  check_command = "check_snmp_zpool"

  vars.sla = host.vars.sla

  vars += config
  vars.address = string(vars.address)
  vars.community = string(vars.community)
  vars.alarm = string(vars.alarm)


  assign where match("*zpool*", host.vars.services)
}
```

***Possible Host***

```
vars.services = "zpool"

vars.snmpzpool["0"] = {

	address = "10.xxx.xxx.xxx"
	community = "<COMMUNITYSTRING>"
  alarm = "no"
}
```

I might edit the whole script to be dynamic later -> grep for a specific pool
