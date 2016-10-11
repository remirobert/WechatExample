//
//  WechatUser.h
//  Wechat-SDK-Sample
//
//  Created by Remi Robert on 26/09/2016.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WechatUser : NSObject

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *headimgurl;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, strong) NSString *openid;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, assign) NSInteger expiresIn;
@property (nonatomic, strong) NSString *refreshToken;
@property (nonatomic, strong) NSString *scope;

- (instancetype)initWithJSON:(NSDictionary *)json;
- (void)addInformationProfileWithJSON:(NSDictionary *)json;

@end
