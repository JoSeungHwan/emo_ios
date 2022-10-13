//
//  MoreController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef MoreController_h
#define MoreController_h
#import "popupViewController.h"

@interface MoreController : UIViewController {
    UIButton *btnuse, *btnorderlist, *btnemoticon, *btnemotion1, *btnevent, *btnfaq, *btncontact, *btnorder, *btnlogin, *btntoni;
    UIScrollView *scrollView, *emoticonscroll, *myemotionscroll;
    UILabel *lbltuni;
    UIView *newemoticon, *myemotionview, *popupview, *userview, *nouserview;
    popupViewController *pc;
    
}
@property (nonatomic, retain) popupViewController *pc;
@property (nonatomic, retain) IBOutlet UIButton *btnuse, *btnorderlist, *btnemoticon, *btnemotion1, *btnevent, *btnfaq, *btncontact, *btnorder, *btntoni;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView, *emoticonscroll, *myemotionscroll;
@property (nonatomic, retain) IBOutlet UILabel *lbltuni;
@property (nonatomic, retain) IBOutlet UIView *newemoticon, *myemotionview, *userview, *nouserview;

@end

#endif /* MoreController_h */
