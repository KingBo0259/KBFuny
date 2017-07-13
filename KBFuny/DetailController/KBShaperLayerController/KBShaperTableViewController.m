//
//  KBShaperTableViewController.m
//  KBFuny
//
//  Created by jinlb on 16/7/12.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBShaperTableViewController.h"
#import "KBShaperLayerController.h"
#import "RPDWrapperFloatView.h"

@interface KBShaperTableViewController ()
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray*detailControllers;
@property(nonatomic,weak)RPDWrapperFloatView *  wrapperFloatView;
@end

@implementation KBShaperTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"CALayer 效果案例";
    self.titles=@[@"模态/遮罩/边框/粒子效果",@"Mask",@"UIBezierPath",@"类似淘宝购物车",@"Uber首页动画",@"图片折叠效果",@"浮点窗口",@"CAShaper螺旋效果"];
    
    self.detailControllers=@[@"KBShaperLayerController",@"KBShaperLayerDemoViewController",@"UIBezierPathViewController",@"KBShoppingCartController",@"KBUberImitateViewController",@"KBImageFloderTableViewController",@"浮点窗",@"KBSpinnyMcSpinfaceViewController"];
    
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
    backItem.title=@"";
    self.navigationItem.backBarButtonItem=backItem;

    //浮窗
    RPDWrapperFloatView *  wrapperFloatView = [[RPDWrapperFloatView alloc]initWithFrame:CGRectMake(0, 0, 100, 40) Type:RPDFLOAT_TYPE_RIGHT_MID andAutoHiddenFlag:YES FloatTime:5.0];
    _wrapperFloatView = wrapperFloatView;
    wrapperFloatView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:wrapperFloatView];
    
    //截屏
    [self sreenShotTest];
    

}

-(void)sreenShotTest {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDidTakeScreenshot:)
                                                 name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    
    
}


/**
 *  返回截取到的图片
 *
 *  @return UIImage *
 */
- (UIImage *)imageWithScreenshot
{
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}
-(void)userDidTakeScreenshot:(NSNotification *)notification{
    
    NSLog(@"检测到截屏");
    
    //人为截屏, 模拟用户截屏行为, 获取所截图片
    UIImage *image_ = [self imageWithScreenshot];
    
    //添加显示
    UIImageView *imgvPhoto = [[UIImageView alloc]initWithImage:image_];
    imgvPhoto.frame = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, self.view.frame.size.width/2, self.view.frame.size.height/2);
    
    //添加边框
    CALayer * layer = [imgvPhoto layer];
    layer.borderColor = [
                         [UIColor whiteColor] CGColor];
    layer.borderWidth = 5.0f;
    //添加四个边阴影
    imgvPhoto.layer.shadowColor = [UIColor blackColor].CGColor;
    imgvPhoto.layer.shadowOffset = CGSizeMake(0, 0);
    imgvPhoto.layer.shadowOpacity = 0.5;
    imgvPhoto.layer.shadowRadius = 10.0;
    //添加两个边阴影
    imgvPhoto.layer.shadowColor = [UIColor blackColor].CGColor;
    imgvPhoto.layer.shadowOffset = CGSizeMake(4, 4);
    imgvPhoto.layer.shadowOpacity = 0.5;
    imgvPhoto.layer.shadowRadius = 2.0;
    
    [self.view addSubview:imgvPhoto];
    
    [_wrapperFloatView show];
    
}
/**
 *  截取当前屏幕
 *
 *  @return NSData *
 */
- (NSData *)dataWithScreenshotInPNGFormat
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString*  const identiferCell=@"identiferCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identiferCell];

    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identiferCell];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text=self.titles[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 6) {
        if (![_wrapperFloatView isShow]) {
            [_wrapperFloatView show];
        }else{
            [_wrapperFloatView dismiss];

        }
        return;
    }
    
    Class class=NSClassFromString(self.detailControllers[indexPath.row]);
    id obj=[class new];

    [self.navigationController pushViewController:obj animated:YES];
    
    

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
