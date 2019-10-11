#!/bin/bash
source input

LAST_ONE=$(echo $REGION_LIST | awk '{print $NF}')

test -f export-ss.json && rm export-ss.json
cat > export-ss.json <<ABC
{
  "random" : false,
  "authPass" : null,
  "useOnlinePac" : false,
  "TTL" : 0,
  "global" : false,
  "reconnectTimes" : 3,
  "index" : 0,
  "proxyType" : 0,
  "proxyHost" : null,
  "authUser" : null,
  "proxyAuthPass" : null,
  "isDefault" : false,
  "pacUrl" : null,
  "configs" : [
ABC




for i in $REGION_LIST
do
   IP=$(terraform output | grep $i -A1 | tail -1 | cut -d\" -f2)
   if [ "$i" == "$LAST_ONE" ]
     then
cat >> export-ss.json <<MMM
    {
      "enable" : true,
      "password" : "$SS_PASSWORD",
      "method" : "aes-256-cfb",
      "remarks" : "AWS-$i",
      "server" : "$IP",
      "obfs" : "plain",
      "protocol" : "origin",
      "server_port" : 443,
      "remarks_base64" : "QVdTLUtPLTE="
    }
MMM
     else
cat >> export-ss.json <<TTT
    {
      "enable" : true,
      "password" : "$SS_PASSWORD",
      "method" : "aes-256-cfb",
      "remarks" : "AWS-$i",
      "server" : "$IP",
      "obfs" : "plain",
      "protocol" : "origin",
      "server_port" : 443,
      "remarks_base64" : "QVdTLUtPLTE="
    },
TTT
  fi
done

cat >> export-ss.json <<XYZ
  ],
  "proxyPort" : 0,
  "randomAlgorithm" : 0,
  "proxyEnable" : false,
  "enabled" : true,
  "autoban" : false,
  "proxyAuthUser" : null,
  "shareOverLan" : false,
  "localPort" : 1080
}
XYZ
