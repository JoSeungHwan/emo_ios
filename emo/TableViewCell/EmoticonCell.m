//
//  EmoticonCell.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/08.
//

#import <Foundation/Foundation.h>
#import "EmoticonCell.h"


@implementation EmoticonCell
@synthesize lblcont, lblname, lblnickname, lbllikecount, imgcont, imageView, btnlike, btnmore, imglike, nickview;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
  
    return self;
}

@end
