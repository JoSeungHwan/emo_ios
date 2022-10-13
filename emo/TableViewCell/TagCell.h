//
//  TagCell.h
//  emo
//
//  Created by choi hyoung jun on 2022/09/11.
//

#ifndef TagCell_h
#define TagCell_h

@interface TagCell : UITableViewCell {
    UILabel *lbltag;
}
@property (nonatomic, retain) IBOutlet UILabel *lbltag;

@end
#endif /* TagCell_h */
