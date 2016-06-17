//
//  KTMSAutoSearchDataView.h
//  KBFuny
//
//  Created by jinlb on 16/5/13.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString * const detailConstStant;

@class KTMSAutoSearchDataView;


@protocol KTMSAutoSearchDataDelegate <NSObject>

-(void)searchView:(KTMSAutoSearchDataView*)searchView didSelectRow:(NSString*)selectRow;

@end

@interface KTMSAutoSearchDataView : UIView

@property(nonatomic,weak) id<KTMSAutoSearchDataDelegate> delegate;

//
-(instancetype)initWithPosition:(CGPoint)position inParentView:(UIView*)parentView;
-(instancetype)initWithPosition:(CGPoint)position width:(CGFloat)width inParentView:(UIView*)parentView;

-(void)setViewPosition:(CGPoint)position;

-(void)showWithSearchKey:(NSString*)searchKey;
//-(void)searchWithKey:(NSString*)key;
-(void)hide;


@end
