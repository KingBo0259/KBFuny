//
//  RecipePrintPageRenderer.m
//  (c) 2014 Nate Cook, licensed under the MIT License
//

#import "RecipePrintPageRenderer.h"
#import "NSString+NCPrinting.h"
#import <AVFoundation/AVFoundation.h>

@interface RecipePrintPageRenderer ()

@property (nonatomic, strong) NSDictionary *pageNumberAttributes;
@property (nonatomic, strong) NSDictionary *nameAttributes;

@end

@implementation RecipePrintPageRenderer

- (id)initWithAuthorName:(NSString *)authorName recipe:(Recipe *)recipe {
    if (self = [super init]) {
        self.authorName = authorName;
        self.recipe = recipe;
        
        self.headerHeight = 0.5;
        
        self.pageNumberAttributes = @{ NSFontAttributeName : [UIFont fontWithName:@"Georgia-Italic" size: 11] };
        self.nameAttributes       = @{ NSFontAttributeName : [UIFont fontWithName:@"Georgia" size: 11] };
        
        // create formatter with the recipe's HTML text
        // per page insets should be one-inch, with 3.5 inches on the right to make room for photos
        UIMarkupTextPrintFormatter *formatter = [[UIMarkupTextPrintFormatter alloc] initWithMarkupText:recipe.html];
        formatter.perPageContentInsets = UIEdgeInsetsMake(POINTS_PER_INCH, POINTS_PER_INCH, POINTS_PER_INCH, POINTS_PER_INCH * 3.5);
        [self addPrintFormatter:formatter startingAtPageAtIndex:0];
    }
    return self;
}

- (void)drawHeaderForPageAtIndex:(NSInteger)index inRect:(CGRect)headerRect {
    UIEdgeInsets headerInsets = UIEdgeInsetsMake(CGRectGetMinY(headerRect), POINTS_PER_INCH, CGRectGetMaxY(self.paperRect) - CGRectGetMaxY(headerRect), POINTS_PER_INCH);
    headerRect = UIEdgeInsetsInsetRect(self.paperRect, headerInsets);
    
    // author name on left
    [self.authorName drawAtPointInRect:headerRect withAttributes:self.nameAttributes andAlignment:NCStringAlignmentLeftCenter];
    
    // page number on right
    NSString *pageNumberString = [NSString stringWithFormat:@"%ld", index + 1];
    [pageNumberString drawAtPointInRect:headerRect withAttributes:self.pageNumberAttributes andAlignment:NCStringAlignmentRightCenter];
}

- (void)drawImages:(NSArray *)images inRect:(CGRect)sourceRect {
    // we'll use 1/8 of an inch of vertical padding between each image
    UIEdgeInsets imagePadding = UIEdgeInsetsMake(POINTS_PER_INCH / 8, 0, 0, 0);
    
    for (UIImage *image in images) {
        // get the aspect-fit size of the image
        CGRect sizedRect = AVMakeRectWithAspectRatioInsideRect(image.size, sourceRect);
        
        // if the new width of the image doesn't match the source rect, there wasn't enough vertical room: bail
        if (CGRectGetWidth(sizedRect) != CGRectGetWidth(sourceRect)) {
            return;
        }
        
        // use divide to separate the image rect from the rest of the column
        CGRectDivide(sourceRect, &sizedRect, &sourceRect, CGRectGetHeight(sizedRect), CGRectMinYEdge);
        
        // draw the image
        [image drawInRect:sizedRect];
        
        // inset the source rect to make a little padding before the next image
        sourceRect = UIEdgeInsetsInsetRect(sourceRect, imagePadding);
    }
}

- (void)drawContentForPageAtIndex:(NSInteger)pageIndex inRect:(CGRect)contentRect {
    if (pageIndex == 0) {
        // only use rightmost two inches of contentRect
        CGFloat imagesRectWidth = POINTS_PER_INCH * 2;
        CGFloat imagesRectHeight = CGRectGetHeight(self.paperRect) - POINTS_PER_INCH - (CGRectGetMaxY(self.paperRect) - CGRectGetMaxY(contentRect));
        CGRect imagesRect = CGRectMake(CGRectGetMaxX(self.paperRect) - imagesRectWidth - POINTS_PER_INCH, CGRectGetMinY(self.paperRect) + POINTS_PER_INCH, imagesRectWidth, imagesRectHeight);
        
        [self drawImages:self.recipe.images inRect:imagesRect];
    }
}

@end


@implementation Recipe



@end
