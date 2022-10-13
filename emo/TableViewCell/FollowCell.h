//
//  FollowCell.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/10.
//

#ifndef FollowCell_h
#define FollowCell_h
@interface FollowCell : UITableViewCell {
    UILabel *lbllevel, *lblnickname;
    UIImageView *imgprofile;
    UIButton *btnfollow, *btnfollowing, *btndel;
    UIView *viewlevel;
}
@property (nonatomic, retain) IBOutlet UILabel *lbllevel, *lblnickname;
@property (nonatomic, retain) IBOutlet UIImageView *imgprofile;
@property (nonatomic, retain) IBOutlet UIButton *btnfollow, *btnfollowing, *btndel;
@property (nonatomic, retain) IBOutlet UIView *viewlevel;

@end


#endif /* FollowCell_h */
