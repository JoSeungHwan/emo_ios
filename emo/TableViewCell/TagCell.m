//
//  TagCell.m
//  emo
//
//  Created by choi hyoung jun on 2022/09/11.
//

#import <Foundation/Foundation.h>
#import "TagCell.h"


@implementation TagCell
@synthesize lbltag;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
  
    return self;
}

@end
