//
//  EventController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef EventController_h
#define EventController_h

@interface EventController : UIViewController {
    UITableView *listView;
    UILabel *lblno;
}
@property (nonatomic, retain) IBOutlet UITableView *listView;
@property (nonatomic, retain) IBOutlet UILabel *lblno;
@property (nonatomic, retain) NSMutableArray *listArray;

@end

#endif /* EventController_h */
