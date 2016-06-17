//
//  UIImage+KBImage.m
//  KBFuny
//
//  Created by jinlb on 15/11/21.
//  Copyright © 2015年 jinlb. All rights reserved.
//

#import "UIImage+KBImage.h"

@implementation UIImage (KBImage)
+(UIImage*)renderImageWithColor:(UIColor*)color inSize:(CGSize)size{

    
    CGRect rect=  CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;

}
@end
