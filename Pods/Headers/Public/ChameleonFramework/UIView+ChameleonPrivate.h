//
//  UIView+ChameleonPrivate.h
//  Chameleon
//
//  Created by Vicc Alexander on 17/06/27.
//  Copyright (c) 2015 Vicc Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ChameleonPrivate)

- (BOOL)isTopViewInWindow;
- (UIView *)findTopMostViewForPoint:(CGPoint)point;

@end
