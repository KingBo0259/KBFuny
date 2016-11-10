//
//  NSString+NCPrinting.h
//  (c) 2014 Nate Cook, licensed under the MIT License
//

#import <UIKit/UIKit.h>

// The alignment for drawing an NSString inside a bounding rectangle.
typedef NS_ENUM(NSInteger, NCStringAlignment) {
    NCStringAlignmentLeftTop,
    NCStringAlignmentCenterTop,
    NCStringAlignmentRightTop,
    NCStringAlignmentLeftCenter,
    NCStringAlignmentCenter,
    NCStringAlignmentRightCenter,
    NCStringAlignmentLeftBottom,
    NCStringAlignmentCenterBottom,
    NCStringAlignmentRightBottom
};

@interface NSString (NCPrinting)

// Draw the `NSString` inside the bounding rectangle with a given alignment.
- (void)drawAtPointInRect:(CGRect)rect withAttributes:(NSDictionary *)attrs andAlignment:(NCStringAlignment)alignment;

@end
