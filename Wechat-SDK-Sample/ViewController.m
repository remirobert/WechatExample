//
//  ViewController.m
//  Wechat-SDK-Sample
//
//  Created by Remi Robert on 26/09/2016.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

#import "ViewController.h"
#import "AuthWechatManager.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)selectScene:(NSString *)title completion:(void (^)(int scene))completion {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"moment" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completion(WXSceneTimeline);
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"contacts" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completion(WXSceneSession);
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completion(-1);
    }]];
    [self presentViewController:alertController animated:true completion:nil];
}

- (IBAction)shareLink:(id)sender {
    [self selectScene:@"share link" completion:^(int scene) {
        if (scene == -1) {
            return ;
        }
        [[AuthWechatManager shareInstance] shareLinkWithTitle:@"title link"
                                                  description:@"description link"
                                                   thumbImage:[UIImage imageNamed:@"weixin"]
                                                          url:@"http://www.google.com" to:scene];
    }];
}

- (IBAction)shareText:(id)sender {
    [self selectScene:@"share text" completion:^(int scene) {
        if (scene == -1) {
            return ;
        }
        [[AuthWechatManager shareInstance] shareTextWithText:@"text" to:scene];
    }];
}

- (IBAction)sharePicture:(id)sender {
    [self selectScene:@"share link" completion:^(int scene) {
        if (scene == -1) {
            return ;
        }
        [[AuthWechatManager shareInstance] shareImageWithImage:[UIImage imageNamed:@"weixin"] to:scene];
    }];
}

- (IBAction)auth:(id)sender {
    [[AuthWechatManager shareInstance] auth: self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
