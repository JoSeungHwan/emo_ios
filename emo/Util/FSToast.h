//
//  FSToast.h
//  emo
//
//  Created by choi hyoung jun on 2022/09/11.
//

#ifndef FSToast_h
#define FSToast_h
#import <UIKit/UIKit.h>

@interface FSToast : UIView

+(void)showToast:(UIViewController*)vc messge:(NSString*)message;
+(void)showToast:(UIViewController *)vc messge:(NSString *)message backgroundColor:(UIColor*)backgroundColor duration:(int)duration;

+(void)createToast:(UIViewController *)vc messge:(NSString *)message;
+(void)createToast:(UIViewController *)vc messge:(NSString *)message backgroundColor:(UIColor*)backgroundColor duration:(int)duration;

@end

#endif /* FSToast_h */
