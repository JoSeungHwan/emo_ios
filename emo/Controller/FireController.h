//
//  FireController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef FireController_h
#define FireController_h
#import "UIView+Blur.h"


@interface FireController : UIViewController {
    UIButton *btnfire, *btncheck1, *btncheck2, *btncheck3, *btncheck4, *btnok;
    UITextView *txtcont;
    UITextField *txtpassword;
    UIScrollView *scrollView;
    UIView *passwordview;
    CGFloat animatedDistance;
    UILabel *lblcheck1, *lblcheck2, *lblcheck3, *lblcheck4;
    UIView *blurView, *popupview;
    UIImageView *imgblur;
    
}
@property (nonatomic, retain) IBOutlet UIView *passwordview;
@property (nonatomic, retain) IBOutlet UIButton *btnfire, *btncheck1, *btncheck2, *btncheck3, *btncheck4;
@property (nonatomic, retain) IBOutlet UITextView *txtcont;
@property (nonatomic, retain) IBOutlet UITextField *txtpassword;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UILabel *lblcheck1, *lblcheck2, *lblcheck3, *lblcheck4;
@property (nonatomic, retain) IBOutlet UIView *blurView, *popupview;
@property (nonatomic, retain) IBOutlet UIButton *btnok;
@property (nonatomic, retain) IBOutlet UIImageView *imgblur;
@end


#endif /* FireController_h */
