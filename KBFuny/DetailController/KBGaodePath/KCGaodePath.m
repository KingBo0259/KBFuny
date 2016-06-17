//
//  KCGaodePath.m
//  kuaihuoyun
//
//  Created by jinlb on 15/6/17.
//  Copyright (c) 2015年 banyanan. All rights reserved.
//

#import "KCGaodePath.h"


@implementation KCGaodePath
@synthesize search=_search;



- (void)clearSearch
{
    self.search.delegate = nil;
}

- (void)initSearch
{
    self.search.delegate = self;
}


-(void)getDriveDistanceWithStartPoint:(KCLocationRequest*)startPoint
                         withEndPoint:(KCLocationRequest*)endPoint
                     withSuccessBolck:(GaodePathBlock)block
                        withErorBlock:(void(^)(NSString* errorString)) errorBlock{

    _block=block;
    
    
    AMapNavigationSearchRequest *navi = [[AMapNavigationSearchRequest alloc] init];
    navi.searchType       = AMapSearchType_NaviDrive;
    navi.requireExtension = YES;
    navi.avoidpolygons=nil; //设置禁区
        /* 出发点. */
    navi.origin = [AMapGeoPoint locationWithLatitude:startPoint.lat
                                               longitude:startPoint.lng];
        /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:endPoint.lat
                                                    longitude:startPoint.lng];
    
    [self.search AMapNavigationSearch:navi];
}

//计算多点的导航距离
-(void)getDriveDistanceWithPointArray:(NSMutableArray*)pointArray
                     withSuccessBolck:(GaodePathBlock)block
                        withErorBlock:(void(^)(NSString* errorString)) errorBlock{


    
}


/* 驾车导航搜索. */
- (void)searchNaviDrive
{
    AMapNavigationSearchRequest *navi = [[AMapNavigationSearchRequest alloc] init];
    navi.searchType       = AMapSearchType_NaviDrive;
    navi.requireExtension = YES;
    navi.avoidpolygons=nil; //设置禁区
//    /* 出发点. */
//    navi.origin = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude
//                                           longitude:self.startCoordinate.longitude];
//    /* 目的地. */
//    navi.destination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude
//                                                longitude:self.destinationCoordinate.longitude];
//    
    [self.search AMapNavigationSearch:navi];
}

#pragma mark - AMapSearchDelegate

-(void)onNavigationSearchDone:(AMapNavigationSearchRequest *)request response:(AMapNavigationSearchResponse *)response{
    NSLog(@"%@",response);
}
- (void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"%s: searchRequest = %@, errInfo= %@", __func__, [request class], error);
}
@end
