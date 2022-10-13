//
//  RegisterEmailController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef RegisterEmailController_h
#define RegisterEmailController_h
#import "popupViewController.h"

@interface RegisterEmailController : UIViewController <UITextFieldDelegate> {
    UIButton *btnsendauth, *btnresendauth, *btnauthcheck;
    UITextField *txtemail, *txtauth;
    UIView *viewarring, *viewauth;
    UIView *popupview, *popupcomplateview;
    popupViewController *pc;
    
    CGFloat animatedDistance;
}
@property (nonatomic, retain) IBOutlet UIButton *btnsendauth, *btnresendauth, *btnauthcheck;
@property (nonatomic, retain) IBOutlet UITextField *txtemail, *txtauth;
@property (nonatomic, retain) IBOutlet UIView *viewarring, *viewauth;
@property (nonatomic, retain) popupViewController *pc;
@property Boolean keyboardshow;

- (void)keyboardWillShow:(NSNotification *)notice;
@end


#endif /* RegisterEmailController_h */
