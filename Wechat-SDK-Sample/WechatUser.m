//
//  WechatUser.m
//  Wechat-SDK-Sample
//
//  Created by Remi Robert on 26/09/2016.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

#import "WechatUser.h"

@implementation WechatUser

- (instancetype)initWithJSON:(NSDictionary *)json { 
    self = [super init];
    
    if (self) {
        self.accessToken = [json objectForKey:@"access_token"];
        self.refreshToken = [json objectForKey:@"refresh_token"];
        self.expiresIn = [[json objectForKey:@"expires_in"] integerValue];
        self.scope = [json objectForKey:@"scope"];
    }
    return self;
}

- (void)addInformationProfileWithJSON:(NSDictionary *)json {
    self.city = [json objectForKey:@"city"];
    self.nickname = [json objectForKey:@"nickname"];
    self.headimgurl = [json objectForKey:@"headimgurl"];
    self.country = [json objectForKey:@"country"];
    self.province = [json objectForKey:@"province"];
    self.sex = [[json objectForKey:@"sex"] integerValue];
    self.language = [json objectForKey:@"language"];
}

@end
