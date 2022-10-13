//
//  AppDelegate.h
//  emo
//
//  Created by choi hyoung jun on 2022/08/24.
//

#import <UIKit/UIKit.h>

@import Firebase;

@interface AppDelegate : UIResponder <UIApplicationDelegate, FIRMessagingDelegate> {
    NSString *deviceID, *deviceToken ;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *deviceID, *deviceToken;

@end

