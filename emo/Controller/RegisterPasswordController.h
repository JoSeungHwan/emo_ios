//
//  RegisterPasswordController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef RegisterPasswordController_h
#define RegisterPasswordController_h

@interface RegisterPasswordController : UIViewController <UITextFieldDelegate> {
    UITextField *txtpassword, *txtrepassword;
    UIButton *btnnext;
    UIView *warringview1, *warringview2;
    
}
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) IBOutlet UITextField *txtpassword, *txtrepassword;
@property (nonatomic, retain) IBOutlet UIButton *btnnext;
@property (nonatomic, retain) IBOutlet UIView *warringview1, *warringview2;

@end

#endif /* RegisterPasswordController_h */
