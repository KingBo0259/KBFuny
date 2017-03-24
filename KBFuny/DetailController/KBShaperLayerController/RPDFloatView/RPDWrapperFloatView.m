//
//  RPDWrapperFloatView.m
//  KBFuny
//
//  Created by jinlb on 2017/3/24.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import "RPDWrapperFloatView.h"


@implementation RPDWrapperFloatView{

    BOOL _autoHiddenFlag;
    NSTimeInterval _timeInterval;
    
    CGRect _originFrame;
    CGRect _endFrame;
}
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
                    FloatTime:(NSTimeInterval)timeInterval{
    if (self = [super initWithFrame:frame]) {
        _floatType  = floatType;
        _autoHiddenFlag = autoHide;
        _timeInterval = timeInterval;
        _isShow       = NO;
        
      }
    return self;
}

//绘制时才计算位置
-(void)layoutSubviews{
    [self caculateOriginAndEndFrame];
    self.frame = _originFrame;
}


/**
 计算起点位置
 */
-(void)caculateOriginAndEndFrame{
    CGFloat originX,originY,endX,endY,width,height,superViewWith,superViewHeight;
    width           = CGRectGetWidth(self.frame);
    height          = CGRectGetHeight(self.frame);
    superViewWith   = self.superview ? CGRectGetWidth(self.superview.frame): 0;
    superViewHeight = self.superview ? CGRectGetHeight(self.superview.frame) :0;
    switch (_floatType) {
        case RPDFLOAT_TYPE_LEFT_TOP:
        {
            originX = -width;
            originY = 0;
            endX    = 0;
            endY    = 0;
        }
            break;
        case RPDFLOAT_TYPE_LEFT_MID:{
            originX = -width;
            originY = superViewHeight/2.0;
            endX    = 0;
            endY    = originY;
        }
            break;
        case RPDFLOAT_TYPE_RIGHT_TOP:
        {
            originX =  superViewWith;
            originY = 0.0;
            endX    = superViewWith - width;
            endY    = originY;
        }
            break;
        case RPDFLOAT_TYPE_RIGHT_MID:{
            originX = superViewWith;
            originY = superViewHeight/2.0;
            endX    = superViewWith - width;
            endY    = originY;
        }
            break;
    }
    _originFrame = CGRectMake(originX, originY, width, height);
    _endFrame    = CGRectMake(endX, endY, width, height);
    
}
#pragma mark - method
- (void)show {
    if (_isShow) {
        return;
    }
    _isShow = YES;
    __weak typeof(&*self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.frame = _endFrame;
        
    } completion:^(BOOL finished) {
        if (_autoHiddenFlag) {
            [weakSelf performSelector:@selector(dismiss) withObject:nil afterDelay:_timeInterval];
        }
    }];
}

-(void)dismiss {
    if (_isShow == NO) {
        return;
    }
    _isShow = NO;
    __weak typeof(&*self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.frame = _originFrame;
    } completion:nil];
}
@end
