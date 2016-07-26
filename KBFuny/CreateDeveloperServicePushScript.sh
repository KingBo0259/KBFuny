#!/bin/sh

#  CreateServicePushScript.sh
#  KBFuny
#
#  Created by jinlb on 16/7/26.
#  Copyright © 2016年 jinlb. All rights reserved.

#指定到指定的文件目录
cd /Users/jinlb/Desktop/快货运iOS证书/kuaihuoyunTMS证书


#1、将aps_developer_identity.cer转换成aps_developer_identity.pem格式
openssl x509 -in aps_development.cer -inform DER -out aps_development_identity.pem -outform PEM

#2、将p12格式的私钥转换成pem
openssl pkcs12 -nocerts -out apple_push_notification_development.pem -in aps_development.p12
#3、创建服务器端p12文件
openssl pkcs12 -export -in aps_development_identity.pem -inkey apple_push_notification_development.pem -certfile Push.certSigningRequest -name "aps_deleopment_identity" -out aps_development_identity.p12