//
//  RPDWrapperFloatView.h
//  KBFuny
//
//  Created by jinlb on 2017/3/24.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^RRDFloatViewBlock)(id sender);


typedef NS_ENUM(NSUInteger, RPDFLOAT_TYPE) {
    RPDFLOAT_TYPE_LEFT_TOP=0,//左上
    RPDFLOAT_TYPE_LEFT_MID,//左中
    RPDFLOAT_TYPE_RIGHT_TOP,//右上
    RPDFLOAT_TYPE_RIGHT_MID //右中
};

@interface RPDWrapperFloatView : UIView

#pragma mark - init


/**
 初始化

 @param frame  frame
 @param floatType 悬浮位置
 @param autoHiden 是否自动隐藏
 @param timeInterval 自定隐藏时间
 @return RPDWrapperFloatView
 */
-(instancetype)initWithFrame:(CGRect)frame
                        Type:(RPDFLOAT_TYPE)floatType
           andAutoHiddenFlag:(BOOL)autoHide
                   FloatTime:(NSTimeInterval)timeInterval;

#pragma mark - property
@property(nonatomic,assign) RPDFLOAT_TYPE floatType;
@property(nonatomic,assign,readonly,getter=isShow) BOOL isShow;

#pragma mark - method
//显示
- (void)show;

//隐藏
- (void)dismiss;
@end
