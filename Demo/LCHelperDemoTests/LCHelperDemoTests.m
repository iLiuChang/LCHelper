//
//  LCHelperDemoTests.m
//  LCHelperDemoTests
//
//  Created by 刘畅 on 16/8/3.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LCHelper.h"
@interface LCHelperDemoTests : XCTestCase

@end

@implementation LCHelperDemoTests

- (void)testArray {
    NSArray *array = @[@"1",@"2",@(3)];
    NSString *nilStr = [array lc_objectAtIndex:2 asClass:NSString.class];
    XCTAssertNil(nilStr);
    
    NSString *nilStr2 = [array lc_objectAtIndex:10];
    XCTAssertNil(nilStr2);

    NSString *notNilStr = [array lc_objectAtIndex:1 asClass:NSString.class];
    XCTAssertNotNil(notNilStr);
    
    NSString *protocolStr = [array lc_objectAtIndex:1 asProtocol:@protocol(NSSecureCoding)];
    XCTAssert([@"2" isEqualToString:protocolStr]);
    
}

- (void)testBase64 {
    NSString *str = @"liuchang";
    NSString *base64 = [str lc_base64EncodedString];
    XCTAssert([str isEqualToString:[base64 lc_base64DecodingString]]);
}

@end
