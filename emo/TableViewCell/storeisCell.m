//
//  storeisCell.m
//  emo
//
//  Created by choi hyoung jun on 2022/09/26.
//

#import <Foundation/Foundation.h>
#import "storiesCell.h"

@implementation storiesCell
@synthesize lblcontent;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
  
    return self;
}

@end
