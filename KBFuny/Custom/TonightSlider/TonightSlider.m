//
//  TonightSlider.m
//  slider
//
//  Created by apple on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TonightSlider.h"

@implementation TonightSlider

@synthesize label,slider,delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        imageViewbg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:imageViewbg];
        [imageViewbg release];
        
        label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        label.backgroundColor=[UIColor clearColor];
        label.text=@"欢迎光临";
        label.textAlignment=UITextAlignmentCenter;
        [self addSubview:label];
        [label release];
        
        slider=[[UISlider alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        slider.backgroundColor=[UIColor clearColor];
        slider.maximumValue=1.0f;
        slider.minimumValue=0.0f;
        [slider setBackgroundColor:[UIColor clearColor]];
        [slider setMinimumTrackImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [slider setMaximumTrackImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [self addSubview:slider];
        [slider release];
        
        [slider addTarget:self action:@selector(tonightSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [slider addTarget:self action:@selector(tonightSliderTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)tonightSliderTouchUpInside:(id)tonightSlider
{
    UISlider* s=(UISlider*)tonightSlider;
    if(s.value!=s.maximumValue)
    {
        [s setValue:0 animated:YES];
        label.alpha=1.0f;
    }
    else
    {
        [delegate tonightSliderFinished];
    }
}

-(void)tonightSliderValueChanged:(id)tonightSlider
{
    UISlider* s=(UISlider*)tonightSlider;
    float value=s.value;
    label.alpha=s.maximumValue*0.7f-value;
}

-(void)setBackgroundImage:(UIImage *)imagebg
{
    imageViewbg.image=imagebg;
}

-(void)setSliderBlockImage:(UIImage *)imageBlock
{
    [slider setThumbImage:imageBlock forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
