//
//  EventCell.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/04.
//

#ifndef EventCell_h
#define EventCell_h

@interface EventCell : UITableViewCell {
    UILabel *lbltitle;
    UILabel *lblcontent;
    UILabel *lbldate, *lbltype, *lbllikecount;
    UIView *typeview;
    UIImageView *imglike, *imgcont;
    UIButton *btnlike;
}
@property (nonatomic, retain) IBOutlet UILabel *lbltitle, *lblcontent, *lbldate, *lbltype, *lbllikecount;
@property (nonatomic, retain) IBOutlet UIView *typeview;
@property (nonatomic, retain) IBOutlet UIImageView *imglike, *imgcont;
@property (nonatomic, retain) IBOutlet UIButton *btnlike;

@end

#endif /* EventCell_h */
