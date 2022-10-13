//
//  PasswordChangeController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef PasswordChangeController_h
#define PasswordChangeController_h

@interface PasswordChangeController : UIViewController {
    UITextField *txtpassword, *txtnewpassword, *txtrepassword;
    UIButton *btnsend;
    UIView *warringview1, *warringview2;
}
@property (nonatomic, retain) IBOutlet UITextField *txtpassword, *txtnewpassword, *txtrepassword;
@property (nonatomic, retain) IBOutlet UIButton *btnsend;
@property (nonatomic, retain) IBOutlet UIView *warringview1, *warringview2;
@property (nonatomic, retain) NSString *stype;
@property bool passwordcheck, passwordcheck1;

@end


#endif /* PasswordChangeController_h */
