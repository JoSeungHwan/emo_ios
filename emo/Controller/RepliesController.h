//
//  RepliesController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef RepliesController_h
#define RepliesController_h

@interface RepliesController : UIViewController {
    UITableView *listView;
}
@property (nonatomic, retain) IBOutlet UITableView *listView;
@property (nonatomic, retain) NSMutableArray *listArray;
@property int useridx;
@end

#endif /* RepliesController_h */
