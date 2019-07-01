//
//  GlobalDefine.h
//  MUTT
//
//  Created by llk on 2018/12/12.
//  Copyright © 2018 Beauty. All rights reserved.
//

#ifndef GlobalDefine_h
#define GlobalDefine_h

#define TypeColor (@[kHexRGB(0xf15b6c),kHexRGB(0x2e4e7e),kHexRGB(0xffc773),kHexRGB(0x7bcfa6),kHexRGB(0xf47983),kHexRGB(0x815463),kHexRGB(0x758a99),kHexRGB(0x3d3b4f)])
#define TypeColorStr (@[@"#f15b6c",@"#2e4e7e",@"#ffc773",@"#7bcfa6",@"#f47983",@"#815463",@"#758a99",@"#3d3b4f"])

#define TypeClassStr (@[@"早餐",@"午餐",@"晚餐",@"蔬菜",@"水果",@"服饰",@"零食",@"购物",@"交通",@"日用",@"住房",@"餐饮",@"运动",@"娱乐",@"通讯",@"美容",@"居家",@"孩子",@"长辈",@"社交",@"旅行",@"烟酒",@"数码",@"汽车",@"医疗",@"书籍",@"学习",@"宠物",@"彩票",@"其他"])
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), 255.0, arc4random_uniform(256), 255.0)

#define kDataBase ([JQFMDB shareDatabase])

#define kMemberInfoManager ([BmobUser currentUser])
// 颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define kColor_BG                  RGBA(250,250,250,1)
#define kColor_Text_Gary           kHexColor(@"#999999")
#define kColor_Main_Color          (kHexRGB(0Xf8e58c))
#define kColor_Main_Dark_Color     RGBA(241,206,65,1)
#define kColor_Text_Black          RGBA(52, 50, 51, 1)       // 深
#define kColor_Text_Light          HexColor(@"#8B8B8B")      // 浅
#define kColor_Text_Red            HexColor(@"#FD4751")
#define kColor_Loding            (kHexRGB(0X3f3f4d))
/**
 APP版本
 */
#define kCurrentAppVersion ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])

#define imagesString (@[@"backImage1",@"backImage2"])
/**
 vibration
 */
#define VIBRATION (AudioServicesPlaySystemSound(1519))

/**
 屏幕宽度
 */
#define ScreenWidth    ([[UIScreen mainScreen] bounds].size.width)

/**
 屏幕高度
 */
#define ScreenHeight   ([[UIScreen mainScreen] bounds].size.height)

/**
 像素系数
 */
#define kIphone6Width(w) (NSInteger)(((w) * ScreenWidth) / 375.0f)

/**
 Navigation高度
 */
#define kNavigationHeight (54 + [[UIApplication sharedApplication] statusBarFrame].size.height)

/**
 状态栏高度
 */
#define kStatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)

/**
 TabBar高度
 */
#define kTabbarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

/**
 TabBar空隙
 */
#define kTabBarSpace (kTabbarHeight-49)

/**
 白色
 */
#define kWhiteColor [UIColor whiteColor]

/**
 黑色
 */
#define kBlackColor [UIColor blackColor]

//线条颜色
#define kLineColor (kHexRGB(0XF5F5F5))

/**
 WeakSelf
 */
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
/**
 设置RGB
 */
#define kHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/**
 初始化 UserDefault
 */
#define kUserDefault ([NSUserDefaults standardUserDefaults])
/**
 字体
 */
#define kFont7 ([UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(7)])
#define kFont10 ([UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(10)])
#define kFont11 ([UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(11)])
#define kFont12 ([UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(12)])
#define kFont13 ([UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(13)])
#define kFont14 ([UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(14)])
#define kFont15 ([UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(15)])
#define kFont16 ([UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(16)])
#define kFont17 ([UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(17)])
#define kFont18 ([UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(18)])
#define kFont19 ([UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(19)])
#define kFont20 ([UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(20)])
#define kFont21 ([UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(21)])
#define kFont22 ([UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(22)])
#define kFont24 ([UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(24)])
#define kFont40 ([UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(40)])
#define kFont50 ([UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(50)])
#define kFont60 ([UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(60)])
#define kFont70 ([UIFont fontWithName:@"STHeitiSC-Light" size:kIphone6Width(70)])

#define kMBFont7 ([UIFont fontWithName:@"电影海报字体" size:kIphone6Width(7)])
#define kMBFont10 ([UIFont fontWithName:@"电影海报字体" size:kIphone6Width(10)])
#define kMBFont11 ([UIFont fontWithName:@"电影海报字体" size:kIphone6Width(11)])
#define kMBFont12 ([UIFont fontWithName:@"电影海报字体" size:kIphone6Width(12)])
#define kMBFont13 ([UIFont fontWithName:@"电影海报字体" size:kIphone6Width(13)])
/**
 字体
 */
#define kPingFangTC_Light(fontSize)  [UIFont fontWithName:@"PingFangTC-Light" size:(fontSize)];
#define kPingFangSC_Semibold(fontSize)  [UIFont fontWithName:@"PingFangSC-Semibold" size:(fontSize)];
#define kPingFangSC_Regular(fontSize)  [UIFont fontWithName:@"PingFangSC-Regular" size:(kIphone6Width(fontSize))];
#define kPingFangSC_Ultralight(fontSize)  [UIFont fontWithName:@"PingFangSC-Ultralight" size:(kIphone6Width(fontSize))];

#define IPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
/**
 判断机型是否为iphoneXS MAX
 */
#define IPHONEXSMAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size): NO)
/**
 判断机型是否为iphoneXR
 */
#define IPHONEXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size): NO)
/**
 vibration
 */
#define VIBRATION (AudioServicesPlaySystemSound(1519))
/**
 打印log日志
 */
#ifdef DEBUG
#ifndef DLog
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#endif
#ifndef ELog
#   define ELog(err) {if(err) DLog(@"%@", err)}
#endif
#else
#ifndef DLog
#   define DLog(...)
#endif
#ifndef ELog
#   define ELog(err)
#endif
#endif

#endif /* GlobalDefine_h */
