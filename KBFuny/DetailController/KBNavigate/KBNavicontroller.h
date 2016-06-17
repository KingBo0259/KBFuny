//
//  KBNavicontroller.h
//  KBFuny
//
//  Created by jinlb on 15/6/26.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTMSAutoSearchDataView.h"
@interface KBNavicontroller : UIViewController<UITextFieldDelegate>
@property(nonatomic,strong)  KTMSAutoSearchDataView *autoSearchDataView;
@end
