//
//  ViewController.h
//  emo
//
//  Created by choi hyoung jun on 2022/08/24.
//

#import <UIKit/UIKit.h>
#import "popupViewController.h"

@interface homeController : UIViewController {
    UITableView *listView;
    NSArray *listArray;
    UIView *popupview;
    popupViewController *pc;
    UIButton *btnorder, *btnfilter;
    NSMutableDictionary *settingdict, *selectcontent;

}
@property (nonatomic, retain) popupViewController *pc;
@property (nonatomic, retain) IBOutlet UITableView *listView;
@property (nonatomic, retain) NSArray *listArray;
@property (nonatomic, retain) IBOutlet UIButton *btnorder, *btnfilter;
@property (nonatomic, retain) NSMutableDictionary *settingdict, *selectcontent;

@end

