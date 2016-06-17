//
//  KBPopoerView.m
//  KBFuny
//
//  Created by jinlb on 15/6/30.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import "KBPopoverView.h"


// image STRETCH
#define STRETCH_IMAGE(image, edgeInsets) (CURRENT_SYS_VERSION < 6.0 ? [image stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] : [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch])



@implementation KBPopoverView



-(id)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
     


        CGPoint anchorPoint=CGPointMake(0.9, 0);
    
        NSInteger moveX=frame.size.width*(anchorPoint.x-0.5);
        NSInteger moveY=frame.size.height*(anchorPoint.y-0.5);
        _contextView=[[UIView alloc]initWithFrame:CGRectMake(frame.origin.x+moveX, frame.origin.y+moveY
                                                             , frame.size.width, frame.size.height)];
        _contextView.backgroundColor =[UIColor clearColor];
        _contextView.layer.anchorPoint=anchorPoint;

        
      UIImageView *imageview=[[UIImageView alloc] initWithImage:  [self createImage:@"popover"]];
        imageview.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
        imageview.layer.shadowColor=[UIColor blackColor].CGColor;
        imageview.layer.shadowOffset=CGSizeMake(0, 0);
        imageview.layer.shadowRadius=20;
        imageview.layer.shadowOpacity=0.5;
        [_contextView addSubview:imageview];
        
        
        [self addSubview:_contextView];
    }
    return self;
}

-(UIImage*)createImage:(NSString*)imgeName
{
    NSString *messageTypeString=imgeName;
    
    UIImage *bublleImage = [UIImage imageNamed:messageTypeString];
    UIEdgeInsets bubbleImageEdgeInsets = UIEdgeInsetsMake(26, 10, 10, 50);
    return   [bublleImage resizableImageWithCapInsets:bubbleImageEdgeInsets resizingMode:UIImageResizingModeStretch];
}


+(KBPopoverView*)showPopoverWithFrame:(CGRect)frame
                     WithContextView:(UIView*)contextView{
    KBPopoverView *popoverView = [[KBPopoverView alloc] initWithFrame:frame];
    if (popoverView.contextView) {
       [popoverView. contextView addSubview:contextView];
    }
    [popoverView showPopover];
    return popoverView;
}



-(void)showPopover{
    
    //Locate the view at the top fo the view stack.
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if(!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    
    UIView *topView = [[window subviews] objectAtIndex:0];
    
    self.frame = topView.frame;
    
    [topView addSubview:self];
    

    //Add a tap gesture recognizer to the large invisible view (self), which will detect taps anywhere on the screen.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tap];
    
    self.userInteractionEnabled = YES;
    
    //Make the view small and transparent before animation
    self.contextView.alpha = 0.f;
    self.contextView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);

    //animate into full size
    //First stage animates to 1.05x normal size, then second stage animates back down to 1x size.
    //This two-stage animation creates a little "pop" on open.
    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contextView.alpha = 1.f;
        self.contextView.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.contextView.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
    


    
}

- (void)tapped:(UITapGestureRecognizer *)tap {
    
    CGPoint point = [tap locationInView:_contextView];
    
    NSLog(@"point:(%f,%f)", point.x, point.y);
    
    if(!CGRectContainsPoint(_contextView.bounds, point)) {
        [self dismiss];
    }
    
}






- (void)dismiss {
    [UIView animateWithDuration:0.3f animations:^{
        self.contextView.alpha = 0.1f;
        self.contextView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
