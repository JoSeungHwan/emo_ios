//
//  notiController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef notiController_h
#define notiController_h

@interface notiController : UIViewController {
    UIButton *btnnoti, *btnalram;
    UITableView  *listView;
}
@property (nonatomic, retain) IBOutlet UIButton *btnnoti, *btnalram;
@property (nonatomic, retain) IBOutlet UITableView  *listView;
@property (nonatomic, retain) NSMutableArray *alramlist, *notilist;

@end

#endif /* notiController_h */
