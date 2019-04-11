//
//  NSString+Color.m
//  PoliteBooks
//
//  Created by llk on 2019/1/10.
//  Copyright © 2019 Beauty. All rights reserved.
//

#import "NSString+Color.h"

@implementation NSString (Color)

-(UIColor *)stringToColor{
    if ([self isEqual:@"0xC9AF99"]) {
        return kHexRGB(0xC9AF99);
    }else if ([self isEqual:@"0xA73946"]){
        return kHexRGB(0xA73946);
    }else if ([self isEqual:@"0x224E81"]){
        return kHexRGB(0x224E81);
    }
    return [UIColor whiteColor];
}
@end
