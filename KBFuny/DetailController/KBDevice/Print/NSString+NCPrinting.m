//
//  NSString+NCPrinting.m
//  (c) 2014 Nate Cook, licensed under the MIT License
//

#import "NSString+NCPrinting.h"

@implementation NSString (NCPrinting)

- (void)drawAtPointInRect:(CGRect)rect withAttributes:(NSDictionary *)attrs andAlignment:(NCStringAlignment)alignment {
    CGSize size = [self sizeWithAttributes:attrs];
    CGFloat x, y;
    
    // x position
    switch (alignment) {
        case NCStringAlignmentLeftTop:
        case NCStringAlignmentLeftCenter:
        case NCStringAlignmentLeftBottom:
            x = CGRectGetMinX(rect); break;
        case NCStringAlignmentCenterTop:
        case NCStringAlignmentCenter:
        case NCStringAlignmentCenterBottom:
            x = CGRectGetMidX(rect) - size.width / 2; break;
        case NCStringAlignmentRightTop:
        case NCStringAlignmentRightCenter:
        case NCStringAlignmentRightBottom:
            x = CGRectGetMaxX(rect) - size.width; break;
    }
    
    // y position
    switch (alignment) {
        case NCStringAlignmentLeftTop:
        case NCStringAlignmentCenterTop:
        case NCStringAlignmentRightTop:
            y = CGRectGetMinY(rect); break;
        case NCStringAlignmentLeftCenter:
        case NCStringAlignmentCenter:
        case NCStringAlignmentRightCenter:
            y = CGRectGetMidY(rect) - size.height / 2; break;
        case NCStringAlignmentLeftBottom:
        case NCStringAlignmentCenterBottom:
        case NCStringAlignmentRightBottom:
            y = CGRectGetMaxY(rect) - size.height; break;
    }
    
    [self drawAtPoint:CGPointMake(x, y) withAttributes:attrs];
}

@end
