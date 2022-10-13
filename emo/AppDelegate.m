//
//  AppDelegate.m
//  emo
//
//  Created by choi hyoung jun on 2022/08/24.
//

#import "AppDelegate.h"
#import <KakaoOpenSDK/KakaoOpenSDK.h>
#import <NaverThirdPartyLogin/NaverThirdPartyLogin.h>
#import "BlurryModalSegue.h"

#define IS_iOS_8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8

@import Firebase;

@interface AppDelegate ()

@end



@implementation AppDelegate
@synthesize deviceID, deviceToken;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   
    
   // [FIRMessaging messaging].delegate = self;

//    [FIRMessaging messaging].autoInitEnabled = YES;
    
    
    NSLog(@"chckpoint");
    self.deviceToken = @"";
    if (IS_iOS_8) { // ios8 푸시~
        [[UIApplication sharedApplication] registerUserNotificationSettings:
         [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge|
                                                       UIRemoteNotificationTypeSound|
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navibg"] forBarMetrics:UIBarMetricsDefault];
    //[NSThread sleepForTimeInterval:5.0];
   
    [FIRApp configure];
    
    [FIRMessaging messaging].delegate = self;

    [FIRMessaging messaging].autoInitEnabled = YES;
    
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [KOSession sharedSession].clientSecret = @"3980ca787bef490e138d432f2e3f2add";
    
    NaverThirdPartyLoginConnection *thirdConn = [NaverThirdPartyLoginConnection getSharedInstance];
    //    [thirdConn setOnlyPortraitSupportInIphone:YES];
    
    [thirdConn setServiceUrlScheme:@"emomanse"];
    [thirdConn setConsumerKey:@"tO7S16rhbsiBMPRRr5Tk"];
    [thirdConn setConsumerSecret:@"4PmrJWi0rI"];
    [thirdConn setAppName:@"이모만세"];
    
    [[BlurryModalSegue appearance] setBackingImageBlurRadius:@(20)];
        [[BlurryModalSegue appearance] setBackingImageSaturationDeltaFactor:@(.45)];
    
    UIDatePicker * datepicker = [UIDatePicker appearance]; //［ 가 안써져서 특수문자로 대체했으니, 코드 복사하실때 주의하세요!
    if (@available(iOS 13.5, *)) {
        datepicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
    } else {
        // Fallback on earlier versions
    }
   
    return YES;
}



#pragma mark - UISceneSession lifecycle


//iOS 9.0 미만일때 구현
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSLog(@"%@",sourceApplication);
    if ([KOSession handleOpenURL:url]) {
        return YES;
    }
  
    
        return [[NaverThirdPartyLoginConnection getSharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
  
}

//iOS 9.0 이상일 때 구현
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    NSLog(@"%@",[options description]);
    if ([KOSession handleOpenURL:url]) {
        return YES;
    }
    
    
        
        return [[NaverThirdPartyLoginConnection getSharedInstance] application:app openURL:url options:options];
   
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    [KOSession handleDidBecomeActive];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [KOSession handleDidEnterBackground];
}



- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        NSLog(@"didRegisterUser");
        [application registerForRemoteNotifications];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"pushcheck2");
    // re-post ( broadcast )
    NSString* token = [[[[deviceToken description]
                         stringByReplacingOccurrencesOfString: @"<" withString: @""]
                        stringByReplacingOccurrencesOfString: @">" withString: @""]
                       stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"deviceToken-%@",token);
    
    [FIRMessaging messaging].APNSToken = deviceToken;
    
}

- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
    NSLog(@"FCM registration token: %@", fcmToken);
    // Notify about received token.
    self.deviceToken = fcmToken;
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:fcmToken forKey:@"token"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
     @"FCMToken" object:nil userInfo:dataDict];
    // TODO: If necessary send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    // Let FCM know about the message for analytics etc.
    NSLog(@"pushsend-%@",[userInfo description]);
    [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    
    // handle your message.
}


-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"push-%@",[userInfo description]);
   
}



@end
