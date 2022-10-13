//
//  DetailController.h
//  emo
//
//  Created by choi hyoung jun on 2022/09/12.
//

#ifndef DetailController_h
#define DetailController_h
#import "popupViewController.h"

@interface DetailController : UIViewController {
    UITableView *listView;
    UIView *replyview;
    UIButton *btnsend;
    UIImageView *imgprofile;
    UITextField *txtreply;
    CGFloat animatedDistance;
    UIView *popupview, *emailtview;
    popupViewController *pc;
    UILabel *lbllikecount1;
    UIImageView *imglike1;
    NSMutableDictionary *settingdict, *selectcontent;
}
@property (nonatomic, retain) popupViewController *pc;
@property (nonatomic, retain) IBOutlet UITableView *listView;
@property (nonatomic,strong) NSMutableArray *subviewsCenterArray;
@property (nonatomic, retain) NSMutableDictionary *datadict;
@property (nonatomic, retain) IBOutlet UIView *replyview;
@property (nonatomic, retain) IBOutlet UIButton *btnsend;
@property (nonatomic, retain) IBOutlet UIImageView *imgprofile;
@property (nonatomic, retain) IBOutlet UITextField *txtreply;
@property (nonatomic, retain) NSString *replyeditYN, *replytype;
@property (nonatomic, retain) NSDictionary *selectitem;
@property (nonatomic, retain) UILabel *lbllikecount1;
@property (nonatomic, retain) UIImageView *imglike1;
@property (nonatomic, retain) NSMutableDictionary *settingdict, *selectcontent;

@end

#endif /* DetailController_h */
