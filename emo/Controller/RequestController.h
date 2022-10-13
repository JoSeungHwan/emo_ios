//
//  RequestController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef RequestController_h
#define RequestController_h

@interface RequestController : UIViewController {
    UIButton *btnsend;
    UIView *viewcont;
    UITextView *txtview;
}
@property (nonatomic, retain) IBOutlet UIButton *btnsend;
@property (nonatomic, retain) IBOutlet UIView *viewcont;
@property (nonatomic, retain) IBOutlet UITextView *txtview;

@end


#endif /* RequestController_h */
