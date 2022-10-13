//
//  ReplyDrawController.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/11.
//

#ifndef ReplyDrawController_h
#define ReplyDrawController_h
#import <AVFoundation/AVUtilities.h>
#import <QuartzCore/QuartzCore.h>
#import "UIImage+FloodFill.h"
#import "FloodFillImageView.h"

@class ACEDrawingView;

@interface ReplyDrawController : UIViewController {
    UIButton *btnredo, *btnundo, *btndrawopen, *btnsave, *btnimageadd, *btnpencil, *btntext, *btncolor, *btnfinger;
    UILabel *lbltype, *lblnickname, *lbldate, *lblcont;
    UIImageView *imgprofile;
    UIView *drawview;
}
@property (nonatomic, retain) IBOutlet UIButton *btnredo, *btnundo, *btndrawopen, *btnsave, *btnimageadd, *btnpencil, *btntext, *btncolor, *btnfinger;
@property (nonatomic, retain) IBOutlet UILabel *lbltype, *lblnickname, *lbldate, *lblcont;
@property (nonatomic, retain) IBOutlet UIImageView *imgprofile;
@property (nonatomic, retain) IBOutlet UIView *drawview;
@property (nonatomic, retain) NSString *idx;
@property (nonatomic, unsafe_unretained) IBOutlet ACEDrawingView *drawingView;
@property (nonatomic, unsafe_unretained) IBOutlet UIImageView *baseImageView, *priviewimg;
@property (nonatomic, retain) IBOutlet FloodFillImageView *saveimgview;
@property (nonatomic, retain) NSString *stooltype;
@end

#endif /* ReplyDrawController_h */
