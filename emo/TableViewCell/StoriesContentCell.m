//
//  StoriesContentCell.m
//  emo
//
//  Created by user225901 on 8/25/22.
//

#import <Foundation/Foundation.h>
#import "StoriesContentCell.h"

@implementation StoriesContentCell
@synthesize lbltype, lblcontent, scrollView, btnmore, btnreplydraw;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
 
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
 
    // Configure the view for the selected state
}
 
+ (NSString *)reuseIdentifier {
    return @"CustomCellIdentifier";
}

@end
