//
//  UIAppearance+Swift.h
//  Chameleon
//
//  Created by Vicc Alexander on 21317/06/27.
//  Copyright © 2015 Vicc Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewAppearance_Swift)

// @param containers An array of Class < UIAppearanceContainer >
// http://stackoverflow.com/a/28765193
+ (instancetype)appearanceWhenContainedWithin:(NSArray *)containers;

@end