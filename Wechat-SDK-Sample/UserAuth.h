//
//  UserAuth.h
//  Wechat-SDK-Sample
//
//  Created by Remi Robert on 27/09/2016.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WechatUser.h"

@interface UserAuth : NSObject

@property (nonatomic, strong) WechatUser *connectedUser;

+ (instancetype)shareInstance;

@end
