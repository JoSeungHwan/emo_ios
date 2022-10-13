//
//  SearchController.h
//  emo
//
//  Created by choi hyoung jun on 2022/09/10.
//

#ifndef SearchController_h
#define SearchController_h
#import "TagViewController.h"

@interface SearchController : UIViewController {
    UIButton *btntab1, *btntab2, *btntab3;
    UIView *viewwriter, *viewcontents, *viewtag;
    UIView *viewwriternosearch, *viewcontentnosearch, *viewtagnosearch;
    UIView *favcontents, *favtag;
    UITableView *listwriter, *listtag;
    UICollectionView *listcontents;
    UITextField *txtwriter, *txtcontents, *txttag;
    UIButton *btnsearch1, *btnsearch2, *btnsearch3;
    UIView *contentstagview, *tagview;
}

@property (nonatomic, retain) IBOutlet UIButton *btntab1, *btntab2, *btntab3;
@property (nonatomic, retain) IBOutlet UIView *viewwriter, *viewcontents, *viewtag;
@property (nonatomic, retain) IBOutlet UIView *viewwriternosearch, *viewcontentnosearch, *viewtagnosearch;
@property (nonatomic, retain) IBOutlet UIView *favcontents, *favtag;
@property (nonatomic, retain) IBOutlet UITableView *listwriter, *listtag;
@property (nonatomic, retain) IBOutlet UICollectionView *listcontents;
@property (nonatomic, retain) IBOutlet UITextField *txtwriter, *txtcontents, *txttag;
@property (nonatomic, retain) IBOutlet UIButton *btnsearch1, *btnsearch2, *btnsearch3;
@property (nonatomic, retain) IBOutlet UIView *contentstagview, *tagview;
@property (nonatomic, retain) NSMutableArray *userlist, *contentlist, *taglist, *favcontentstaglist, *favtaglist;
@property (strong, nonatomic) TagViewController *tagCView, *tagCView1;
@property int writepage, contentpage, tagpage;
@property NSString *writenext, *contentnext, *tagnext;
@end

#endif /* SearchController_h */
