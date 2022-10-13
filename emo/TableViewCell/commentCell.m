//
//  commentCell.m
//  emo
//
//  Created by choi hyoung jun on 2022/09/12.
//

#import <Foundation/Foundation.h>
#import "commentCell.h"


@implementation commentCell
@synthesize lbldate, lbllike, lblcomment, btnlike, btnmore, btnreply, imageView, imgprofile, imglike, imgcont, replyview, cont, imgheightcont, replycont;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
  
    return self;
}

@end
