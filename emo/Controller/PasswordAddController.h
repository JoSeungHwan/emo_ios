//
//  PasswordAddController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef PasswordAddController_h
#define PasswordAddController_h

@interface PasswordAddController : UIViewController {
    UITextField *txtpassword, *txtrepassword;
    UIButton *btnsend;
    UIView *warringview1, *warringview2;
}
@property (nonatomic, retain) IBOutlet UITextField *txtpassword, *txtrepassword;
@property (nonatomic, retain) IBOutlet UIButton *btnsend;
@property (nonatomic, retain) IBOutlet UIView *warringview1, *warringview2;
@property (nonatomic, retain) NSString *stype;
@property bool passwordcheck, passwordcheck1;
@end


#endif /* PasswordAddController_h */
