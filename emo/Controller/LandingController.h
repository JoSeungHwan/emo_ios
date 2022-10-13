//
//  LandingController.h
//  emo
//
//  Created by choi hyoung jun on 2022/08/30.
//

#ifndef LandingController_h
#define LandingController_h

@interface LandingController : UIViewController {
    UITableView *listView;
    NSArray *listArray;
}
@property (nonatomic, retain) IBOutlet UITableView *listView;
@property (nonatomic, retain) NSArray *listArray;

@end;

#endif /* LandingController_h */
