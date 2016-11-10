//
//  KBPrintPageRenderer.h
//  KBFuny
//
//  Created by jinlb on 2016/11/10.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBPrintPageRenderer : UIPrintPageRenderer
@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, strong) NSString *context;

- (id)initWithAuthorName:(NSString *)authorName
                  context:(NSString  *)context;
@end
