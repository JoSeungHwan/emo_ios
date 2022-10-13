//
//  ContentCell.h
//  emo
//
//  Created by user225901 on 8/25/22.
//

#ifndef ContentCell_h
#define ContentCell_h

@interface ContentCell : UITableViewCell <UIScrollViewDelegate> {
    UILabel *lbltype, *lblnickname, *lbldate, *lblcontent, *lbllikecount, *lblreplycount;
    UIButton *btnmore, *btnlike, *btnimg;
    UIImageView *imgprofile, *imglike, *imgtype;

}
@property (nonatomic, retain) IBOutlet UILabel *lbltype, *lblnickname, *lbldate, *lblcontent, *lbllikecount, *lblreplycount;
@property (nonatomic, retain) IBOutlet UIButton *btnmore, *btnlike, *btnimg;
@property (nonatomic, retain) IBOutlet UIImageView *imgprofile, *imglike, *imgtype;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *subviewsCenterArray;

@end
#endif /* ContentCell_h */
