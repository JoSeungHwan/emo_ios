//
//  UserProfileController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef UserProfileController_h
#define UserProfileController_h
#import "popupViewController.h"

@interface UserProfileController : UIViewController {
    UIImageView *imgprofile;
    UIView *viewlevel, *popupview;
    UILabel *lbllevel, *lblnickname, *lblcomment, *lblcontent, *lblfollow, *lblfolling;
    UIButton *btnmore, *btnfollow, *btnfolling, *btnfollwingrequest, *btnfollowrequest, *btnchat, *btncontent, *btnstories;
    UITableView *listView;
    UICollectionView *contentView;
    popupViewController *pc;
    
}
@property (nonatomic, retain) popupViewController *pc;
@property (nonatomic, retain) IBOutlet UIImageView *imgprofile;
@property (nonatomic, retain) IBOutlet UIView *viewlevel;
@property (nonatomic, retain) IBOutlet UILabel *lbllevel, *lblnickname, *lblcomment, *lblcontent, *lblfollow, *lblfolling;
@property (nonatomic, retain) IBOutlet UIButton *btnmore, *btnfollow, *btnfolling, *btnedit, *btncontent, *btnstories, *btnfollwingrequest, *btnfollowrequest, *btnchat;
@property (nonatomic, retain) IBOutlet UITableView *listView;
@property (nonatomic, retain) IBOutlet UICollectionView *contentView;
@property (nonatomic, retain) NSMutableArray *contentslist, *storieslist;
@property (nonatomic, retain) NSString *tagnext;
@property int useridx;
@property int tagpage;
@end


#endif /* UserProfileController_h */
