//
//  PhoneAddController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef PhoneAddController_h
#define PhoneAddController_h
#import "popupViewController.h"

@interface PhoneAddController : UIViewController {
    UITextField *txtphone, *txtauth;
    UIButton *btnsend, *btnresend, *btnauth;
    UIView *authView, *popupview;
    CGFloat animatedDistance;
    popupViewController *pc;
}
@property (nonatomic, retain) IBOutlet UITextField *txtphone, *txtauth;
@property (nonatomic, retain) IBOutlet UIButton *btnsend, *btnresend, *btnauth;
@property (nonatomic, retain) IBOutlet UIView *authView;
@property (nonatomic, retain) popupViewController *pc;

@end


#endif /* PhoneAddController_h */
