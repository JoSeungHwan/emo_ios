//
//  EmoticonController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef EmoticonController_h
#define EmoticonController_h
#import "popupViewController.h"

@interface EmoticonController : UIViewController {
    UITextField *txtsearch;
    UITableView *listView;
    UIButton *btnsort, *btnsearch, *btnsorttype1, *btnsorttype2;
    UIView *sortview, *sortV, *popupview;
    UILabel *lblsort;
    popupViewController *pc;
}
@property (nonatomic, retain) popupViewController *pc;
@property (nonatomic, retain) IBOutlet UITextField *txtsearch;
@property (nonatomic, retain) IBOutlet UITableView *listView;
@property (nonatomic, retain) IBOutlet UIButton *btnsort, *btnsearch, *btnsorttype1, *btnsorttype2;
@property (nonatomic, retain) IBOutlet UIView *sortview, *sortV;
@property (nonatomic, retain) NSMutableArray *listArray;
@property (nonatomic, retain) IBOutlet UILabel *lblsort;
@property (nonatomic, retain) NSMutableDictionary *selectcontent;

@end

#endif /* EmoticonController_h */
