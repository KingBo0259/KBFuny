//
//  KBEventViewController.m
//  KBFuny
//
//  Created by jinlb on 2017/5/23.
//  Copyright © 2017年 jinlb. All rights reserved.
//

#import "KBEventViewController.h"
#import <EventKit/EventKit.h>

@interface KBEventViewController ()
@property (weak, nonatomic) IBOutlet UITextField *eventIDTextField;

@property (weak, nonatomic) IBOutlet UITextField *eventNameTextFiled;
@property(nonatomic,strong) EKEventStore *eventStore ;
@end

@implementation KBEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title  = @"日历";
    _eventStore = [[EKEventStore alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveClick:(id)sender {
    //事件市场
    //6.0及以上通过下面方式写入事件
    if ([_eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // the selector is available, so we must be on iOS 6 or newer
        [_eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    //错误细心
                    // display error message here
                }
                else if (!granted)
                {
                    //被用户拒绝，不允许访问日历
                    // display access denied error message here
                }
                else
                {
                    // access granted
                    // ***** do the important stuff here *****
                    
                    //事件保存到日历
                    //创建事件
                    EKEvent *event  = [EKEvent eventWithEventStore:_eventStore];
                    event.title     = _eventNameTextFiled.text;
                    event.location = @"我在杭州西湖区留和路";
                    
                    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
                    [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
                    
                    event.startDate = [[NSDate alloc]init ];
                    event.endDate   = [[NSDate alloc]init ];
                    event.allDay = YES;
                    
                    //添加提醒
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
                    
                    [event setCalendar:[_eventStore defaultCalendarForNewEvents]];
                    NSError *err;
                   BOOL saveResult =  [_eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    
                    if (saveResult) {
                        UIAlertView *alert = [[UIAlertView alloc]
                                              initWithTitle:@"Event Created"
                                              message:@"Yay!?"
                                              delegate:nil
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
                        [alert show];
                        
                        _eventIDTextField.text = event.eventIdentifier;
                        NSLog(@"保存成功");
                    }
                   
                    
                }
            });
        }];
    }
}


- (IBAction)searchClick:(id)sender {
    if ([_eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        [_eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    //错误细心
                    // display error message here
                }
                else if (!granted)
                {
                    //被用户拒绝，不允许访问日历
                    // display access denied error message here
                }
                else
                {
                    // access granted
                    // ***** do the important stuff here *****
                    
                  EKEvent* event = [_eventStore eventWithIdentifier:_eventIDTextField.text];
                   
                    if (event) {
                        UIAlertView *alert = [[UIAlertView alloc]
                                              initWithTitle:@"查询到了改事件"
                                              message:@"Yay!?"
                                              delegate:nil
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
                        [alert show];
                        
                        _eventNameTextFiled.text = event.title;
                        NSLog(@"保存成功");
                    }else {
                        _eventNameTextFiled.text = @"无事件";
                    }
                }
            });
        }];

    }
}
- (IBAction)moveClick:(id)sender {
    if ([_eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        [_eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    //错误细心
                    // display error message here
                }
                else if (!granted)
                {
                    //被用户拒绝，不允许访问日历
                    // display access denied error message here
                }
                else
                {
                    // access granted
                    // ***** do the important stuff here *****
                    
                    EKEvent* event = [_eventStore eventWithIdentifier:_eventIDTextField.text];
                    
                    if(!event){
                        return;
                    }
                    NSError* error;
                  
                    BOOL result = [ _eventStore removeEvent:event span:EKSpanThisEvent error:&error];
                    
                    if (result) {
                        UIAlertView *alert = [[UIAlertView alloc]
                                              initWithTitle:@"成功删除"
                                              message:@"Yay!?"
                                              delegate:nil
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
                        [alert show];
                        _eventNameTextFiled.text = @"";
                    }else {
                        
                        _eventNameTextFiled.text = error.description;
                    }
                }
            });
        }];
        
    }
    
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
