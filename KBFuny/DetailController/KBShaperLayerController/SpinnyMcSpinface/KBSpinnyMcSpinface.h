//
//  KBSpinnyMcSpinface.h
//  KBFuny
//
//  Created by jinlb on 2017/7/13.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

//测试都用 CALayer ，最后运行时使用 CATransformLayer 实现内部试图3D效果
@interface KBSpinnyMcSpinface : CATransformLayer
-(instancetype)initWithNumberOfItems:(NSUInteger)number ;

-(void)startAnimation;
@end
