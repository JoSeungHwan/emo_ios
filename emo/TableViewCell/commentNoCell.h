//
//  commentNoCell.h
//  emo
//
//  Created by choi hyoung jun on 2022/09/25.
//

#ifndef commentNoCell_h
#define commentNoCell_h

@interface commentNoCell : UITableViewCell {
    UIImageView *imgprofile, *imglike;
    UILabel *lblcomment, *lbldate, *lbllike;
    UIButton *btnlike, *btnreply, *btnmore;
    UIView *replyview;
    NSLayoutConstraint *cont, *replycont, *imgheightcont;
}
@property (nonatomic, retain) IBOutlet NSLayoutConstraint *cont, *replycont, *imgheightcont;
@property (nonatomic, retain) IBOutlet UIView *replyview;
@property (nonatomic, retain) IBOutlet UIImageView *imgprofile, *imglike;
@property (nonatomic, retain) IBOutlet UILabel *lblcomment, *lbldate, *lbllike;
@property (nonatomic, retain) IBOutlet UIButton *btnlike, *btnreply, *btnmore;

@end
#endif /* commentNoCell_h */
