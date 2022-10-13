//
//  ViewController.h
//  花蜜
//
//  Created by 植梧培 on 15/5/18.
//  Copyright (c) 2015年 机智的新手( http://zhiwupei.sinaapp.com ). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popupViewController.h"

@interface ViewController : UITabBarController <UITabBarDelegate, UITabBarControllerDelegate> {
    UIView *popupview;
    
    popupViewController *pc;
}
@property (nonatomic, retain) popupViewController *pc;
- (IBAction)popupbgclick:(id)sender;
@end

