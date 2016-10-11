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
