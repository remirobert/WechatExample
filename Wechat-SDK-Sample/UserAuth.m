//
//  UserAuth.m
//  Wechat-SDK-Sample
//
//  Created by Remi Robert on 27/09/2016.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

#import "UserAuth.h"

@implementation UserAuth

+ (instancetype)shareInstance {
    static UserAuth *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [UserAuth new];
    });
    return instance;
}

@end
