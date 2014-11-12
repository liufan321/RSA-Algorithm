//
//  RSA.m
//  RSA原理
//
//  Created by 刘凡 on 14/9/16.
//  Copyright (c) 2014年 joyios. All rights reserved.
//
#import "RSA.h"

@implementation RSA

static int P = 11;
static int Q = 13;
static int N;
static int M;
static int E;
static int D;

- (instancetype)init
{
    self = [super init];
    if (self) {
        N = P * Q;
        M = (P - 1) * (Q - 1);
        NSLog(@"N:%zd - M:%zd", N, M);
        E = 89;
        
        for (int i = 1; i < INT_MAX; i++) {
            if ((i * E) % M == 1 && (i != E)) {
                D = i;
                break;
            }
        }
        NSLog(@"E:%zd - D:%zd", E, D);
    }
    return self;
}

- (NSString *)encryptString:(NSString *)string
{
    // 1. 将字符串转换成NSData
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"要加密的二进制数据: %@", data);
    
    NSMutableString *strM = [NSMutableString string];
    
    // 2. 取出字符串中的每一个字符
    for (int i = 0; i < data.length; i++) {
        unsigned char c = 0;
        [data getBytes:&c range:NSMakeRange(i, 1)];
        
        int result = 1;
        // 3. (c ^ E) % N，为了防止溢出，采用循环取模的方式计算
        for (int k = 0; k < E; k++) {
            result = result * c % N;
        }
        printf("%02d ", result);
        // 4. 拼接加密字符串
        [strM appendFormat:@"%c", result];
    }
    printf("\n");
    
    return [strM copy];
}

- (NSString *)decryptString:(NSString *)string
{
    // 1. 将字符串转换成NSData
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"要解密的二进制数据: %@", data);
    
    NSMutableString *strM = [NSMutableString string];
    
    // 2. 取出字符串中的每一个字符
    for (int i = 0; i < data.length; i++) {
        unsigned char c = 0;
        [data getBytes:&c range:NSMakeRange(i, 1)];
        
        int result = 1;
        // 3. (c ^ D) % N，为了防止溢出，采用循环取模的方式计算
        for (int k = 0; k < D; k++) {
            result = result * c % N;
        }

        // 4. 拼接加密字符串
        [strM appendFormat:@"%c", result];
    }
    printf("\n");
    
    return [strM copy];
}

/** 判断一个数字是否为质数 */
+ (BOOL)isPrime:(int)n
{
    if (n == 0 || n == 1 ) {
        return NO;
    }
    
    int k = (int)sqrt(n);
    int i = 2;
    for (; i <= k; i++) {
        if (n % i == 0) break;
    }
    
    return (i > k);
}

@end
