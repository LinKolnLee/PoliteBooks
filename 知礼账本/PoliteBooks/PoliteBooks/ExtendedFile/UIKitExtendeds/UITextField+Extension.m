//
//  UITextField+Extension.m
//  FindDrug
//
//  Created by Admin on 2017/11/16.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "UITextField+Extension.h"
#import <objc/runtime.h>
@implementation UITextField (Extension)

-(BOOL)isAvailablePhone{
    NSString * phoneNumber = self.text;
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (!phoneNumber || phoneNumber.length != 11)
    {
        return NO;
    }else{
        NSString *allPhoneNumber = @"1[0-9]{10}";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", allPhoneNumber];
        BOOL isMatch = [pred1 evaluateWithObject:phoneNumber];
        return isMatch;
    }
}
#pragma mark -- 便利构造器
+ (UITextField *)textFieldWithFrame:(CGRect)frame TextColor:(UIColor *)textColor textFont:(UIFont *)textFont isClear:(BOOL)isClear textAlignment:(NSTextAlignment)textAlignment
{
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = frame;
    textField.textAlignment = textAlignment;
    textField.textColor = textColor;
    textField.borderStyle = UITextBorderStyleNone;
    textField.font = textFont;
    textField.clearsOnBeginEditing = NO;
    if (isClear) {
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }else{
        textField.clearButtonMode = UITextFieldViewModeNever;
    }
    textField.returnKeyType = UIReturnKeyDone;
    return textField;
}


+ (UITextField *)textFieldWithFrame:(CGRect)frame textColor:(UIColor *)textColor textFont:(NSInteger)textFont placeHolder:(NSString *)placeHolder image:(UIImage *)image
{
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = frame;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.textColor = textColor;
    textField.borderStyle = UITextBorderStyleNone;
    //    textField.layer.masksToBounds = YES;
    //    textField.layer.borderColor = kHexRGB(0Xcccccc).CGColor;
    //    textField.layer.borderWidth = 1;
    //    textField.layer.cornerRadius = 2.5;
    textField.font = [UIFont systemFontOfSize:textFont];
    textField.placeholder = placeHolder;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (image) {
        imageView.image = image;
    } else {
        imageView.backgroundColor = kHexRGB(0xf3f3b4);
    }
    textField.leftView = imageView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.returnKeyType = UIReturnKeyDone;
    textField.keyboardType = UIKeyboardTypeDefault;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, textField.height - 1, textField.width, 1)];
    line.backgroundColor = kHexRGB(0Xcccccc);
    [textField addSubview:line];
    
    return textField;
}
+ (UITextField *)textFieldWithFrame:(CGRect)frame textColor:(UIColor *)textColor textFont:(NSInteger)textFont placeHolder:(NSString *)placeHolder title:(NSString *)title
{
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = frame;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.textColor = textColor;
    textField.borderStyle = UITextBorderStyleNone;
    
    textField.font = [UIFont systemFontOfSize:textFont];
    textField.placeholder = placeHolder;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    if (title) {
        label.text = title;
    } else {
        label.text = @"";
    }
    textField.leftView = label;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.returnKeyType = UIReturnKeyDone;
    textField.keyboardType = UIKeyboardTypeDefault;
    return textField;
}


#pragma  mark -- 设置最大输入长度

static char maxLengthKey;

- (NSString *)maxLength
{
    return objc_getAssociatedObject(self, &maxLengthKey);
}

- (void)setMaxLength:(NSString *)maxLength
{
    objc_setAssociatedObject(self, &maxLengthKey, maxLength, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

static char reachMaxKey;

- (void (^)(BOOL reached))reachMaxBlock
{
    return objc_getAssociatedObject(self, &reachMaxKey);
}

- (void)setReachMaxBlock:(void (^)(BOOL reached))reachMaxBlock
{
    objc_setAssociatedObject(self, &reachMaxKey, reachMaxBlock, OBJC_ASSOCIATION_COPY);
}

/**设置最大的输入长度 使用此方法不可再使用addTaget:action:forControlEvents:*/
- (void)setMaxStringLength:(NSInteger)maxLength
{
    [self setMaxStringLength:maxLength alreadyReachedItsMaximum:nil];
}

/**设置最大的输入长度 以及达到最大长度的回调 使用此方法不可再使用addTaget:action:forControlEvents:*/
- (void)setMaxStringLength:(NSInteger)maxLength alreadyReachedItsMaximum:(void(^)(BOOL reached))reachBlock
{
    self.maxLength = [NSString stringWithFormat:@"%ld",(long)maxLength];;
    if (maxLength > 0) {
        [self addTarget:self action:@selector(limitMaxInputStringLength:) forControlEvents:UIControlEventEditingChanged];
    }
    if (reachBlock) {
        self.reachMaxBlock = reachBlock;
    }
}


static char textEmptyKey;

- (void (^)(BOOL empty))textEmpty
{
    return objc_getAssociatedObject(self, &textEmptyKey);
}

- (void)setTextEmpty:(void (^)(BOOL empty))emptyBlock
{
    DLog(@"emptyBlock = %@",emptyBlock);
    objc_setAssociatedObject(self, &textEmptyKey, emptyBlock, OBJC_ASSOCIATION_COPY);
}

- (void)monitorTextIsEmpty:(void (^)(BOOL empty))emptyBlock
{
    self.textEmpty = emptyBlock;
    DLog(@"%@",self.textEmpty);
    if (self.textEmpty) {
        [self addTarget:self action:@selector(limitMaxInputStringLength:) forControlEvents:UIControlEventEditingChanged];
    }
}

- (void)limitMaxInputStringLength:(UITextField *)sender
{
    if (self.textEmpty) {
        if (sender.text.length > 0) {
            self.textEmpty(NO);
        } else {
            self.textEmpty(YES);
        }
    }
    
    if (self.maxLength) {
        if (sender.text.length > [self.maxLength integerValue]) {
            sender.text = [sender.text substringToIndex:[self.maxLength integerValue]];
        }
        if (self.reachMaxBlock) {
            if (sender.text.length >= [self.maxLength integerValue]) {
                self.reachMaxBlock(YES);
            } else {
                self.reachMaxBlock(NO);
            }
        }
    }
    
}

#pragma  mark -- 设置查看密码模式
/**设置查看密码模式*/
- (void)setCheckPasswordModel:(BOOL)check
{
    if (check) {
        self.secureTextEntry = YES;
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightView = ({
            UIButton *checkPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
            checkPasswordButton.selected = NO;
            checkPasswordButton.frame = CGRectMake(0, 0, 48, self.height);
            [checkPasswordButton setImage:[[UIImage imageNamed:@"login_pwdCipher"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            [checkPasswordButton setImage:[[UIImage imageNamed:@"login_pwdWord"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
            [checkPasswordButton addTarget:self action:@selector(changeCheckPasswordStatus:) forControlEvents:UIControlEventTouchUpInside];
            checkPasswordButton;
        });
    }
}

- (void)changeCheckPasswordStatus:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.secureTextEntry = !self.secureTextEntry;
}
@end
