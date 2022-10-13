//
//  EmailAddController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef EmailAddController_h
#define EmailAddController_h
#import "popupViewController.h"

@interface EmailAddController : UIViewController {
    UITextField *txtemail;
    UITextField *txtpassword, *txtrepassword, *txtauth;
    UIButton *btnsend, *btnresend, *btnauth;
    UIView *viewarring, *viewauth;
    UIView *popupview, *popupcomplateview;
    popupViewController *pc;
    
    CGFloat animatedDistance;
}
@property (nonatomic, retain) IBOutlet UITextField *txtemail;
@property (nonatomic, retain) IBOutlet UITextField *txtpassword, *txtrepassword, *txtauth;
@property (nonatomic, retain) IBOutlet UIButton *btnsend, *btnresend, *btnauth;
@property (nonatomic, retain) IBOutlet UIView *viewarring, *viewauth;
@property (nonatomic, retain) popupViewController *pc;

@end


#endif /* EmailAddController_h */
