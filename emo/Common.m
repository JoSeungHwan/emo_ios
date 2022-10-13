//
//  Common.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/09.
//

#import <Foundation/Foundation.h>
#import "Common.h"

@implementation Common

+ (instancetype)sharedInstance {
    //static, 객체 자신의 타입으로 shared 를 선언하여 해당 클래스 내에서 언제든 접근이 가능하다.
    static Common *shared = nil;
    
    //dispatch_once_t 타입의 일명 onceToken 을 static으로 선언
    //이 변수를 통해 dispatch_once 블럭의 실행유무를 확인할 수 있게 된다.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[Common alloc] init];
    });
    return shared;
}

@end
