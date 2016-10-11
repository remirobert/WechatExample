//
//  ProfileViewController.m
//  Wechat-SDK-Sample
//
//  Created by Remi Robert on 27/09/2016.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

#import "ProfileViewController.h"
#import "AuthWechatManager.h"
#import "WXApi.h"

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewProfile;
@property (weak, nonatomic) IBOutlet UILabel *labelUsername;

@end

@implementation ProfileViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Download and display the image with the url in background.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.user.headimgurl]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageViewProfile.image = [UIImage imageWithData:data];
        });
    });
    self.labelUsername.text = self.user.nickname;
}

@end
