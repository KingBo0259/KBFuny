//
//  KBFadeString.m
//  KBFuny
//
//  Created by jinlb on 2017/2/14.
//  Copyright © 2017年 jinlb. All rights reserved.
//


#import "KBFadeString.h"

@interface KBFadeString()
@property(nonatomic , strong) UILabel *label;
@property(nonatomic, strong) UIView   *mask ; //遮罩的mask
@end

@implementation KBFadeString
@synthesize text = _text;


-(instancetype)initWithFrame:(CGRect)frame{


    if (self = [ super initWithFrame:frame]) {
        [self createLable:self.bounds];
        [self createMask:CGRectMake(0, 0, frame.size.width/3, frame.size.height)];
        [self createCADisplayLink];
        
    }
    return self;
    
}

-(void)createCADisplayLink{

   CADisplayLink * _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(autoDisplay)];
    _displayLink.paused = NO;
    //一定要添加到 主runloop 里面
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];


}

-(void)createLable:(CGRect)frame{

    self.label = [[UILabel alloc] initWithFrame:frame];
    self.label.font = [UIFont systemFontOfSize:30.0f];
    self.label.textColor = [UIColor flatPinkColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label];

}

-(void)createMask:(CGRect) frame{

    //创建出渐变的layer
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame             = frame;
    gradientLayer.colors            = @[(__bridge id)[UIColor clearColor].CGColor,(__bridge id)[UIColor flatPurpleColor].CGColor,(__bridge id)[UIColor clearColor].CGColor];
    gradientLayer.locations         = @[@(0.01),@(0.1),@(0.9),@(0.99)];
    gradientLayer.startPoint        = CGPointMake(0, 0);
    gradientLayer.endPoint          = CGPointMake(1, 0);
    
    //创建并接管mask
    self.mask  = [[UIView alloc] initWithFrame:frame];
    //mask 获取渐变layer
    [self.mask.layer addSublayer:gradientLayer];
    
    //maskView 只会补货Alph值，颜色无效
    self.maskView = self.mask;
//    self.layer.mask = self.mask.layer;

}


-(void)setText:(NSString *)text{

    _text = text;
    self.label.text = text;

}

-(NSString*)text{

    return _text;
}

-(void)autoDisplay{

    
//    [UIView animateWithDuration:3.0f animations:^{
        CGRect frame = self.mask.frame;
        frame.origin.x += 2;

        if (frame.origin.x >= 320) {
            frame.origin.x = 0;
        }
        self.mask.frame = frame;
//    }];
    
}
-(void)fadeRight{

    [UIView animateWithDuration:3.0f animations:^{
        CGRect frame = self.mask.frame;
        frame.origin.x += frame.size.width;
        self.mask.frame = frame;
        
        
    }];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
