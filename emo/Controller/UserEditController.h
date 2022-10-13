//
//  UserEditController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef UserEditController_h
#define UserEditController_h
#import <NaverThirdPartyLogin/NaverThirdPartyLogin.h>
#import <AuthenticationServices/AuthenticationServices.h>

@interface UserEditController : UIViewController <NaverThirdPartyLoginConnectionDelegate> {
    UIButton *btnkakao, *btnapple, *btngoogle, *btnnaver, *btnemail, *btnpassword, *btnbirth, *btnphone;
    UIScrollView *scrollView;
    UILabel *lblkakao, *lblapple, *lblgoogle, *lblnaver, *lblemail, *lblpassword, *lblbirth, *lblphone;
    UIView *kakaoview, *appleview, *googleview, *naverview;
    NSLayoutConstraint *googlecont, *applecont, *kakaocont, *navercont, *emailcont;
    NaverThirdPartyLoginConnection *_thirdPartyLoginConn;
}
@property (nonatomic, retain) IBOutlet UIButton *btnkakao, *btnapple, *btngoogle, *btnnaver, *btnemail, *btnpassword, *btnbirth, *btnphone;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UILabel *lblkakao, *lblapple, *lblgoogle, *lblnaver, *lblemail, *lblpassword, *lblbirth, *lblphone;
@property (nonatomic, retain) IBOutlet UIView *kakaoview, *appleview, *googleview, *naverview;
@property (nonatomic, retain) IBOutlet NSLayoutConstraint *googlecont, *applecont, *kakaocont, *navercont, *emailcont;
@end

#endif /* UserEditController_h */
