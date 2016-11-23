//
//  KBTextField.m
//  KBFuny
//
//  Created by jinlb on 2016/11/19.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBTextField.h"
#import "SVProgressHUD.h"
#define UIColorFromRGB(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface KBTextField()<UITextFieldDelegate>

/**数据验证方式*/
@property(nonatomic,assign)NSUInteger maxLength;
@property(nonatomic,assign)NSUInteger maxValue;
@property(nonatomic,assign)KB_DATA_VALIDE_TYPE valideType;//数据验证方式
@property(nonatomic,copy)NSString *errorInfo;//验证失败时弹出的信息
@end
@implementation KBTextField


-(instancetype)init{
    if (self=[super init]) {
     
        UIFont *font=[UIFont systemFontOfSize:14.0f];
        _leftLabel=[UILabel new];
        _leftLabel.textColor=[UIColor blackColor];
        //设置label1的content hugging 为1000
        [_leftLabel setContentHuggingPriority:UILayoutPriorityRequired
                                   forAxis:UILayoutConstraintAxisHorizontal];
        _leftLabel.font=font;
        
        //设置label1的content compression 为1000
        [_leftLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                 forAxis:UILayoutConstraintAxisHorizontal];
        
        _rightLabel=[UILabel new];
        _rightLabel.textColor=[UIColor blackColor];
        _rightLabel.font=font;
        
        //设置label1的content hugging 为1000
        [_rightLabel setContentHuggingPriority:UILayoutPriorityRequired
                                      forAxis:UILayoutConstraintAxisHorizontal];
        
        //设置label1的content compression 为1000
        [_rightLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                    forAxis:UILayoutConstraintAxisHorizontal];
        
        
        _inputTextFeild=[UITextField new];
        _inputTextFeild.placeholder=@"请输入";
        _inputTextFeild.delegate=self;
        _inputTextFeild.font=font;
        //改变颜色
        [_inputTextFeild setValue:UIColorFromRGB(0xD9D9D9) forKeyPath:@"_placeholderLabel.textColor"];

        
        [self addSubview:_leftLabel];
        [self addSubview:_rightLabel];
        [self addSubview:_inputTextFeild];
        [_leftLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(@5);
        }];
        
        
        [_rightLabel makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.right.bottom.equalTo(self);
            make.right.equalTo(self.right).offset(-5);
        }];
        
        [_inputTextFeild makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.equalTo(self);
            make.left.equalTo(_leftLabel.right).offset(5);
            make.right.equalTo(_rightLabel.left).offset(-5);
            
        }];
        
        
        
    }
    return self;
}



-(void)setLeftTitle:(nullable NSString*)leftTitle
         rightTitle:(nullable NSString*)rightTitle
          placehold:( nullable NSString*)placehold{

    self.leftLabel.text=leftTitle;
    self.rightLabel.text=rightTitle;
    self.inputTextFeild.placeholder=placehold;
    
    
}


-(void)setFont:(UIFont*)font{

  
    
    self.leftLabel.font=font;
    self.rightLabel.font=font;
    self.inputTextFeild.font=font;

}

/**
 1、设置键盘

 @param keyBordType 键盘样式
 */
-(void) setKeyborkType:(UIKeyboardType)keyBordType{

    self.inputTextFeild.keyboardType=keyBordType;
}

/**
 设置数据验证方式，以及提示错误提示信息（默认可为空）
 
 @param valideType 验证类型：0 表示 数据验证
 @param maxValueOrLength 当验证方式为长度时，这里表示长度；当验证方式为数据时，表示最大值
 @param errroInfo 验证失败时的提示信息
 
 */
-(void)setValideType:(KB_DATA_VALIDE_TYPE)valideType maxValueOrLength:(NSUInteger)maxValueOrLength errroInfo:(nullable NSString*)errorInfo{

     self.valideType=valideType;
        switch (valideType) {
        case KB_DATA_VALIDE_MAXLVALUE:
        {
            self.maxValue=maxValueOrLength;
            self.errorInfo=errorInfo&&errorInfo.length>0?errorInfo:[NSString stringWithFormat:@"输入数字不能大于%ld",maxValueOrLength];
        }
            break;
        case KB_DATA_VALIDE_MAXLENGHT:{
            self.maxLength=maxValueOrLength;
            self.errorInfo=errorInfo&&errorInfo.length>0?errorInfo:[NSString stringWithFormat:@"最多可输入%ld个字",maxValueOrLength];

        }
            
            break;
    }
    
    
}

#pragma mark - UITextfieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{

    textField.backgroundColor=UIColorFromRGB(0xfff6e2);
    textField.borderStyle=UITextBorderStyleRoundedRect;
    textField.clearButtonMode=UITextFieldViewModeAlways;
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:field:)]) {
        [self.delegate textFieldDidBeginEditing:textField field:self.field];
    }


}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    textField.backgroundColor=[UIColor whiteColor];
    textField.borderStyle=UITextBorderStyleNone;
    textField.clearButtonMode=UITextFieldViewModeNever;

    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidEndEditing:field:)]) {
        [self.delegate textFieldDidEndEditing:textField field:self.field];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    NSString *toString=[textField.text stringByReplacingCharactersInRange:range withString:string];

    //若是删除数据则不需要验证
    if (toString.length<=textField.text.length) return YES;

    switch (self.valideType) {
        case KB_DATA_VALIDE_MAXLENGHT :
        {
            if(toString .length>self.maxLength)
            {
                [SVProgressHUD showErrorWithStatus:self.errorInfo];
                return NO;
            }
        
        }
            break;
        case  KB_DATA_VALIDE_MAXLVALUE:{
            //B、数据验证
            //1、小数点验证
            //1.1 是否多次输入小数点
            if ([string isEqualToString:@"."]&&[textField.text containsString:@"."]) {
                return NO;
            }
            //1.2 限制小数点两位
            NSInteger flag=0;
            const NSInteger limited = 2;
            
            for (NSInteger i = toString.length-1; i>=0; i--) {
                if ([toString characterAtIndex:i] == '.') {
                    
                    if (flag > limited) {
                        return NO;
                    }
                    break;
                }
                flag++;
            }
            
            //2、最大值验证
            if ([toString integerValue]>self.maxValue) {
                [SVProgressHUD showErrorWithStatus:self.errorInfo];
                return NO;
            }

            
        }break;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldReturn:field:)]) {
      return   [self.delegate textFieldShouldReturn:textField field:self.field];
    }

    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
