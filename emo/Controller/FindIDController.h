//
//  FindIDController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef FindIDController_h
#define FindIDController_h

@interface FindIDController : UIViewController {
    UIButton *btntab1, *btntab2;
    UIView *viewid, *viewpwd;
    UIButton *btnsend, *btnsend1;
    UITextField *txtemail, *txtphone;
}
@property (nonatomic, retain) IBOutlet UIButton *btntab1, *btntab2;
@property (nonatomic, retain) IBOutlet UIView *viewid, *viewpwd;
@property (nonatomic, retain) IBOutlet UIButton *btnsend, *btnsend1;
@property (nonatomic, retain) IBOutlet UITextField *txtemail, *txtphone;

@end

#endif /* FindIDController_h */
