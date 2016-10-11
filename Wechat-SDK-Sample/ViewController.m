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

- (IBAction)auth:(id)sender {
    [[AuthWechatManager shareInstance] auth: self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
