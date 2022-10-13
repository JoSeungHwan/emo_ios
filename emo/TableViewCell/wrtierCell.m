//
//  wrtierCell.m
//  emo
//
//  Created by choi hyoung jun on 2022/09/11.
//

#import <Foundation/Foundation.h>
#import "writerCell.h"


@implementation writerCell
@synthesize lbllevel, lblfollow, lblnickname, btnfollow, btnfollowing, imgprofile, viewlevel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
  
    return self;
}

@end
