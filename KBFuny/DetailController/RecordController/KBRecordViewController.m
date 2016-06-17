//
//  KBRecordViewController.m
//  KBFuny
//
//  Created by jinlb on 15/6/5.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import "KBRecordViewController.h"
#import "KBVoiceRecordViewController.h"
#import "KBVoiceRecordView.h"

@interface KBRecordViewController ()
{

    KBVoiceRecordView *_recordView;
    UIButton *_recordButton;
}

@end

@implementation KBRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *backGroudView=[[UIView alloc]initWithFrame:self.view.frame];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(100, 150, 100, 40)];
    label.text=@"好吧我是测试";
    [backGroudView addSubview:label];

    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(100, 100, 100, 60);
    [button setTitle:@"按钮测试" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClik:) forControlEvents:UIControlEventTouchUpInside];
    [backGroudView addSubview:button];
    
    
    [self.view addSubview:backGroudView];
    
    
    
    KBVoiceRecordView *recordView=[[KBVoiceRecordView alloc] initWithFrame:self.view.frame];
    _recordView=recordView;
    [self.view addSubview:recordView];
    
    
    /**********3、按钮*************/
    UIButton *recordButton=[UIButton buttonWithType:UIButtonTypeCustom];
    recordButton.frame=CGRectMake(0, 0, 160, 80);
    recordButton.center=CGPointMake(160, self.view.frame.size.height-40);    
    [recordButton setBackgroundImage:[UIImage imageNamed:@"record_normal"] forState:UIControlStateNormal];
    [recordButton setBackgroundImage:[UIImage imageNamed:@"record_down"] forState:UIControlStateHighlighted];

    [recordButton addTarget:self action:@selector(recordDown:) forControlEvents:UIControlEventTouchDown];
    [recordButton addTarget:self action:@selector(recordOver:) forControlEvents:UIControlEventTouchUpInside];
    [recordButton addTarget:self action:@selector(recordOver:) forControlEvents:UIControlEventTouchUpOutside];
    
    [recordButton addTarget:self action:@selector(dragMoving:withEvent:) forControlEvents:UIControlEventTouchDragOutside];
    [recordButton addTarget:self action:@selector(dragMoving:withEvent:) forControlEvents:UIControlEventTouchDragInside];


    _recordButton=recordButton;
    [recordButton setTitle:@"录音" forState:UIControlStateNormal];
    [self.view addSubview:recordButton];
    
}


-(void)dragMoving: (UIControl *) c withEvent:ev{
    CGPoint  point =[[[ev allTouches] anyObject] locationInView:_recordView];
    
    [_recordView kbHitTest:point];
//    NSLog(@"dragOUtMoving:x=%f,y=%f",point.x,point.y);
}


-(void)recordDown:(id)sender{
    
    [_recordButton setBackgroundImage:[UIImage imageNamed:@"record_down"] forState:UIControlStateNormal];
    [_recordView show];

}

-(void)recordOver:(id)sender{
    [_recordButton setBackgroundImage:[UIImage imageNamed:@"record_normal"] forState:UIControlStateNormal];
    [_recordView hiddenView];
}




-(void)buttonClik:(id)sender{

    NSLog(@"click");

}

-(void)viewDidAppear:(BOOL)animated{

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
