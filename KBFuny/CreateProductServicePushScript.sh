#!/bin/sh

#  CreateServicePushScript.sh
#  KBFuny
#
#  Created by jinlb on 16/7/26.
#  Copyright © 2016年 jinlb. All rights reserved.

#指定到指定的文件目录
cd /Users/jinlb/Desktop/快货运iOS证书/kuaihuoyunTMS证书

#1、将aps_developer_identity.cer转换成aps_developer_identity.pem格式
openssl x509 -in aps_production.cer -inform DER -out aps_production_identity.pem -outform PEM 

#2、将p12格式的私钥转换成pem
openssl pkcs12 -nocerts -out apple_push_notification_production.pem -in aps_production.p12  
#3、创建服务器端p12文件
 openssl pkcs12 -export -in aps_production_identity.pem -inkey apple_push_notification_production.pem -certfile Push.certSigningRequest -name "aps_production_identity" -out aps_production_identity.p12 