//
//  MyProfileController.h
//  emo
//
//  Created by choi hyoung jun on 2022/09/26.
//

#ifndef MyProfileController_h
#define MyProfileController_h
#import "popupViewController.h"

@interface MyProfileController : UIViewController {
    UIImageView *imgprofile;
    UIView *viewlevel, *popupview;
    UILabel *lbllevel, *lblnickname, *lblcomment, *lblcontent, *lblfollow, *lblfolling;
    UIButton *btnmore, *btnfollow, *btnfolling, *btnedit, *btncontent, *btnstories;
    UITableView *listView;
    UICollectionView *contentView;
    popupViewController *pc;
    
}
@property (nonatomic, retain) popupViewController *pc;
@property (nonatomic, retain) IBOutlet UIImageView *imgprofile;
@property (nonatomic, retain) IBOutlet UIView *viewlevel;
@property (nonatomic, retain) IBOutlet UILabel *lbllevel, *lblnickname, *lblcomment, *lblcontent, *lblfollow, *lblfolling;
@property (nonatomic, retain) IBOutlet UIButton *btnmore, *btnfollow, *btnfolling, *btnedit, *btncontent, *btnstories;
@property (nonatomic, retain) IBOutlet UITableView *listView;
@property (nonatomic, retain) IBOutlet UICollectionView *contentView;
@property (nonatomic, retain) NSMutableArray *contentslist, *storieslist;
@property (nonatomic, retain) NSString *tagnext;
@property int tagpage;

@end

#endif /* MyProfileController_h */
