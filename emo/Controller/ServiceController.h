//
//  ServiceController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef ServiceController_h
#define ServiceController_h

@interface ServiceController : UIViewController {
    UIButton *btntab1, *btntab2;
    UIImageView *imgcont1, *imgcont2;
    UIScrollView *scrollView;
}
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIButton *btntab1, *btntab2;
@property (nonatomic, retain) IBOutlet UIImageView *imgcont1, *imgcont2;
@property (nonatomic, retain) NSString *stype;

@end

#endif /* ServiceController_h */
