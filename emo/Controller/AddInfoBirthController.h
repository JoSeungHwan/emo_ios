//
//  AddInfoBirthController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef AddInfoBirthController_h
#define AddInfoBirthController_h
#import "popupViewController.h"

@interface AddInfoBirthController : UIViewController {
    UIButton *btndate, *btnnext, *btncheck, *btndetail;
    UILabel *lbldate;
    UIDatePicker* picker;
    UIToolbar* toolbar;
    UIView *popupview, *popupcomplateview;
    popupViewController *pc;
}
@property (nonatomic, retain) IBOutlet UIButton *btndate, *btnnext, *btncheck, *btndetail;
@property (nonatomic, retain) IBOutlet UILabel *lbldate;
@property (nonatomic, retain) popupViewController *pc;

@end

#endif /* AddInfoBirthController_h */
