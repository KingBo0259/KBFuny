//
//  KBCALayerFactory.h
//  KBFuny
//
//  Created by jinlb on 16/7/12.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBCALayerFactory : NSObject

/**
 *  创建自定义shaperLayer  代尖头遮罩效果 
 *
 *  @param view 父view
 *
 *  @return CAShaperLayer
 */
+(CAShapeLayer*)createShaperWithView:(UIView*)view;

@end
