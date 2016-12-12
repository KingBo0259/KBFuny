//
//  KBBaseCollectionViewCell.h
//  KBFuny
//
//  Created by jinlb on 2016/12/12.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBBaseCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *botTitleLabel;

@end
