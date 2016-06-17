//
//  KBTouchTableView.m
//  KBFuny
//
//  Created by jinlb on 15/10/16.
//  Copyright © 2015年 jinlb. All rights reserved.
//

#import "KBTouchTableView.h"

@implementation KBTouchTableView


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [super touchesBegan:touches withEvent:event];
    
    if (_touchTableViewDelegate&&[self.touchTableViewDelegate respondsToSelector:@selector(tableView:touchesBegin:withEvent:)]) {
        [self.touchTableViewDelegate tableView:self touchesBegin:touches withEvent:event];
    }
}


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [super touchesMoved:touches withEvent:event];
    if(self.touchTableViewDelegate&&[self.touchTableViewDelegate respondsToSelector:@selector(tableView:touchesMoved:withEvent:)]){
    
        [self.touchTableViewDelegate tableView:self touchesMoved:touches withEvent:event];
    }
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [super touchesCancelled:touches withEvent:event];
    if (self.touchTableViewDelegate&&[touches respondsToSelector:@selector(tableView:touchesCancelled:withEvent:)]) {
        [self.touchTableViewDelegate tableView:self touchesCancelled:touches withEvent:event];
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [super touchesEnded:touches withEvent:event];
    if (self.touchTableViewDelegate&&[self.touchTableViewDelegate respondsToSelector:@selector(tableView:touchesEnded:withEvent:)]) {
        [self.touchTableViewDelegate tableView:self touchesEnded:touches withEvent:event];
    }

}
@end
