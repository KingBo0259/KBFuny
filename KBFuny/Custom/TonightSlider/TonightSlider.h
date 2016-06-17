//
//  TonightSlider.h
//  slider
//
//  Created by apple on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TonightSliderDelegate <NSObject>

-(void)tonightSliderFinished;

@end

@interface TonightSlider : UIView
{
    UIImageView* imageViewbg;
    UISlider* slider;
    UILabel* label;
    
}

@property (nonatomic,retain) id<TonightSliderDelegate> delegate;
@property (nonatomic,retain) UILabel* label;
@property (nonatomic,retain) UISlider* slider;

-(void)tonightSliderValueChanged:(id)tonightSlider;
-(void)setBackgroundImage:(UIImage*)imagebg;
-(void)setSliderBlockImage:(UIImage*)imageBlock;
-(void)tonightSliderTouchUpInside:(id)tonightSlider;

@end



