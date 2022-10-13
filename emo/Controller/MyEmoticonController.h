//
//  MyEmoticonController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/10.
//

#ifndef MyEmoticonController_h
#define MyEmoticonController_h

#import "popupViewController.h"

@interface MyEmoticonController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    UITextField *txtsearch;
    UITableView *listView;
    UIView  *popupview;
    popupViewController *pc;
}
@property (nonatomic, retain) popupViewController *pc;
@property (nonatomic, retain) IBOutlet UITextField *txtsearch;
@property (nonatomic, retain) IBOutlet UITableView *listView;
@property (nonatomic, retain) NSMutableArray *listArray;
@property (nonatomic, retain) IBOutlet UIButton *btnsearch;
@property (nonatomic, retain) NSString *stype;

@end

#endif /* MyEmoticonController_h */
