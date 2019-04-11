//
//  CreatBookViewController.m
//  PoliteBooks
//
//  Created by 宋增宇 on 2019/4/2.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "CreatBookViewController.h"
#import "CreatBookView.h"

@interface CreatBookViewController ()

@property(nonatomic,strong)CreatBookView * creatBookView;

@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation CreatBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.creatBookView];
    [self.view addSubview:self.closeButton];
    // Do any additional setup after loading the view.
}
-(CreatBookView *)creatBookView{
    if (!_creatBookView) {
        _creatBookView = [[CreatBookView alloc] initWithFrame:CGRectMake((ScreenWidth-kIphone6Width(250))/2, (ScreenHeight - kIphone6Width(375))/2, kIphone6Width(250), kIphone6Width(375))];
        WS(weakSelf);
        __weak CreatBookView * creatBookViewNew = _creatBookView;
        
        _creatBookView.CreatBookViewSaveButtonClickBlock = ^(NSString * _Nonnull bookName, NSString * _Nonnull bookData, NSInteger bookColor) {
            weakSelf.view.userInteractionEnabled = YES;
            //数据库名
            NSMutableArray * oldNames = [UserDefaultStorageManager readObjectForKey:kUSERTABLENAMEKEY];
            NSMutableArray * newNames = [[NSMutableArray alloc] init];
            //书名
            NSMutableArray * oldBookNames = [UserDefaultStorageManager readObjectForKey:kUSERBOOKNAMEKEY];
            NSMutableArray * newBookNames = [[NSMutableArray alloc] init];
            
            NSString * tableName = [NSString stringWithFormat:@"AccountBooks%@",bookName];
            if (![kDataBase jq_isExistTable:tableName]) {
                [kDataBase jq_createTable:tableName dicOrModel:[BooksModel class]];
                BooksModel * model = [[BooksModel alloc] init];
                model.bookName = bookName;
                model.bookDate = bookData;
                model.bookImage = arc4random() % 1;
                model.bookId = 0;
                model.bookMoney = @"0";
                model.name = @"";
                model.money = @"";
                model.data = @"";
                model.tableType = bookColor;
                [kDataBase jq_inDatabase:^{
                    [kDataBase jq_insertTable:tableName dicOrModel:model];
                }];
                for (NSString * name in oldNames) {
                    [newNames addObject:name];
                }
                [newNames addObject:tableName];
                
                for (NSString * bookname in oldBookNames) {
                    [newBookNames addObject:bookname];
                }
                [newBookNames addObject:bookName];
                [UserDefaultStorageManager removeObjectForKey:kUSERTABLENAMEKEY];
                [UserDefaultStorageManager saveObject:newNames forKey:kUSERTABLENAMEKEY];
                [UserDefaultStorageManager removeObjectForKey:kUSERBOOKNAMEKEY];
                [UserDefaultStorageManager saveObject:newBookNames forKey:kUSERBOOKNAMEKEY];
            }else{
                [LEEAlert actionsheet].config
                .LeeTitle(@"提示")
                .LeeContent([NSString stringWithFormat:@"您已经有一个名称为“%@”的账本了",bookName])
                .LeeAction(@"好的", ^{
                })
                .LeeShow();
            }
            creatBookViewNew.bookNameTextField.text = @"";
            if (self.creatBookViewControllerBlock) {
                self.creatBookViewControllerBlock();
            }
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            //[weakSelf.collectionView reloadData];
        };
    }
    return _creatBookView;
}
- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth -kIphone6Width(20))/2, ScreenHeight-kIphone6Width(100), kIphone6Width(20), kIphone6Width(20))];
        [_closeButton setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
        _closeButton.backgroundColor = kWhiteColor;
        _closeButton.layer.cornerRadius = kIphone6Width(10);
        _closeButton.layer.masksToBounds = YES;
        _closeButton.layer.borderWidth = kIphone6Width(1);
        _closeButton.layer.borderColor = kBlackColor.CGColor;
        [_closeButton addTarget:self action:@selector(closeButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}
#pragma mark - # Event Response
- (void)closeButtonTouchUpInside:(UIButton *)sender {
    self.view.userInteractionEnabled = YES;
    if (self.creatBookViewControllerBlock) {
        self.creatBookViewControllerBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
