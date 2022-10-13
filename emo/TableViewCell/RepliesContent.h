//
//  RepliesContent.h
//  emo
//
//  Created by choi hyoung jun on 2022/08/30.
//

#ifndef RepliesContent_h
#define RepliesContent_h
#import "SDAnimatedImageView.h"

@interface RepliesContent : UIView {
    UIImageView  *imgprofile, *imglike;
    UIImageView *imgcont;
    UILabel *lblcontent, *lbllikecount, *lblrepliescount;
    UIButton *btnlike, *btnmore, *btnimg;
}
@property (nonatomic, retain) IBOutlet  UIImageView *imgprofile, *imglike;
@property (nonatomic, retain) IBOutlet UIImageView *imgcont;
@property (nonatomic, retain) IBOutlet  UILabel *lblcontent, *lbllikecount, *lblrepliescount;
@property (nonatomic, retain) IBOutlet  UIButton *btnlike, *btnmore, *btnimg;


@end
#endif /* RepliesContent_h */
