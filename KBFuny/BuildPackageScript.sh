#!/bin/sh

#  BuildPackageScript.sh
#  KBFuny
#
#  Created by jinlb on 16/3/11.
#  Copyright © 2016年 jinlb. All rights reserved.

targetName="KBFuny"
# 第一步清理:
xcodebuild -target targetName clean
# 第二步编译：
xcodebuild -target targetName
# 第三步打包
# xcrun -sdk iphoneos PackageApplication -V path/