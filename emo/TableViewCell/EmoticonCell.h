//
//  EmoticonCell.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/08.
//

#ifndef EmoticonCell_h
#define EmoticonCell_h

@interface EmoticonCell : UITableViewCell {
    UILabel *lblname, *lblcont, *lblnickname, *lbllikecount;
    UIImageView *imgcont, *imglike;
    UIButton *btnlike, *btnmore;
    UIView *nickview;
}
@property (nonatomic, retain) IBOutlet UILabel *lblname, *lblcont, *lblnickname, *lbllikecount;
@property (nonatomic, retain) IBOutlet UIImageView *imgcont, *imglike;
@property (nonatomic, retain) IBOutlet UIButton *btnlike, *btnmore;
@property (nonatomic, retain) IBOutlet UIView *nickview;

@end

#endif /* EmoticonCell_h */
