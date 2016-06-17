//
//  KBMessage.h
//  KBFuny
//
//  Created by jinlb on 15/4/4.
//  Copyright (c) 2015年 jinlb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBPlayVoidView : UIView{

    UIImageView *_animationView;
    BOOL start;
    UIImageView *_noPlayImageView;
    UILabel *_secondLabel;
}

-(id)initWithSecond:(NSInteger)second withOriginal:(CGPoint)location;

-(id)initWithFrame:(CGRect)frame withSecond:(NSInteger) second;
@end
