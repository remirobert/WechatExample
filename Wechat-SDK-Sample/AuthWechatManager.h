//
//  AuthWechatManager.h
//  Wechat-SDK-Sample
//
//  Created by Remi Robert on 26/09/2016.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WechatUser.h"

typedef void (^WechatAuthCompletedBlock)(WechatUser  * __nullable user, NSError * __nullable error);

@interface AuthWechatManager : NSObject

/*! @brief shared instance of the manager (singleton). */
+ (__nonnull instancetype)shareInstance;

/*!
 @brief Init the manager.
 
 @discussion user it whenever you want to set and init the wechat SDK with API Key.
             This is required to use the API.
             The best place is : didFinishLaunchingWithOptions in the AppDelegate.m
 
 @return BOOL return the success status.
 */
- (BOOL)initManager;

/*!
 @brief check if it's a Wechat url.
 
 @discussion This method check if the url got from openURL in AppDelegate.m is from Wechat.
             Allows to handle several type of handler in the same time (Facebook, Google, etc)
 
 @param  url the url from openURL
 
 @return BOOL check the check.
 */
- (BOOL)isWechatUrl:(NSString * _Nonnull)url;

/*!
 @brief handle open url of the application.
 
 @discussion This method allows you to handle the openURL method easily.
             Detects also if it's an auth redirection, and continue the process.
 
 To use it, simply call it in the openURL method in the AppDelegate.m
 
 @param  url returned by the original method.
 @param  completion a completion block in case you have it's a auth redirection.
 
 @return BOOL return the result by openURL.
 */
- (BOOL)handleOpenUrl:(NSURL * _Nullable )url completion:(__nonnull WechatAuthCompletedBlock)completion;

/*!
 @brief Auth the user.

 @discussion Will redirect throw the wechat application, 
             and then finish in the authentification process handleOpenUrl.
*/
- (void)auth:(UIViewController * _Nullable)controller;

/*!
 @brief Share a link.
 
 @discussion Share a link, to the Wechat application.
 @param  title a title.
 @param  description a description.
 @param  thumbImage a preview visible on the chat.
 @param  url the link url.
 @param  scene specifie where to send the content : WXSceneTimeline (moment), WXSceneSession (contacts).
 
 @return BOOL return the success status.
 */
- (BOOL)shareLinkWithTitle:(NSString * _Nullable)title
               description:(NSString * _Nullable)description
                thumbImage:(UIImage * _Nullable)thumbImage
                       url:(NSString * _Nonnull)url
                        to:(int)scene;

/*!
 @brief Share an image.
 
 @discussion Share an image, to the Wechat application.
 @param  image a image.
 @param  scene specifie where to send the content : WXSceneTimeline (moment), WXSceneSession (contacts).
 
 @return BOOL return the success status.
 */
- (BOOL)shareImageWithImage:(UIImage * _Nonnull)image to:(int)scene;

/*!
 @brief Share a text.
 
 @discussion Share a text, to the Wechat application.
 @param  text a text.
 @param  scene specifie where to send the content : WXSceneTimeline (moment), WXSceneSession (contacts).
 
 @return BOOL return the success status.
 */
- (BOOL)shareTextWithText:(NSString * _Nonnull)text to:(int)scene;

@end
