//
//  UserGuideManager.h
//  PoliteBooks
//
//  Created by llk on 2019/6/17.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserGuideManager : NSObject

+(void)guideWhitIndex:(NSInteger)index;

+(BOOL)isGuideWithIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
