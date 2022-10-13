//
//  notiCell.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/03.
//

#import <Foundation/Foundation.h>
#import "notiCell.h"

@implementation notiCell
@synthesize lbltitle, lbldate, lblcontent;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
  
    return self;
}

@end
