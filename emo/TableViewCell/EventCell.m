//
//  EventCell.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/04.
//

#import <Foundation/Foundation.h>
#import "EventCell.h"

@implementation EventCell
@synthesize lbltitle, lbldate, lblcontent, lbltype, lbllikecount , imgcont, imglike, typeview, btnlike;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
  
    return self;
}

@end
