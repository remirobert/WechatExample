# WechatExample
Wechat SDK 

# installation

 - Simply copy the files : **AuthWechatManager.m**, **AuthWechatManager.h** into your project.
 - Add also the **wechat SDK** : **libWeChatSDK.a**, **WXApi.h**, **WXApiObject.h** (*chinese version*).
 
# configuration

To use your own **wechat credential** (*appID and appSecret*) information, you need to change the top of the file **AuthWechatManager.m**, with your informations : 

```Objective-c
#import "AuthWechatManager.h"
#import "WXApi.h"
#import "WXApiObject.h"

NSString *const WECHAT_APP_ID = @"wx778e68d591bbe9c8";
NSString *const WECHAT_APP_SECRET = @"72b7bdae9cfbfdf768360c628da89c25";
```

Then replace by your *appId* and *appSecret*.

# Usage Authentification

To use the **wechat authentification**, and allow users to log in your app, you need to update your **AppDelegate.m**.

This is how you need to setup the wechat SDK and init the manager:
```Objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //init the manager.
    [[AuthWechatManager shareInstance] initManager];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([[AuthWechatManager shareInstance] isWechatUrl:[url absoluteString]]) {
        //call your code for handle the wechat action
        [self handleWechatUrl:url];
    }
    return true;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([[AuthWechatManager shareInstance] isWechatUrl:[url absoluteString]]) {
        //call your code for handle the wechat action
        [self handleWechatUrl:url];
    }
    return true;
}
```

How to handle the authentification, the simpliest way to do that, is to add a method in your **AppDelegate.m** file:
```Objective-c
- (BOOL)handleWechatUrl:(NSURL *)url {
    //check if there is a connected user to avoid to handle the Wechat url
    //If connected return;
    
    //present a loading controller, waiting to fetch the user data.
    return [[AuthWechatManager shareInstance] handleOpenUrl:url completion:^(WechatUser * _Nullable user, NSError * _Nullable error) {
        //get the user information see the WechatUser model.
        //preparing to present the profile controller
        //store the connected user, to keep him logged
        [[AuthWechatManager shareInstance] initManager];
        //Your user is logged here.
        //change the root controller
    }];
}
```
