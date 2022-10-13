//
//  FSToast.m
//  emo
//
//  Created by choi hyoung jun on 2022/09/11.
//

#import <Foundation/Foundation.h>
#import "FSToast.h"

typedef enum { R, G, B, A } UIColorComponentIndices;

@implementation UIColor (EPPZKit)

-(CGFloat)red
{ return CGColorGetComponents(self.CGColor)[0]; }

-(CGFloat)green
{ return CGColorGetComponents(self.CGColor)[1]; }

-(CGFloat)blue
{ return CGColorGetComponents(self.CGColor)[2]; }

-(CGFloat)alpha
{ return CGColorGetComponents(self.CGColor)[3]; }

@end


@interface FSToast (){
    
}

@end

@implementation FSToast

+(void)showToast:(UIViewController *)vc messge:(NSString *)message {
    NSLog(@"## test : %@",message);
    [self createToast:vc messge:message];
    
}

+(void)showToast:(UIViewController *)vc messge:(NSString *)message backgroundColor:(UIColor*)backgroundColor duration:(int)duration{
    NSLog(@"## test : %@",message);
    [self createToast:vc messge:message backgroundColor:backgroundColor duration:duration];
    
}

+(void)createToast:(UIViewController *)vc messge:(NSString *)message{
    //location
    CGFloat paddingToastLB = 20; //string 사이즈에 추가적인 여유공간.
    CGFloat transitionY = 25; // 애니매이션시 이동할 y축 거리
    CGRect mainbounds = UIScreen.mainScreen.bounds;
    UIFont *toastFont = [UIFont systemFontOfSize:12];
    CGSize tempSize = [self getStringSizeWithText:message font:toastFont];
    

    CGFloat toastwidth = tempSize.width+paddingToastLB;
    CGFloat toastheight = tempSize.height+paddingToastLB;
    
    /*
         (메인스크린/2) - (토스트/2)
        ,(메인스크린/2) - (토스트/2) - (애니메이션 움직일 거리)
        , 토스트
        , 토스트
     */
    CGRect tempRect = CGRectMake((mainbounds.size.width/2)-(toastwidth/2), (mainbounds.size.height/2)-(toastheight/2)-transitionY, toastwidth, toastheight);
    
    //design
    __block UILabel* toastMsgLB = nil;
    toastMsgLB = [[UILabel alloc] initWithFrame:tempRect];
    toastMsgLB.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.95];
    toastMsgLB.textAlignment = NSTextAlignmentCenter;
    toastMsgLB.textColor = UIColor.blackColor;
    [toastMsgLB setText:message];
    [toastMsgLB setFont:toastFont];
    toastMsgLB.numberOfLines = 0;
    
    //layer
    //round
    [self addShadowLayer:toastMsgLB];
    [vc.view addSubview:toastMsgLB];
    
    //animation
    toastMsgLB.alpha = 0.0;
    CGRect transitionRect = CGRectMake(tempRect.origin.x, tempRect.origin.y+transitionY, tempRect.size.width, tempRect.size.height);
    [UIView animateWithDuration:0.5 animations:^{
         toastMsgLB.alpha = 1.0;
         toastMsgLB.frame = transitionRect;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                toastMsgLB.alpha = 0.0;
                toastMsgLB.transform = CGAffineTransformMakeScale(0.01, 0.01);
            } completion:^(BOOL finished) {
                [toastMsgLB removeFromSuperview];
                toastMsgLB = nil;
            }];
        });
    }];
}

+(void)createToast:(UIViewController *)vc messge:(NSString *)message backgroundColor:(UIColor*)backgroundColor duration:(int)duration{
    //location
    CGFloat paddingToastLB = 20;
    CGFloat transitionY = 25;
    CGRect mainbounds = UIScreen.mainScreen.bounds;
    UIFont *taostFont = [UIFont systemFontOfSize:12];
    CGSize tempSize = [self getStringSizeWithText:message font:taostFont];
    
    CGFloat toastwidth = tempSize.width+paddingToastLB;
    CGFloat toastheight = tempSize.height+paddingToastLB;

    CGRect tempRect = CGRectMake((mainbounds.size.width/2)-(toastwidth/2), (mainbounds.size.height/2)-(toastheight/2)-transitionY, toastwidth, toastheight);
    
//    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
//    nf.roundingMode = NSNumberFormatterRoundFloor;
//    nf.minimumSignificantDigits = 10;
//    NSLog(@"## red :%f ,blue : %f,green : %f",[backgroundColor red],[backgroundColor blue],[backgroundColor green]);
    
    //design
    __block UILabel* toastMsgLB = nil;
    toastMsgLB = [[UILabel alloc] initWithFrame:tempRect];
    toastMsgLB.backgroundColor = backgroundColor;
    toastMsgLB.textAlignment = NSTextAlignmentCenter;
    toastMsgLB.textColor = UIColor.whiteColor;
    [toastMsgLB setText:message];
    [toastMsgLB setFont:taostFont];
    toastMsgLB.numberOfLines = 0;
    
    //layer
    //round
    [self addShadowLayer:toastMsgLB];
    [vc.view addSubview:toastMsgLB];
    
    //animation
    toastMsgLB.alpha = 0.0;
    CGRect transitionRect = CGRectMake(tempRect.origin.x, tempRect.origin.y+transitionY, tempRect.size.width, tempRect.size.height);
    [UIView animateWithDuration:0.5 animations:^{
         toastMsgLB.alpha = 1.0;
         toastMsgLB.frame = transitionRect;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                toastMsgLB.alpha = 0.0;
                toastMsgLB.transform = CGAffineTransformMakeScale(0.01, 0.01);
            } completion:^(BOOL finished) {
                [toastMsgLB removeFromSuperview];
                toastMsgLB = nil;
            }];
        });
    }];
}

//string size를 미리계산해 반환한다.
+(CGSize)getStringSizeWithText:(NSString *)string font:(UIFont *)font{
    UILabel *label = [[UILabel alloc] init];
    label.text = string;
    label.font = font;
    return label.attributedText.size;
}

//그림자를 넣어준다.
//둥그렇게 해주고싶었지만 어떻게 하는지 모르겟다...
+(void)addShadowLayer:(UIView*)v {
    //layer
    //round
    v.layer.masksToBounds = false;
    v.layer.cornerRadius = 15;
    //border
    v.layer.borderColor = UIColor.clearColor.CGColor;
    v.layer.borderWidth = 1.0;
    //shadow
    v.layer.shadowColor = UIColor.blackColor.CGColor;
    v.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    v.layer.shadowOpacity = 0.4;
    v.layer.shadowRadius = 3.5;
}

@end
