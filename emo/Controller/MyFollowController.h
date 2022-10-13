//
//  MyFollowController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef MyFollowController_h
#define MyFollowController_h

@interface MyFollowController : UIViewController {
    UIButton *btnfollow, *btnfollowing, *btnsearch;
    UITableView *listView;
    UITextField *txtsearch;
}
@property (nonatomic, retain) NSString *stype, *writenext;
@property (nonatomic, retain) IBOutlet UIButton *btnfollow, *btnfollowing, *btnsearch;
@property (nonatomic, retain) IBOutlet UITableView *listView;
@property (nonatomic, retain) NSMutableArray *followlist, *followinglist;
@property (nonatomic, retain) IBOutlet UITextField *txtsearch;
@property int useridx, page;
@end

#endif /* MyFollowController_h */
