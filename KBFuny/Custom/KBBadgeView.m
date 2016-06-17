//
//  KBBadgeView.m
//  KBFuny
//
//  Created by jinlb on 15/3/27.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import "KBBadgeView.h"

@implementation KBBadgeView
@synthesize badgeNumber=_badgeNumber;
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor redColor];
        self.layer.cornerRadius=frame.size.height/2;
        
        UILabel *number=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        number.textAlignment=NSTextAlignmentCenter;
        number.textColor=[UIColor whiteColor];
        number.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        [self addSubview:number];
        _numberLable=number;
        
        
    }
    return self;
}

-(void)setBadgeNumber:(NSInteger)badgeNumber
{
    _badgeNumber=badgeNumber;
    
    NSString *numberStr=nil;
    if (_badgeNumber<100) {
        numberStr=[NSString stringWithFormat:@"%li",_badgeNumber];
    }else
    {
    
        numberStr=@"99+";
    }
    
    CGSize size=[numberStr sizeWithAttributes:[NSDictionary dictionaryWithObject:_numberLable.font forKey:NSFontAttributeName]];
    
    NSInteger needAdd=_badgeNumber>=10?10:20;
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width+needAdd, size.height+10);
    self.layer.cornerRadius=self.frame.size.height/2;
    
    _numberLable.text=numberStr;
    _numberLable.frame=CGRectMake(0, 0, size.width, size.height);
    _numberLable.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
