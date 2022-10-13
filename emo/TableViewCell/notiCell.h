//
//  notiCell.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/03.
//

#ifndef notiCell_h
#define notiCell_h

@interface notiCell : UITableViewCell {
    UILabel *lbltitle;
    UILabel *lblcontent;
    UILabel *lbldate;
}
@property (nonatomic, retain) IBOutlet UILabel *lbltitle, *lblcontent, *lbldate;

@end
#endif /* notiCell_h */
