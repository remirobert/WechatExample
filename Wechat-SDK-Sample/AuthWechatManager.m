//
//  AuthWechatManager.m
//  Wechat-SDK-Sample
//
//  Created by Remi Robert on 26/09/2016.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

#import "AuthWechatManager.h"
#import "WXApi.h"
#import "WXApiObject.h"

NSString *const WECHAT_APP_ID = @"wx778e68d591bbe9c8";
NSString *const WECHAT_APP_SECRET = @"72b7bdae9cfbfdf768360c628da89c25";
NSString *const BASE_URL_AUTH = @"https://api.weixin.qq.com/sns/oauth2/access_token?";
NSString *const BASE_URL_PROFILE = @"https://api.weixin.qq.com/sns/userinfo?";

typedef void (^RequestCompletedBlock)(NSDictionary * __nullable response, NSError * __nullable error);

@interface AuthWechatManager () <WXApiDelegate>
@property (nonatomic, strong) WechatAuthCompletedBlock completion;
@end

@implementation AuthWechatManager

+ (instancetype)shareInstance {
    static AuthWechatManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [AuthWechatManager new];
    });
    return instance;
}

- (BOOL)initManager {
    return [WXApi registerApp:WECHAT_APP_ID];
}

- (BOOL)isWechatUrl:(NSString *)url {
    NSString *baseUrl = [[url componentsSeparatedByString:@"://"] firstObject];
    return [baseUrl isEqualToString:WECHAT_APP_ID];
}

- (BOOL)handleOpenUrl:(NSURL *)url completion:(WechatAuthCompletedBlock)completion {
    NSString *urlString = [url absoluteString];
    NSString *urlLink = [[[[urlString componentsSeparatedByString:@"//"] lastObject] componentsSeparatedByString:@"?"] firstObject];

    NSLog(@"url link : %@", urlLink);
    if (urlLink && ([urlLink isEqualToString:@"oauth"] || [urlLink isEqualToString:@"wapoauth"])) {
        [self initManager];
        self.completion = completion;
        return [WXApi handleOpenURL:url delegate:self];
    }
    return true;
}

- (void)auth:(UIViewController *)controller {
    SendAuthReq *authReq = [SendAuthReq new];
    authReq.scope = @"snsapi_userinfo";
    authReq.state = @"wechat_auth_login_liulishuo";
    if ([WXApi isWXAppInstalled]) {
        [WXApi sendReq:authReq];
    }
    else {
        [WXApi sendAuthReq:authReq viewController: controller delegate:self];
    }
}

-(void) onReq:(BaseReq*)req {
    NSLog(@"req ok : %@", req);
}

- (void)onResp:(BaseResp*)resp {
    NSLog(@"get response fromn wechat : %@", resp);

    if (resp.errCode != WXSuccess) {
        self.completion(nil, [NSError errorWithDomain:@"wechat_error_domain" code:resp.errCode userInfo:@{NSLocalizedDescriptionKey: resp.errStr}]);
    }
    else {
        if ([resp isKindOfClass:[SendAuthResp class]]) {
            SendAuthResp *temp = (SendAuthResp*)resp;
        
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@appid=%@&secret=%@&code=%@&grant_type=authorization_code", BASE_URL_AUTH, WECHAT_APP_ID, WECHAT_APP_SECRET, temp.code]];
            
            [self performRequestWithUrl:url completion:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
                if (response) {
                    WechatUser *user = [[WechatUser alloc] initWithJSON:response];
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@access_token=%@&openid=%@", BASE_URL_PROFILE, (NSString *)[response objectForKey:@"access_token"], [response objectForKey:@"openid"]]];
                    [self performRequestWithUrl:url completion:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
                        NSLog(@"response : %@", response);
                        [user addInformationProfileWithJSON:response];
                        self.completion(user, error);
                    }];
                }
                else {
                    self.completion(nil, error);
                }
            }];
        }
    }
}

- (void)performRequestWithUrl:(NSURL *)url completion:(RequestCompletedBlock)block {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json; charset=utf8" forHTTPHeaderField:@"Accept"];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                 if (error) {
                                                                     block(nil, error);
                                                                     return;
                                                                 }
                                                                 id result = [NSJSONSerialization JSONObjectWithData:data
                                                                                                             options:NSJSONReadingAllowFragments
                                                                                                               error:&error];
                                                                 block(result, nil);
                                                             }];
    [task resume];
}

- (BOOL)canSend {
    return [WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi];
}

- (BOOL)shareLinkWithTitle:(NSString *)title
               description:(NSString *)description
                thumbImage:(UIImage *)thumbImage
                       url:(NSString *)url
                        to:(int)scene {
    if (![self canSend]) {
        return false;
    }
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    if (thumbImage) {
        [message setThumbImage:thumbImage];
    }
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    return [WXApi sendReq:req];
}

- (BOOL)shareImageWithImage:(UIImage *)image to:(int)scene {
    if (![self canSend]) {
        return false;
    }
    WXMediaMessage *message = [WXMediaMessage message];
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = UIImageJPEGRepresentation(image, 1);
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    return [WXApi sendReq:req];
}

- (BOOL)shareTextWithText:(NSString *)text to:(int)scene {
    if (![self canSend]) {
        return false;
    }
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = text;
    req.bText = YES;
    req.scene = scene;
    return [WXApi sendReq:req];
}

@end
