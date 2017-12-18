#!/bin/sh

ZPOOL=/sbin/zpool list | tr -s ' ' | sed 1d | sed 2d

echo $ZPOOL
