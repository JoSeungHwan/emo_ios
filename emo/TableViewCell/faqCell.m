//
//  faqCell.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/04.
//

#import <Foundation/Foundation.h>
#import "faqCell.h"

@implementation faqCell
@synthesize lbltitle, imgallow, lblcontent, imgbg, btnselect, contview;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contview.layer.cornerRadius = 5;
        self.contview.layer.borderColor = [[UIColor colorWithRed:(119.0/255.0f) green:(119.0/255.0f) blue:(119.0/255.0f) alpha:1] CGColor];
        self.contview.layer.borderWidth = 2;
    }
  
    return self;
}

+(NSString*)cellIdentifier{
    static NSString* cellIdentifier;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cellIdentifier = @"Content1";
    });
    return cellIdentifier;
}

- (IBAction)purchaseButtonDidTap:(id)sender
{
    [_delegate faqCelllDidTapPurchaseButton:self];
}

@end
