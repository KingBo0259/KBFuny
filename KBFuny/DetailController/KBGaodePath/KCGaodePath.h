//
//  KCGaodePath.h
//  kuaihuoyun
//
//  Created by jinlb on 15/6/17.
//  Copyright (c) 2015年 banyanan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "KCAddressRequest.h"


/*
 *  distance : 总距离
 *  heightWayDistance : 高速距离
 *
 */
typedef void(^GaodePathBlock)(id path,int distance,int heightWayDistance);


@interface KCGaodePath : NSObject<AMapSearchDelegate>
{
    AMapSearchAPI *_search;
    GaodePathBlock _block;
}

@property (nonatomic, strong) AMapSearchAPI *search;



//计算两点纬度车辆导航距离
-(void)getDriveDistanceWithStartPoint:(KCLocationRequest*)startPoint
                         withEndPoint:(KCLocationRequest*)endPoint
                     withSuccessBolck:(GaodePathBlock)block
                        withErorBlock:(void(^)(NSString* errorString)) errorBlock;
//计算多点的导航距离
-(void)getDriveDistanceWithPointArray:(NSMutableArray*)pointArray
                     withSuccessBolck:(GaodePathBlock)block
                        withErorBlock:(void(^)(NSString* errorString)) errorBlock;
@end
