//
//  TagController.h
//  emo
//
//  Created by choi hyoung jun on 2022/09/11.
//

#ifndef TagController_h
#define TagController_h

@interface TagController : UIViewController {
    UITableView *listView;
    UICollectionView *contentView;
    UIButton *btntab1, *btntab2;
}
@property (nonatomic, retain) IBOutlet UIButton *btntab1, *btntab2;
@property (nonatomic, retain) IBOutlet UITableView *listView;
@property (nonatomic, retain) IBOutlet UICollectionView *contentView;
@property (nonatomic, retain) NSMutableArray *contentslist, *storieslist;
@property NSString *stag, *tagnext;
@property int tagpage;
@end

#endif /* TagController_h */
