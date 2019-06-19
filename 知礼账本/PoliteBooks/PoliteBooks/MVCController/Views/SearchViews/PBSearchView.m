//
//  PBSearchView.m
//  PoliteBooks
//
//  Created by llk on 2019/6/17.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "PBSearchView.h"
@interface PBSearchView()<UITextFieldDelegate>

/// 搜索框
@property (nonatomic, strong) UITextField *serchTextField;

@property (nonatomic,strong)UIImageView * serchImage;

@end
@implementation PBSearchView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.serchTextField];
        [self.serchTextField addSubview:self.serchImage];
        [self addMasonry];
    }
    return self;
}
#pragma mark - # Private Methods
- (void)addMasonry {
    // 搜索框
    [self.serchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kIphone6Width(8));
        make.right.mas_equalTo(-kIphone6Width(8));
        make.top.mas_equalTo(kIphone6Width(10));
        make.height.mas_equalTo(kIphone6Width(40));
    }];
    [self.serchImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kIphone6Width(kIphone6Width(17)));
        make.centerY.mas_equalTo(self.serchTextField.mas_centerY);
        make.height.mas_equalTo(kIphone6Width(20));
        make.width.mas_equalTo(kIphone6Width(20));
    }];
}

#pragma mark - # Getter

- (UITextField *)serchTextField {
    if (!_serchTextField) {
        _serchTextField = [[UITextField alloc] init];
        [_serchTextField setDelegate:self];
        _serchTextField.layer.cornerRadius = kIphone6Width(5);
        _serchTextField.layer.masksToBounds = YES;
        _serchTextField.layer.borderColor = kHexRGB(0x3f3f4d).CGColor;
        _serchTextField.layer.borderWidth = 1;
        _serchTextField.returnKeyType = UIReturnKeySearch;
        _serchTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 0)];
        _serchTextField.leftViewMode = UITextFieldViewModeAlways;
        _serchTextField.placeholder = @"请输入搜索人姓名";
                 NSMutableParagraphStyle *style = [_serchTextField.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
                UIFont * font = kPingFangSC_Semibold(13);
                _serchTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入搜索人姓名" attributes:@{NSForegroundColorAttributeName:kHexRGB(0x3f3f4d),NSFontAttributeName:font,NSParagraphStyleAttributeName:style}];
        
        //_serchTextField.rightViewMode = UITextFieldViewModeAlways;
        //_serchTextField.rightView = rightView;
        
    }
    return _serchTextField;
}
-(UIImageView *)serchImage{
    if (!_serchImage) {
        _serchImage = [[UIImageView alloc] init];
        _serchImage.contentMode = UIViewContentModeScaleAspectFill;
        _serchImage.image = [UIImage imageNamed:@"Search"];
    }
    return _serchImage;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length != 0) {
        if (self.serachViewTextfiledReturnBlock) {
            self.serachViewTextfiledReturnBlock(textField.text);
            [self.serchTextField resignFirstResponder];
        }
        return YES;
    }else{
        [ToastManage showTopToastWith:@"请输入搜索人"];
        return NO;
    }
   
    return YES;
}
@end
