//
//  writerCell.h
//  emo
//
//  Created by choi hyoung jun on 2022/09/11.
//

#ifndef writerCell_h
#define writerCell_h

@interface writerCell : UITableViewCell {
    UILabel *lbllevel, *lblnickname, *lblfollow;
    UIImageView *imgprofile;
    UIButton *btnfollow, *btnfollowing;
    UIView *viewlevel;
}
@property (nonatomic, retain) IBOutlet UILabel *lbllevel, *lblnickname, *lblfollow;
@property (nonatomic, retain) IBOutlet UIImageView *imgprofile;
@property (nonatomic, retain) IBOutlet UIButton *btnfollow, *btnfollowing;
@property (nonatomic, retain) IBOutlet UIView *viewlevel;

@end

#endif /* writerCell_h */
