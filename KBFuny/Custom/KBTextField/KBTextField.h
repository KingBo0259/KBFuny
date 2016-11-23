//
//  KBTextField.h
//  KBFuny
//
//  Created by jinlb on 2016/11/19.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,KB_DATA_VALIDE_TYPE) {
    KB_DATA_VALIDE_MAXLENGHT=0,
    KB_DATA_VALIDE_MAXLVALUE
};

@protocol KBTextFieldDelegate <NSObject>

@optional



/**
 开始编辑

 @param textField 开始编辑
 @param field  指定字段
 */
- (void)textFieldDidBeginEditing:(nonnull UITextField *)textField field:(nullable NSString* )field;

/*
 编辑完成后回填的代理

 @param textFeild 当前输入框
 @param field 需要回填的字段或者属性
 */
-(void)textFieldDidEndEditing:(nonnull UITextField* )textFeild field:(nullable NSString* )field;

/**
 完点击

 @param textField 当前输入框
 @param field 需要回颠的属性字段
 @return True 或 False
 */
-(BOOL)textFieldShouldReturn:(nonnull UITextField *)textField field:(nullable NSString* )field;

@end

@interface KBTextField : UIView
@property(weak,nonatomic,nullable) id<KBTextFieldDelegate>delegate;
@property(nonnull,nonatomic,strong)UILabel*leftLabel;//左边
@property(nonnull,nonatomic,strong)UILabel*rightLabel;//右边
@property(nonnull,nonatomic,strong)UITextField*inputTextFeild;//中间输入
@property(nullable,nonatomic,copy)NSString*field;//字段标识符



/**
 设置键盘

 @param keyBordType 设置键盘
 */
-(void) setKeyborkType:(UIKeyboardType)keyBordType;


-(void)setLeftTitle:(nullable NSString*)leftTitle
         rightTitle:(nullable NSString*)rightTitle
          placehold:( nullable NSString*)placehold;

-(void)setFont:(nullable UIFont*)font;

/**
 设置数据验证方式，以及提示错误提示信息（默认可为空）

 @param valideType 验证类型：0 表示 数据验证
 @param maxValueOrLength 当验证方式为长度时，这里表示长度；当验证方式为数据时，表示最大值
 @param errorInfo 验证失败时的提示信息

 */
-(void)setValideType:(KB_DATA_VALIDE_TYPE)valideType maxValueOrLength:(NSUInteger)maxValueOrLength errroInfo:(nullable NSString*)errorInfo;

@end


