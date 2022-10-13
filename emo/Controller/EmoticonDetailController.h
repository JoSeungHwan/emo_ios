//
//  EmoticonDetailController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef EmoticonDetailController_h
#define EmoticonDetailController_h
#import "popupViewController.h"

@interface EmoticonDetailController : UIViewController {
    UIImageView *imgcont;
    UIButton *btnbookmark;
    UILabel *lblname, *lblcont, *lbltoni, *lblnickname;
    UIButton *btnmore, *btnorder;
    UICollectionView *itemlist;
    popupViewController *pc;
    UIView *popupview;
    
}
@property (nonatomic, retain) popupViewController *pc;
@property (nonatomic, retain) IBOutlet UIImageView *imgcont;
@property (nonatomic, retain) IBOutlet UIButton *btnbookmark;
@property (nonatomic, retain) IBOutlet UILabel *lblname, *lblcont, *lbltoni, *lblnickname;
@property (nonatomic, retain) IBOutlet UIButton *btnmore, *btnorder;
@property (nonatomic, retain) IBOutlet UICollectionView *itemlist;
@property (nonatomic, retain) NSMutableArray *itemArray;
@property int idx;

@end

#endif /* EmoticonDetailController_h */
