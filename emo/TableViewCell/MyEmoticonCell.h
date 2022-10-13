//
//  MyEmoticonCell.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/10.
//

#ifndef MyEmoticonCell_h
#define MyEmoticonCell_h

@interface MyEmoticonCell : UITableViewCell {
    UILabel *lblname, *lblcont, *lbllikecount, *lblstatus;
    UIImageView *imgcont, *imglike;
    UIButton *btnlike, *btnmore;
    UIView *statusview;
}
@property (nonatomic, retain) IBOutlet UILabel *lblname, *lblcont, *lbllikecount, *lblstatus;
@property (nonatomic, retain) IBOutlet UIImageView *imgcont, *imglike;
@property (nonatomic, retain) IBOutlet UIButton *btnlike, *btnmore;
@property (nonatomic, retain) IBOutlet UIView *statusview;

@end
#endif /* MyEmoticonCell_h */
