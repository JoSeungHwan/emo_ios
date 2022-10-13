//
//  StoriesContentCell.h
//  emo
//
//  Created by user225901 on 8/25/22.
//

#ifndef StoriesContentCell_h
#define StoriesContentCell_h

@interface StoriesContentCell : UITableViewCell {
    UILabel *lbltype, *lblcontent;
    UIButton *btnreplydraw, *btnmore;
    UIScrollView *scrollView;
}
@property (nonatomic, retain) IBOutlet UILabel *lbltype, *lblcontent;
@property (nonatomic, retain) IBOutlet UIButton *btnreplydraw, *btnmore;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIImageView *imgtype;

@end
#endif /* StoriesContentCell_h */
