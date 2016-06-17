//
//  KCUserNavigationView.m
//  KBFuny
//
//  Created by jinlb on 15/9/15.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import "KCUserNavigationView.h"


#define AnimationInterval 0.4

@implementation KCUserNavigationView{

  __weak  UIPageControl *_pageControl;
    
    
    NSMutableArray *_firstArray;
    NSMutableArray *_secondArray;
    NSMutableArray *_thirdArray;
}
-(id)init{

    if (self=[super init]) {
        self.backgroundColor=[UIColor whiteColor];
        self.frame= [UIScreen mainScreen].bounds;
        
        _firstArray=[NSMutableArray new];
        _secondArray=[NSMutableArray new];
        _thirdArray=[NSMutableArray new];
        
        //1、背景scroller
        UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:self.frame];
        scrollView.contentSize=CGSizeMake(scrollView.frame.size.width*3, scrollView.frame.size.height);
        scrollView.pagingEnabled=YES;
        scrollView.showsHorizontalScrollIndicator=NO;
        scrollView.delegate=self;
    
        
        CGFloat width,height;
        width=scrollView.frame.size.width;
        height=scrollView.frame.size.height;
        
        //1.1 第一个背景
        UIImage *imge=[UIImage imageNamed:@"nv_bg01"];
        UIImageView *imageView=[[UIImageView alloc]initWithImage:imge];
        imageView.frame=CGRectMake(0, 0, width, height);
        [scrollView addSubview:imageView];
        
        UIImage *itemImage=[UIImage imageNamed:@"nv_1_1"];
        UIImageView *itemImageView=[[UIImageView alloc] initWithImage: itemImage];
        itemImageView.frame=CGRectMake(0, 0, 48, 53);
        itemImageView.center=CGPointMake(100, 220);
        itemImageView.layer.anchorPoint=CGPointMake(0.5, 1.0);
        [imageView addSubview:itemImageView];
        [_firstArray addObject:itemImageView];
        
        itemImage=[UIImage imageNamed:@"nv_1_2"];
        itemImageView=[[UIImageView alloc] initWithImage: itemImage];
        itemImageView.frame=CGRectMake(0, 0, 48, 53);
        itemImageView.center=CGPointMake(width-80, 200);
        [imageView addSubview:itemImageView];
        itemImageView.layer.anchorPoint=CGPointMake(0.5, 1.0);

        [_firstArray addObject:itemImageView];

        
        //1.2第二个背景
        imge=[UIImage imageNamed:@"nv_bg02"];
        imageView=[[UIImageView alloc]initWithImage:imge];
        imageView.frame=CGRectMake(width, 0, width, height);
        [scrollView addSubview:imageView];
        
        itemImage=[UIImage imageNamed:@"nv_2_1"];
        itemImageView=[[UIImageView alloc] initWithImage: itemImage];
        itemImageView.frame=CGRectMake(0, 0, 48, 53);
        itemImageView.center=CGPointMake(100, 220);
        [imageView addSubview:itemImageView];
        itemImageView.layer.anchorPoint=CGPointMake(0.5, 1.0);
        [_secondArray addObject:itemImageView];

        
        
        itemImage=[UIImage imageNamed:@"nv_2_2"];
        itemImageView=[[UIImageView alloc] initWithImage: itemImage];
        itemImageView.frame=CGRectMake(0, 0, 48, 53);
        itemImageView.center=CGPointMake(width-80, 200);
        [imageView addSubview:itemImageView];
        itemImageView.layer.anchorPoint=CGPointMake(0.5, 1.0);
        [_secondArray addObject:itemImageView];

        
        //1.3第三个背景
        imge=[UIImage imageNamed:@"nv_bg03"];
        imageView=[[UIImageView alloc]initWithImage:imge];
        imageView.frame=CGRectMake(2*width, 0, width, height);
        [scrollView addSubview:imageView];
        
        
        itemImage=[UIImage imageNamed:@"nv_3_1"];
        itemImageView=[[UIImageView alloc] initWithImage: itemImage];
        itemImageView.frame=CGRectMake(0, 0, 48, 53);
        itemImageView.center=CGPointMake(80, 270);
        [imageView addSubview:itemImageView];
        itemImageView.layer.anchorPoint=CGPointMake(0.5, 1.0);
        [_thirdArray addObject:itemImageView];
        
        itemImage=[UIImage imageNamed:@"nv_3_2"];
        itemImageView=[[UIImageView alloc] initWithImage: itemImage];
        itemImageView.frame=CGRectMake(0, 0, 48, 53);
        itemImageView.center=CGPointMake(160, 180);
        [imageView addSubview:itemImageView];
        itemImageView.layer.anchorPoint=CGPointMake(0.5, 1.0);
        [_thirdArray addObject:itemImageView];
        
        
        itemImage=[UIImage imageNamed:@"nv_3_3"];
        itemImageView=[[UIImageView alloc] initWithImage: itemImage];
        itemImageView.frame=CGRectMake(0, 0, 48, 53);
        itemImageView.center=CGPointMake(width-80, 200);
        [imageView addSubview:itemImageView];
        itemImageView.layer.anchorPoint=CGPointMake(0.5, 1.0);
        [_thirdArray addObject:itemImageView];
        
        [self addSubview:scrollView];
        
        //2、分页
        UIPageControl *pageControl=[[UIPageControl alloc]init];
        pageControl.numberOfPages=3;
        pageControl.currentPage=0;
        pageControl.frame=CGRectMake(0, 0, width, 30);
        pageControl.center=CGPointMake(width/2, height-100);
        pageControl.enabled=NO;
        _pageControl=pageControl;
        [self addSubview:pageControl];
        
        //3、按钮
        UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
        button.frame=CGRectMake(0, 0, 300, 40);
        button.center=CGPointMake(width/2, height-60);
        [button setTitle:@"登录" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        button.titleLabel.font=[UIFont systemFontOfSize:16.0f];
        button.layer.cornerRadius=5.0f;
        button.alpha=0.0;
        _loginButton=button;
        [self addSubview:button];
        [self performSelector:@selector(showButton) withObject:nil afterDelay:5.0f];
        
        //4、条过
        UIButton *jumbButton=[UIButton buttonWithType:UIButtonTypeSystem];
        [jumbButton setBackgroundImage:[UIImage imageNamed:@"ng_jump"] forState:UIControlStateNormal];
        jumbButton.frame=CGRectMake(0, 0, 29.0, 29.0);
        jumbButton.center=CGPointMake(width-30, 60);
        [jumbButton addTarget:self action:@selector(jumpButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:jumbButton];
        
        [self performSelector:@selector(showAnimation) withObject:nil afterDelay:0.5];
    }
    return self;
}

-(void)jumpButtonClick:(id)sender{

    [self removeFromSuperview];
}
-(void)showButton{

    [UIView animateWithDuration:0.3f animations:^{
        
        _loginButton.alpha=1.0f;
    }];
}

#pragma mark - UIScrollerDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

   NSInteger index= (NSInteger) scrollView.contentOffset.x/scrollView.frame.size.width;
    if(  _pageControl.currentPage==index)return;
    
    _pageControl.currentPage=index;
    [self performSelector:@selector(showAnimation) withObject:nil afterDelay:0.3];
    
}

//显示当前页动画
-(void)showAnimation{
    int i=0;
 
    NSArray *tempArray=_pageControl.currentPage==0?_firstArray:(_pageControl.currentPage==1?_secondArray:_thirdArray);
    for (UIImageView *item in tempArray) {
        [self showItemAnimation:item delay:i*2*AnimationInterval];
        ++i;
    }
}
//动画集合
-(void)showItemAnimation:(UIView*)item delay:(CGFloat)delay{
    [UIView animateWithDuration:AnimationInterval
                          delay:delay
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         item.transform=CGAffineTransformMakeScale(0.5, 0.5);
                         item.alpha=0.3;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:AnimationInterval animations:^{
                             item.transform=CGAffineTransformMakeScale(1.0, 1.0);
                             item.alpha=1.0;

                         }];
                     }];
}




@end
