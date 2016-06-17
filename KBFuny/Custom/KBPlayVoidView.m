//
//  KBMessage.m
//  KBFuny
//
//  Created by jinlb on 15/4/4.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//


// device verson float value
#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]


// image STRETCH
#define KB_STRETCH_IMAGE(image, edgeInsets) (CURRENT_SYS_VERSION < 6.0 ? [image stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] : [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch])


#define MAX_LENGTH 200
#define MAX_SECOND 32
#define MIN_LENGTH 100

#import "KBPlayVoidView.h"

@implementation KBPlayVoidView

-(id)initWithSecond:(NSInteger)second withOriginal:(CGPoint)origin
{

    NSInteger width=MIN_LENGTH+(NSInteger)(MAX_LENGTH-MIN_LENGTH)*second/32;
    self=[self initWithFrame:CGRectMake(origin.x, origin.y, width, 40) withSecond:second];
    if (self) {
        
    }

    return self;
}

-(id)initWithFrame:(CGRect)frame withSecond:(NSInteger) second
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        
        
        //1、 按钮
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(0, 0, frame.size.width-40, frame.size.height);
        [button setBackgroundImage:[self createImage:@"weChatBubble_Receiving_Solid"] forState:UIControlStateNormal];
        [button setBackgroundImage:[self createImage:@"weChatBubble_Receiving_Cavern"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(playButtonClikc:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
        //2、ImgeView 实现动画
        UIImageView *animationView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _animationView=animationView;
        animationView.animationImages=[NSArray arrayWithObjects:[UIImage                imageNamed:@"ReceiverVoiceNodePlaying000"],
                                       [UIImage imageNamed:@"ReceiverVoiceNodePlaying001"],
                                       [UIImage imageNamed:@"ReceiverVoiceNodePlaying002"],
                                       [UIImage imageNamed:@"ReceiverVoiceNodePlaying003"],nil];
        animationView.animationDuration=1.5;
        animationView.animationRepeatCount=0;//repeat the animation forever;
        animationView.center=CGPointMake(30, frame.size.height/2);
        [self addSubview:animationView];
        start=false;

        animationView.hidden=YES;
        
        //3、默认图片
        UIImage *image=[UIImage imageNamed:@"ReceiverVoiceNodePlaying"];
         UIImageView *noPlayImageView=[[UIImageView alloc]  initWithImage:image];
          noPlayImageView.frame=animationView.frame;
          _noPlayImageView=noPlayImageView;
        
          [self addSubview:noPlayImageView];
        
        //4、时间几秒
        UILabel *secondsLable=[[UILabel alloc] initWithFrame:CGRectMake(button.frame.size.width+3, 0, 40, frame.size.height)];
        secondsLable.text=[NSString stringWithFormat:@"%li''",second];
        secondsLable.textColor=[UIColor grayColor];
        _secondLabel=secondsLable;
        [self addSubview:secondsLable];
        
    }
    
    return self;
}

-(void)playButtonClikc:(UIButton*)sender
{
    start=!start;
    
    if (start) {
        [_animationView startAnimating];
        _animationView.hidden=NO;
        _noPlayImageView.hidden=YES;
    }else
    {
        [_animationView stopAnimating];
        _animationView.hidden=YES;
        _noPlayImageView.hidden=NO;
    }

}


-(UIImage*)createImage:(NSString*)imgeName
{
    NSString *messageTypeString=imgeName;

    UIImage *bublleImage = [UIImage imageNamed:messageTypeString];
    UIEdgeInsets bubbleImageEdgeInsets = UIEdgeInsetsMake(30, 28, 85, 28);;

    return KB_STRETCH_IMAGE(bublleImage, bubbleImageEdgeInsets);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
