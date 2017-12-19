#!/bin/sh
#
# Check zpools
# by Lunetikk
##########################################################

#Usage: check_snmp_zpool -H <HOSTNAME/IP> -c <COMMUNITYSTRING>
#
#Options:
# -H <HOSTNAME/IP>              = Server Hostname/IP
# -c <COMMUNITYSTRING>          = Communitystring
# -h                            = This help

ARG1="$2"
ARG2="$4"

case "$1" in
-H)

SNMPGET=`snmpget -v1 -c $ARG2 $ARG1 NET-SNMP-EXTEND-MIB::nsExtendOutputFull.\"zfs_getdisk\"`


TANK=`echo $SNMPGET | cut -d '=' -f 2`

TANKNAME=`echo $TANK | cut -d ' ' -f 2`
TANKSIZE=`echo $TANK | cut -d ' ' -f 3`
TANKALLOC=`echo $TANK | cut -d ' ' -f 4`
TANKFREE=`echo $TANK | cut -d ' ' -f 5`
TANKCAP=`echo $TANK | cut -d ' ' -f 6`
TANKCAPNR=`echo $TANKCAP | cut -d '%' -f 1`
TANKHEALTH=`echo $TANK | cut -d ' ' -f 8`

if [ $TANKHEALTH = "ONLINE" ]
then
        if [ $TANKCAPNR -gt 90 ]
        then
                echo "$TANKNAME: Speicherplatz bald voll! - STATUS ONLINE - SIZE: $TANKSIZE, ALLOC: $TANKALLOC, FREE: $TANKFREE, CAP: $TANKCAP"
                exit 2
        else
                echo "$TANKNAME: STATUS ONLINE - SIZE: $TANKSIZE, ALLOC: $TANKALLOC, FREE: $TANKFREE, CAP: $TANKCAP"
                exit 0
        fi
else
        echo "$TANKNAME: STATUS $TANKHEALTH"
        exit 2
fi

;;

*)
echo "Usage: check_snmp_zpool -H <HOSTNAME/IP> -c <COMMUNITYSTRING>"
echo ""
echo "Options:"
echo " -H <HOSTNAME/IP>         = Server Hostname/IP"
echo " -c <COMMUNITYSTRING>             = Communitystring"
echo " -h                               = This help"

;;
esac
