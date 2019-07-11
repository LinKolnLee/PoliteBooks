//
//  UserManager.h
//  PoliteBooks
//
//  Created by llk on 2019/6/12.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserManager : NSObject

+ (__kindof UserManager *)sharedInstance;

/**
 用户ID
 */
@property(nonatomic,strong)NSString * user_id;
/**
 登陆
 */
+(void)showUserLoginView;


/**
 注册
 */
//+(void)showUserRegisterView;


/**
 用户是否登陆
 */
//+(BOOL)userIsLogin;

+(NSString*)getNameString;

@end

NS_ASSUME_NONNULL_END
