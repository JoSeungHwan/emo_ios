//
//  EditAddinfoController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef EditAddinfoController_h
#define EditAddinfoController_h
#import "popupViewController.h"

@interface EditAddinfoController : UIViewController {
    UIButton *btncheck, *btndetail, *btnbirth, *btnman, *btnwoman, *btnsend, *btnresend, *btnauth;
    UITextField *txtphone, *txtauth;
    UIView *authview, *popupview;
    UILabel *lblbirth;
    CGFloat animatedDistance;
    UIDatePicker* picker;
    UIToolbar* toolbar;
    popupViewController *pc;
}
@property (nonatomic, retain) popupViewController *pc;
@property (nonatomic, retain) IBOutlet UIButton *btncheck, *btndetail, *btnbirth, *btnman, *btnwoman, *btnsend, *btnresend, *btnauth;
@property (nonatomic, retain) IBOutlet UITextField *txtphone, *txtauth;
@property (nonatomic, retain) IBOutlet UIView *authview;
@property (nonatomic, retain) IBOutlet UILabel *lblbirth;
@property (nonatomic, retain) NSString *authphone, *selectbirth;

@end

#endif /* EditAddinfoController_h */
