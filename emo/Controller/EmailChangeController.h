//
//  EmailChangeController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef EmailChangeController_h
#define EmailChangeController_h
#import "popupViewController.h"

@interface EmailChangeController : UIViewController {
    UITextField *txtemail;
    UITextField *txtpassword, *txtauth;
    UIButton *btnsend, *btnresend, *btnauth;
    UIView *viewarring, *viewauth;
    UIView *popupview, *popupcomplateview;
    popupViewController *pc;
    
    CGFloat animatedDistance;
}
@property (nonatomic, retain) IBOutlet UITextField *txtemail;
@property (nonatomic, retain) IBOutlet UITextField *txtpassword, *txtauth;
@property (nonatomic, retain) IBOutlet UIButton *btnsend, *btnresend, *btnauth;
@property (nonatomic, retain) IBOutlet UIView *viewarring, *viewauth;
@property (nonatomic, retain) popupViewController *pc;

@end

#endif /* EmailChangeController_h */
