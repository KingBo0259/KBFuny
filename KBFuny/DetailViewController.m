//
//  DetailViewController.m
//  KBFuny
//
//  Created by jinlb on 15/2/27.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import "DetailViewController.h"

#import "KBButton.h"
#import "KBBadgeView.h"
#import "KBPlayVoidView.h"

/*static 修饰符则意味则该变凉仅在定义此变量的编译单元可见  （编译单元通常指每个类的实现文件(.m为后缀名)）
 * 如果不加static ，则编译器会为它创建一个 “外部符号”
 *
 */
static  const NSString*  kingboVarTest=@"kingbo";

NSString*const detailConstStant=@"test";

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
        
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    [self CatextLayer];
  
    
    KBButton *myButton=[[KBButton alloc] initWithFrame:CGRectMake(80, 200, 100, 60)];
    [myButton setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    [myButton setBackgroundColor:[UIColor blueColor] forState:UIControlStateHighlighted];

    [myButton setTitle:@"test" forState:UIControlStateNormal];
    myButton.layer.shadowOffset=CGSizeMake(1, 1);
    myButton.layer.shadowColor=[UIColor blackColor].CGColor;
    myButton.layer.shadowOpacity=0.5;
    myButton.layer.shadowRadius=30;
    
    
    
    [self.view addSubview:myButton];
    
    
    UIView *shadowView=[[UIView alloc] initWithFrame:CGRectMake(80, 200, 100, 60)];
    shadowView.backgroundColor=[UIColor whiteColor];
    shadowView.layer.shadowOffset=CGSizeMake(1, 1);
    shadowView.layer.shadowColor=[UIColor blackColor].CGColor;
    shadowView.layer.shadowOpacity=0.5;
        [self.view addSubview:shadowView];
    
    
    KBBadgeView *badgeView=[[KBBadgeView alloc]initWithFrame:CGRectMake(100, 100, 20, 20)];
    badgeView.badgeNumber=9;
    [self.view addSubview:badgeView];
    
    
    badgeView=[[KBBadgeView alloc]initWithFrame:CGRectMake(100, 150, 20, 20)];
    badgeView.badgeNumber=99;
    [self.view addSubview:badgeView];

    
    badgeView=[[KBBadgeView alloc]initWithFrame:CGRectMake(100, 250, 20, 20)];
    badgeView.badgeNumber=900;
    [self.view addSubview:badgeView];
    
    
    
//    KBPlayVoidView *message=[[KBPlayVoidView alloc]initWithFrame:CGRectMake(100, 100, 150, 30) withSecond:0];
    KBPlayVoidView *message=[[KBPlayVoidView alloc] initWithSecond:1 withOriginal:CGPointMake(100, 200)];

    [self.view addSubview:message];

   
    
}


-(void)CatextLayer
{
    UIView *labeView=[[UIView alloc] initWithFrame:CGRectMake(20, 100, 200, 400)];
    //    labeView.backgroundColor=[UIColor redColor];
    [self.view addSubview:labeView];
    //CATextLayer
    CATextLayer *textLayer=[CATextLayer layer];
    [labeView.layer addSublayer:textLayer];
    
    textLayer.frame=labeView.bounds;
    
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    //choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    //choose some text
    NSString *text = @"我是 CATextLayer 绘画出来的  ::Lorem ipsum dolor sit amet, consectetur adipiscing \ elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \ leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel \ fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \ lobortis";
    //set layer text
    textLayer.string = text;
    textLayer.contentsScale=[UIScreen mainScreen].scale;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
