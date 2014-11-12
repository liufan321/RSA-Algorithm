//
//  ViewController.m
//  RSA原理
//
//  Created by 刘凡 on 14/9/16.
//  Copyright (c) 2014年 joyios. All rights reserved.
//

#import "ViewController.h"
#import "RSA.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RSA *rsa = [[RSA alloc] init];
    NSString *encryStr = [rsa encryptString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz 0123456789"];
    NSLog(@"加密结果 : %@", encryStr);
    
    NSString *decryStr = [rsa decryptString:encryStr];
    NSLog(@"解密结果 : %@", decryStr);
}

@end
