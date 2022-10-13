//
//  RuleController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/02.
//

#ifndef RuleController_h
#define RuleController_h

@interface RuleController : UIViewController {
    UIButton *btnok, *btnservice, *btnuse, *btnpri, *btndetail;
    UIButton *bthcheck1, *btncheck2, *btncheck3, *btncheck4, *btncheck5;
    CGFloat animatedDistance;
}
@property (nonatomic, retain) IBOutlet UIButton *btnok, *btnservice, *btnuse, *btnpri, *btndetail;
@property (nonatomic, retain) IBOutlet UIButton *bthcheck1, *btncheck2, *btncheck3, *btncheck4, *btncheck5;

@end


#endif /* RuleController_h */
