//
//  KBVoiceRecordView.m
//  KBFuny
//
//  Created by jinlb on 15/6/5.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import "KBVoiceRecordView.h"

@implementation KBVoiceRecordView{

    __weak UIView *_blackView;
    __weak UIView *_contextView;
    __weak UIButton *_recordButton;
    __weak UIButton *_selectButton;
    
    __weak UIView *_buttonRegionView;
    NSMutableArray *_carButtonArrary;
    UIImageView *_recordsImageView;
    
    BOOL _recordFlag;
    
    NSArray *_descriptionTitleArray;//头部描述文字
    UILabel *_descriptLabel;
    NSTimer *_timer;
    
}


-(id)initWithFrame:(CGRect)frame{

    self=[super initWithFrame:frame];
    
    if (self) {
        [self UIInit];
        [self hiddenView];
    }
    
    return self;
}


-(void)UIInit{
    
    /*********1、黑色背景********/
    UIView *blackView=[[UIView alloc]initWithFrame:self.frame];
    blackView.backgroundColor=[UIColor blackColor];
    blackView.alpha=0.5;
    _blackView=blackView;
    [self addSubview:blackView];

    
    /**********2、内容****************/
    UIView *contextView=[[UIView alloc] initWithFrame:self.frame];
    contextView.backgroundColor=[UIColor clearColor];
    _contextView=contextView;
    [self addSubview:contextView];
    
    
   
    
    /***********3、车辆选择**************/
    CGPoint p0,p1,p2,p3;
    p0=CGPointMake(15, self.frame.size.height-160);
    p1=CGPointMake(82, self.frame.size.height-210);
    p2=CGPointMake(180, self.frame.size.height-210);
    p3=CGPointMake(255, self.frame.size.height-160);
    
    
    
    NSArray *pointArrary=@[[NSValue valueWithCGPoint:p0]
                           ,[NSValue valueWithCGPoint:p1]
                           ,[NSValue valueWithCGPoint:p2]
                           ,[NSValue valueWithCGPoint:p3]
                           ];
    
    
    NSArray *carNameArrary=@[@"中型面包车",@"高栏小货车",@"厢式小货车",@"大型面包车"];
    
    _carButtonArrary=[[NSMutableArray alloc]initWithCapacity:4];
    
    for (int i=0; i<4; ++i) {
    CGPoint p= [((NSValue*)[pointArrary objectAtIndex:i]) CGPointValue];
  
    NSString *imageGrayName=[NSString stringWithFormat:@"main_car_gray_%i",i];
    NSString *imageSelectName=[NSString stringWithFormat:@"main_car_%i",i];
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(p.x
                                                                ,p.y,60, 60)];
    button.tag=i;
    [button setBackgroundImage:[UIImage imageNamed:imageGrayName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:imageSelectName] forState:UIControlStateSelected];
    [_contextView addSubview:button];
    [_carButtonArrary addObject:button];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
        label.font=[UIFont systemFontOfSize:12];
        label.textColor=[UIColor whiteColor];
        label.text=carNameArrary[i];
        label.center=CGPointMake(button.center.x, button.center.y+40);
        label.textAlignment=NSTextAlignmentCenter;
        [_contextView addSubview:label];
    }
    
    
    _selectButton =_carButtonArrary[0];
    [_selectButton setSelected:YES];
    _recordFlag=YES;
    
    /************4、录音动态效果***************/
    NSMutableArray *arrary=[[NSMutableArray alloc]init];
    for (int i=0; i<=3; ++i) {
        UIImage *recordImage=[UIImage imageNamed:[NSString stringWithFormat:@"record_%d",i]];
        [arrary addObject:recordImage];
    }
    
    _recordsImageView =[[UIImageView alloc]initWithFrame: CGRectMake(0, 0, 90, 90)];
    _recordsImageView.center=CGPointMake(160, self.frame.size.height/2-40);
    _recordsImageView.animationImages=arrary;
    _recordsImageView.animationRepeatCount=0;
    _recordsImageView.animationDuration=2;
    
    [contextView addSubview:_recordsImageView];
    
    
    
    //添加区域
    UIView *buttonRegionView=[[UIView alloc] init];
    buttonRegionView.frame=CGRectMake(0, 0, 160, 80);
    buttonRegionView.center=CGPointMake(160, self.frame.size.height-40);
    
    _buttonRegionView=buttonRegionView;
    [contextView addSubview:buttonRegionView];

    
    /************5、头部文字说明**********************/
    _descriptionTitleArray=@[@"说出要运什么货到哪里。",@"滑动到车型，选择车型。",@"滑动到空白处，取消录音"];
    
    UILabel *descripLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300,50)];
    descripLabel.text=_descriptionTitleArray[0];
    descripLabel.font=[UIFont systemFontOfSize:20];
    descripLabel.textColor=[UIColor whiteColor];
    descripLabel.center=CGPointMake(self.frame.size.width/2, 120);
    descripLabel.textAlignment=NSTextAlignmentCenter;
    _descriptLabel=descripLabel;
    [_contextView addSubview:descripLabel];
    
}



-(void)recordDown:(id)sender{

    [self show];
}


-(void)kbHitTest:(CGPoint)point{
    //1、point 为 self 的坐标系
    _recordFlag=NO;
    //2、将 本身坐标转为 _contextView 坐标
    for (UIButton *button in _carButtonArrary) {
        //3、self 上的坐标 Point  转化为 按钮控件的坐标系
      CGPoint  point2= [button.layer convertPoint:point fromLayer:self.layer];
//       CGPoint  point3=[self.layer convertPoint:point toLayer:button.layer];//坐标系转化和 fromLayer一样的
        BOOL  flag= [button.layer containsPoint:point2];
        if (flag) {
            [_selectButton  setSelected:NO];
            _selectButton =button;
            [_selectButton setSelected:YES];
            _recordFlag=YES;
            return;
        }
    }
    
    
    //4、判断是否在按钮区域
    CGPoint  point3= [_buttonRegionView.layer convertPoint:point fromLayer:self.layer];
    _recordFlag= [_buttonRegionView.layer containsPoint:point3];

}



-(void)show{
    [_recordsImageView startAnimating];

    _blackView.hidden=NO;
    _contextView.hidden=NO;
    
    //动态显示文案
    if (_timer) {
        [_timer invalidate];
    }

    //注意：用  scheduledTimerWithTimeInterval 用这个方法初始化，会自动添加到runLoop里
    _timer=[NSTimer timerWithTimeInterval:4 target:self selector:@selector(changeTitle) userInfo:nil repeats:YES];
    
    //将定时器添加到runLoop里面才会有效
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];

    [_timer fire];
    
}


-(void)changeTitle{
    dispatch_async(dispatch_get_main_queue()    , ^{
        static NSInteger indext=0;
        indext=indext<[_descriptionTitleArray count]?indext:0;
       
        NSString *descript= _descriptionTitleArray[indext];
        _descriptLabel.text=descript;
        ++indext;
    });
}

-(void)hiddenView{
    [_recordsImageView stopAnimating];
    _blackView.hidden=YES;
    _contextView.hidden=YES;
    [_timer invalidate];
    if (_recordFlag) {
        NSLog(@"录音");
    }else{
    
        NSLog(@"取消录音");
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
