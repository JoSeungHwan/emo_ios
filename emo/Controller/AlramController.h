//
//  AlramController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/08.
//

#ifndef AlramController_h
#define AlramController_h

@interface AlramController : UIViewController {
    UIView *viewalram1, *viewalram2;
    UIButton *btninfo, *btnbenfit, *btncontent, *btnlike, *btngrand, *btnemoticon, *btnevent, *btnwin;
}
@property (nonatomic, retain) IBOutlet UIView *viewalram1, *viewalram2;
@property (nonatomic, retain) IBOutlet UIButton *btninfo, *btnbenfit, *btncontent, *btnlike, *btngrand, *btnemoticon, *btnevent, *btnwin;
@end

#endif /* AlramController_h */
