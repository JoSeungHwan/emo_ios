//
//  faqCell.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/04.
//

#ifndef faqCell_h
#define faqCell_h

@class faqCell;

@protocol faqCellDelegate <NSObject>

-(void)faqCelllDidTapPurchaseButton:(faqCell *)cell;

@end

@interface faqCell : UITableViewCell {
    UILabel *lbltitle;
    UILabel *lblcontent;
    UIImageView *imgallow, *imgbg;
    UIButton *btnselect;
    UIView *contview;
}
@property (nonatomic, retain) IBOutlet UILabel *lbltitle, *lblcontent;
@property (nonatomic, retain) IBOutlet UIImageView *imgallow, *imgbg;
@property (nonatomic, retain) IBOutlet UIButton *btnselect;
@property (nonatomic, retain) IBOutlet UIView *contview;

- (IBAction)purchaseButtonDidTap:(id)sender;
@property (weak, nonatomic) id<faqCellDelegate> delegate;


+(NSString*)cellIdentifier;

@end

#endif /* faqCell_h */
