//
//  KBGradientCircle.h
//  KBFuny
//
//  Created by jinlb on 15/5/4.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBGradientCircleView : UIView{

    CGPoint _centerPoint;
    CGFloat _radius;
    CGFloat _r,_g,_b;//颜色的RGB值
}

-(id)initWithFrame:(CGRect)frame
        withRadius:(CGFloat)radius
         withColor:(UIColor*)color;


@property (nonatomic,assign)CGFloat colorAlpha;
@end
