//
//  ProfileController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef ProfileController_h
#define ProfileController_h
#import "popupViewController.h"

@interface ProfileController : UIViewController<UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate> {
    UIImageView *imgProfile;
    UIButton *btnimgedit, *btnmyedit;
    UITextField *txtnickname;
    UITextView *txtcomment;
    UIView *myinfoedit, *popupview;
    CGFloat animatedDistance;
    UILabel *lblhide;
    popupViewController *pc;
}
@property (nonatomic, retain) IBOutlet UILabel *lblhide;
@property (nonatomic, retain) popupViewController *pc;
@property (nonatomic, retain) IBOutlet UIImageView *imgProfile;
@property (nonatomic, retain) IBOutlet UIButton *btnimgedit, *btnmyedit;
@property (nonatomic, retain) IBOutlet UITextField *txtnickname;
@property (nonatomic, retain) IBOutlet UITextView *txtcomment;
@property (nonatomic, retain) IBOutlet UIView *myinfoedit;
@property (nonatomic, retain) NSString *stype, *filepath, *reset;
@end


#endif /* ProfileController_h */
