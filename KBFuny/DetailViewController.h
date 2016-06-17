//
//  DetailViewController.h
//  KBFuny
//
//  Created by jinlb on 15/2/27.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import <UIKit/UIKit.h>


//声明extern 会将常量放在 “全局符号标”中，以便可以在定义该常量的编译单元之外使用
extern NSString * const detailConstStant;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

