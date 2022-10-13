//
//  MySaveController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef MySaveController_h
#define MySaveController_h

@interface MySaveController : UIViewController {
    UIButton *btntab1, *btntab2;
    UITableView *listView;
    UICollectionView *contentView;
}
@property (nonatomic, retain) IBOutlet UIButton *btntab1, *btntab2;
@property (nonatomic, retain) IBOutlet UITableView *listView;
@property (nonatomic, retain) IBOutlet UICollectionView *contentView;
@property (nonatomic, retain) NSMutableArray *contentslist, *storieslist;

@end


#endif /* MySaveController_h */
