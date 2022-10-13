//
//  LoginController.h
//  emo
//
//  Created by choi hyoung jun on 2022/09/24.
//

#ifndef LoginController_h
#define LoginController_h
#import "popupViewController.h"
#import <NaverThirdPartyLogin/NaverThirdPartyLogin.h>
#import <AuthenticationServices/AuthenticationServices.h>

@import FirebaseCore;

@interface LoginController : UIViewController <UITextFieldDelegate, NaverThirdPartyLoginConnectionDelegate, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding> {
    UIButton *btnkakao, *btnnaver, *btngoogle, *btnapple, *btnemail, *btnregister, *btnidpw, *btnsave;
    popupViewController *pc;
    NaverThirdPartyLoginConnection *_thirdPartyLoginConn;
    ASAuthorizationAppleIDButton *btnapple1;
    UIView *popupview, *loginview;
    UITextField *txtemail, *txtpw;

}
@property (nonatomic, retain) IBOutlet UIButton *btnkakao, *btnnaver, *btngoogle, *btnapple, *btnemail, *btnregister, *btnidpw, *btnsave;
@property (nonatomic, retain) popupViewController *pc;
@property (nonatomic, retain) IBOutlet ASAuthorizationAppleIDButton *btnapple1;
@property Boolean keyboardshow;

- (IBAction)btnkakaoPresa:(id)sender;
- (IBAction)btnnaverPress:(id)sender;
- (IBAction)btngooglePress:(id)sender;
- (IBAction)btnapplePress:(id)sender;
- (IBAction)btnemailPress:(id)sender;
- (IBAction)btnregisterPress:(id)sender;
- (IBAction)btnidpwPress:(id)sender;
- (IBAction)popupbgclick:(id)sender;
- (void)keyboardWillShow:(NSNotification *)notice;

@end

#endif /* LoginController_h */
