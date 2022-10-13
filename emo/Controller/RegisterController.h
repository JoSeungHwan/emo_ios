//
//  RegisterController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef RegisterController_h
#define RegisterController_h

@interface RegisterController : UIViewController {
    UIButton *checkall, *checkok, *checkservice, *checkuse, *checkmarketing, *checkemail, *checksms, *checkpush, *checktel, *btnnext, *btnok, *btnservice, *btnuse;
}
@property (nonatomic, retain) IBOutlet UIButton *checkall, *checkok, *checkservice, *checkuse, *checkmarketing, *checkemail, *checksms, *checkpush, *checktel, *btnnext, *btnok, *btnservice, *btnuse;
@property Boolean chkok, chkservice, chkuse, chkmarketing, chkemail, chksms, chkpush, chktel;

@end

#endif /* RegisterController_h */
