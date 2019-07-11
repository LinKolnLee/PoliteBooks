//
//  KeepAccountViewController.m
//  PoliteBooks
//
//  Created by llk on 2019/6/25.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "KeepAccountViewController.h"
#import "KeepAccountInOutCollectionViewCell.h"
#import "BKCKeyboard.h"
#import "KeepAccountPuliteCollectionViewCell.h"
#import "InputViewController.h"
#import "CreatBookView.h"

@interface KeepAccountViewController ()<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate,UIScrollViewDelegate
>
@property(nonatomic,strong)SPMultipleSwitch * classTypeSwitch;

@property(nonatomic,strong)UIButton * cancelButton;

@property(nonatomic,strong)UICollectionView * baseCollectionview;
@property (nonatomic, strong) BKCKeyboard *keyboard;

@property (nonatomic, assign) NSInteger accountType;

@property (nonatomic, assign) NSInteger moneyType;

@property(nonatomic,strong)CreatBookView * creatBookView;

@property (nonatomic, strong) UIButton *closeButton;

@property(nonatomic,strong)KeepAccountPuliteCollectionViewCell * selectCell;

@end

@implementation KeepAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.classTypeSwitch];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview: self.baseCollectionview];
    self.moneyType = 0;
    [self keyboard];
    // Do any additional setup after loading the view.
}
- (BKCKeyboard *)keyboard {
    if (!_keyboard) {
        WS(weakSelf);
        _keyboard = [BKCKeyboard init];
        [_keyboard setComplete:^(NSString *price, NSString *mark, NSDate *date) {
            VIBRATION;
            [weakSelf.keyboard hide];
            weakSelf.baseCollectionview.userInteractionEnabled = YES;
            if (!weakSelf.quick) {
                PBWatherModel * model = [[PBWatherModel alloc] init];
                model.price = price;
                model.week = [date weekday];
                model.year = [date year];
                model.month = [date month];
                model.day = [date day];
                model.weekNum = [date weekOfYear];
                model.mark = mark;
                model.type = weakSelf.accountType;
                model.moneyType = weakSelf.moneyType;
                [weakSelf showLoadingAnimation];
                [PBWatherExtension inserDataForModel:model success:^(id  _Nonnull responseObject) {
                    [weakSelf hiddenLoadingAnimation];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
            }else{
                PBQuickModel * model = [[PBQuickModel alloc] init];
                model.price = price;
                model.name = TypeClassStr[weakSelf.accountType];
                model.type = weakSelf.accountType;
                model.moneyType = weakSelf.moneyType;
                [weakSelf showLoadingAnimation];
                [PBQuickExtension inserDataForModel:model success:^(id  _Nonnull responseObject) {
                    [weakSelf hiddenLoadingAnimation];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
            };
        }];
        [self.view addSubview:_keyboard];
    }
    return _keyboard;
}
-(CreatBookView *)creatBookView{
    if (!_creatBookView) {
        _creatBookView = [[CreatBookView alloc] initWithFrame:CGRectMake((ScreenWidth-kIphone6Width(250))/2, (ScreenHeight - kIphone6Width(375))/2, kIphone6Width(250), kIphone6Width(375))];
        WS(weakSelf);
        __weak CreatBookView * creatBookViewNew = _creatBookView;
        _creatBookView.CreatBookViewSaveButtonClickBlock = ^(NSString * _Nonnull bookName, NSString * _Nonnull bookData, NSInteger bookColor) {
            weakSelf.view.userInteractionEnabled = YES;
            PBBookModel * model = [[PBBookModel alloc] init];
            model.bookName = bookName;
            model.bookDate = bookData;
            model.bookColor = bookColor;
            [weakSelf saveBookModel:model];
            creatBookViewNew.bookNameTextField.text = @"";
            [creatBookViewNew removeFromSuperview];
            [weakSelf.closeButton removeFromSuperview];
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
-(SPMultipleSwitch *)classTypeSwitch{
    if (!_classTypeSwitch) {
        if (!self.quick) {
            _classTypeSwitch = [[SPMultipleSwitch alloc] initWithItems:@[@"支出",@"收入",@"礼账"]];
        }else{
            _classTypeSwitch = [[SPMultipleSwitch alloc] initWithItems:@[@"支出",@"收入"]];
        }
        _classTypeSwitch.frame = CGRectMake((ScreenWidth - (ScreenWidth-150))/2, kStatusBarHeight + 10, ScreenWidth-150, 30);
        _classTypeSwitch.backgroundColor = kHexRGB(0xe9f1f6);
        _classTypeSwitch.selectedTitleColor = kWhiteColor;
        _classTypeSwitch.titleColor = kHexRGB(0x665757);
        _classTypeSwitch.trackerColor = kBlackColor;
        _classTypeSwitch.contentInset = 5;
        _classTypeSwitch.spacing = 10;
        _classTypeSwitch.titleFont = kFont14;
        //        _relationTypeSwitch.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
        //        _relationTypeSwitch.layer.borderColor = kHexRGB(0x665757).CGColor;
        [_classTypeSwitch addTarget:self action:@selector(classTypeSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _classTypeSwitch;
}
-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(ScreenWidth - 50, kStatusBarHeight + kIphone6Width(15), kIphone6Width(25), kIphone6Width(25));
        [_cancelButton addTarget:self action:@selector(cancelButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
    }
    return _cancelButton;
}
- (UICollectionView *)baseCollectionview {
    if (!_baseCollectionview) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight - kNavigationHeight - kIphone6Width(30) - kTabBarSpace);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _baseCollectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavigationHeight + kIphone6Width(30) , ScreenWidth, ScreenHeight - kNavigationHeight - kIphone6Width(20) - kTabBarSpace) collectionViewLayout:flowLayout];
        _baseCollectionview.showsVerticalScrollIndicator = NO;
        _baseCollectionview.showsHorizontalScrollIndicator = NO;
        
        _baseCollectionview.delegate = self;
        _baseCollectionview.dataSource = self;
        _baseCollectionview.pagingEnabled = YES;
        _baseCollectionview.bounces = NO;
        _baseCollectionview.backgroundColor = [UIColor whiteColor];
        [_baseCollectionview registerClass:[KeepAccountInOutCollectionViewCell class] forCellWithReuseIdentifier:@"KeepAccountInOutCollectionViewCell"];
        [_baseCollectionview registerClass:[KeepAccountPuliteCollectionViewCell class] forCellWithReuseIdentifier:@"KeepAccountPuliteCollectionViewCell"];
    }
    return _baseCollectionview;
}
-(void)classTypeSwitchAction:(SPMultipleSwitch *)switc{
    self.moneyType = switc.selectedSegmentIndex;
    [self.baseCollectionview setContentOffset:CGPointMake(switc.selectedSegmentIndex * ScreenWidth, 0)];
}
-(void)cancelButtonTouchUpInside:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)closeButtonTouchUpInside:(UIButton *)sender {
    self.view.userInteractionEnabled = YES;
    [self.creatBookView removeFromSuperview];
    [self.closeButton removeFromSuperview];
}
-(void)saveBookModel:(PBBookModel *)model{
    WS(weakSelf);
    [BmobBookExtension inserDataForModel:model success:^(id  _Nonnull responseObject) {
        //[weakSelf.baseCollectionview reloadData];
        weakSelf.selectCell.request = YES;
    }];
}
-(void)animationWithView:(UIView *)view duration:(CFTimeInterval)duration{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DIdentity]];
    animation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:animation forKey:nil];
}

#pragma mark delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.quick) {
        return 2;
    }else{
        return 3;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==  2) {
        KeepAccountPuliteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KeepAccountPuliteCollectionViewCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[KeepAccountPuliteCollectionViewCell alloc] init];
        }
        self.selectCell = cell;
        WS(weakSelf);
        __weak typeof(KeepAccountPuliteCollectionViewCell) * newCell = cell;
        cell.KeepAccountPuliteCollectionViewCellClickBlock = ^(PBBookModel * _Nonnull model) {
            InputViewController * input = [[InputViewController alloc] init];
            input.bookModel = model;
            input.InputViewControllerPopBlock = ^{
                newCell.request = YES;
            };
            [weakSelf.navigationController hh_presentErectVC:input completion:^{
            }];
        };
        cell.KeepAccountPuliteCollectionViewCellChertBlock = ^{
            weakSelf.view.userInteractionEnabled = NO;
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.creatBookView];
            [weakSelf animationWithView:weakSelf.creatBookView duration:0.5];
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.closeButton];
        };
        return cell;
    }else{
        KeepAccountInOutCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KeepAccountInOutCollectionViewCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[KeepAccountInOutCollectionViewCell alloc] init];
        }
        WS(weakSelf);
        cell.keepAccountInOutCollectionViewCellBtnSelectBlock = ^(NSInteger type) {
            weakSelf.accountType = type;
            [weakSelf.keyboard show];
            weakSelf.baseCollectionview.userInteractionEnabled = NO;
        };
        
        cell.row = indexPath.row;
        return cell;
    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.classTypeSwitch.selectedSegmentIndex = scrollView.contentOffset.x/ScreenWidth;
    self.moneyType = self.classTypeSwitch.selectedSegmentIndex;
}
@end
