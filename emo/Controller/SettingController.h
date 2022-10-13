//
//  SettingController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef SettingController_h
#define SettingController_h

@interface SettingController : UIViewController {
    UIScrollView *scrollView;
    UIButton *btnlanding, *btnautologin, *btnalram, *btnmyinfo, *btnservice, *btnrolue, *btnrequest, *btnlogout, *btnfire;
    UILabel *lblcurrentversion, *lblappversion;
}
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIButton *btnlanding, *btnautologin, *btnalram, *btnmyinfo, *btnservice, *btnrolue, *btnrequest, *btnlogout, *btnfire;
@property (nonatomic, retain) IBOutlet UILabel *lblcurrentversion, *lblappversion;

@end

#endif /* SettingController_h */
