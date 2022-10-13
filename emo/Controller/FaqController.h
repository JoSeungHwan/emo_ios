//
//  FaqController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef FaqController_h
#define FaqController_h
#import "HVTableView.h"

@interface FaqController : UIViewController {
    HVTableView *listVIew;
}
@property (nonatomic, retain) IBOutlet HVTableView *listView;
@property (nonatomic, retain) NSMutableArray *listArray;

@end

#endif /* FaqController_h */
