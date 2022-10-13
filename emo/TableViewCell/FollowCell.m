//
//  FollowCell.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/10.
//

#import <Foundation/Foundation.h>
#import "FollowCell.h"


@implementation FollowCell
@synthesize lbllevel, btndel, lblnickname, btnfollow, btnfollowing, imgprofile, viewlevel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
  
    return self;
}

@end
