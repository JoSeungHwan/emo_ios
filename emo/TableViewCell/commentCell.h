//
//  commentCell.h
//  emo
//
//  Created by choi hyoung jun on 2022/09/12.
//

#ifndef commentCell_h
#define commentCell_h

@interface commentCell : UITableViewCell {
    UIImageView *imgprofile, *imglike, *imgcont;
    UILabel *lblcomment, *lbldate, *lbllike;
    UIButton *btnlike, *btnreply, *btnmore;
    UIView *replyview;
    NSLayoutConstraint *cont, *replycont, *imgheightcont;
}
@property (nonatomic, retain) IBOutlet NSLayoutConstraint *cont, *replycont, *imgheightcont;
@property (nonatomic, retain) IBOutlet UIView *replyview;
@property (nonatomic, retain) IBOutlet UIImageView *imgprofile, *imglike, *imgcont;
@property (nonatomic, retain) IBOutlet UILabel *lblcomment, *lbldate, *lbllike;
@property (nonatomic, retain) IBOutlet UIButton *btnlike, *btnreply, *btnmore;

@end

#endif /* commentCell_h */
