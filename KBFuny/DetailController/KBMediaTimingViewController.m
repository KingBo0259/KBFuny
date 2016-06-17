//
//  KBMediaTimingViewController.m
//  KBFuny
//
//  Created by jinlb on 15/5/3.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import "KBMediaTimingViewController.h"
#import "KBGradientCircleView.h"

@interface KBMediaTimingViewController ()
@property (weak, nonatomic) IBOutlet UITextField *durationRepeat;
@property (weak, nonatomic) IBOutlet UITextField *repeatCountField;
@property (weak, nonatomic) IBOutlet UIImageView *doorView;
@property (weak, nonatomic) IBOutlet KBGradientCircleView *gradientView;
@property (strong,nonatomic) NSTimer *nsTimer;

@property (weak, nonatomic) IBOutlet UIImageView *shiperView;
@end

@implementation KBMediaTimingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    KBGradientCircleView *circle=[[KBGradientCircleView alloc]initWithFrame:CGRectMake(150, 194, 100, 100) withRadius:40 withColor:[UIColor colorWithRed:1 green:1 blue:0 alpha:1]];
    circle.backgroundColor=[UIColor blackColor];
    _gradientView=circle;
    [self.view addSubview:circle];
    
    
    _nsTimer=[NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(refreshCirlce) userInfo:nil repeats:YES];
    [_nsTimer fire];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startClick:(UIButton*)sender {
    [self resiginResponse];
    
    if (sender.tag==0) {
        
    
    CFTimeInterval timeInterval=[self.durationRepeat.text floatValue];
    float repeatCount=[self.repeatCountField.text floatValue];
    
    
    CABasicAnimation *baseAnimation=[CABasicAnimation animation];
    baseAnimation.keyPath=@"transform.rotation";
    baseAnimation.repeatCount=repeatCount;
    baseAnimation.duration=timeInterval;
    baseAnimation.byValue=@(M_PI*2);
        [self.shiperView.layer addAnimation:baseAnimation forKey:nil];
    }else if (sender.tag==1){
    
        CATransform3D perspective=CATransform3DIdentity;//透视效果
        perspective.m34=-1.0/500.0;
        self.view.layer.sublayerTransform=perspective;
        
        
        self.doorView.layer.anchorPoint=CGPointMake(0 ,0.5);//设置anchorPoint 这样才可以使得门可以沿着边缘转动
        
        CABasicAnimation *animation=[CABasicAnimation animation];
        animation.keyPath=@"transform.rotation.y";
        animation.toValue=@(-M_PI_2);
        animation.duration=2.0f;
        animation.repeatDuration=INFINITY;
        animation.autoreverses=YES;
        
        [self.doorView.layer addAnimation:animation forKey:nil];
    
    }
 
    
    
    
}

/**
 *  刷新UI
 */
-(void)refreshCirlce
{
    static BOOL  circlePlusFlag;
    if(  _gradientView.colorAlpha>=1.0)
    {
        circlePlusFlag=NO;
        _gradientView.colorAlpha-=0.05;
        [_gradientView setNeedsDisplay];


        
    }else if (_gradientView.colorAlpha<=0){
        circlePlusFlag=YES;
        _gradientView.colorAlpha+=0.05;
        [_gradientView setNeedsDisplay];

    }else{
        
        _gradientView.colorAlpha+=circlePlusFlag?0.05:-0.05;
    
        [_gradientView setNeedsDisplay];
    
    }

}


-(void)resiginResponse{
    [self.durationRepeat resignFirstResponder];
    [self.repeatCountField resignFirstResponder];
    
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
