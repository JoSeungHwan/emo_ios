//
//  MyEmoticonCell.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/10.
//

#import <Foundation/Foundation.h>
#import "MyEmoticonCell.h"


@implementation MyEmoticonCell
@synthesize lblcont, lblname, lbllikecount, imgcont, imageView, btnlike, btnmore, imglike, statusview, lblstatus;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
  
    return self;
}

@end
