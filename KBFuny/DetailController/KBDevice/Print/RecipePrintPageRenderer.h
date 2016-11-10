//
//  RecipePrintPageRenderer.h
//  (c) 2014 Nate Cook, licensed under the MIT License
//

#import <UIKit/UIKit.h>

#define POINTS_PER_INCH 72

@class Recipe;

@interface RecipePrintPageRenderer : UIPrintPageRenderer

@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, weak) Recipe *recipe;

- (id)initWithAuthorName:(NSString *)authorName recipe:(Recipe *)recipe;

@end


@interface Recipe : NSObject
@property(nonatomic,copy)NSString *html;
@property(nonatomic,strong)NSArray*images;

@end

