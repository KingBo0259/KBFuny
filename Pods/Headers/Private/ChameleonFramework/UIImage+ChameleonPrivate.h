//
//  UIImage+ChameleonPrivate.h
//  Chameleon
//
//  Created by Vicc Alexander on 17/06/27.
//  Copyright (c) 2015 Vicc Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ChameleonPrivate)

#pragma mark - Class Methods

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

#pragma mark - Instance Methods

- (UIImage *)imageScaledToSize:(CGSize)newSize;

@end
