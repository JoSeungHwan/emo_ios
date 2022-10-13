//
//  ContentCell.m
//  emo
//
//  Created by user225901 on 8/25/22.
//

#import <Foundation/Foundation.h>
#import "ContentCell.h"


@implementation ContentCell
@synthesize lbldate, lbltype, lblcontent, lblnickname, lbllikecount, lblreplycount, imglike, imgtype, imgprofile, scrollView, btnlike, btnmore, btnimg;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    scrollView.backgroundColor = [UIColor orangeColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentInset = UIEdgeInsetsZero;
    scrollView.pagingEnabled = NO;
    scrollView.clipsToBounds = NO;
    scrollView.bounces = NO;
    scrollView.delegate = self;
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

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    [self changeTheCardStatus:scrollView];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self changeTheCardStatus:scrollView];

}


-(void)changeTheCardStatus:(UIScrollView *)scrollView{

    for (UIView *view in scrollView.subviews) {
        if (view.tag == 9999) {
            [_subviewsCenterArray addObject:@(view.center.x)];
        }

    }



    CGFloat currentCenterOffsetX = scrollView.contentOffset.x + CGRectGetWidth(self.contentView.frame)/2.0;

    NSMutableArray *absoluteValueArray = [NSMutableArray array];
    NSMutableDictionary *absoluteValueDictionary = [NSMutableDictionary dictionary];
    for (int i  = 0; i < _subviewsCenterArray.count; i ++) {
        float subviewsCenterPointX = [_subviewsCenterArray[i] floatValue];
        double  absolute = fabs(subviewsCenterPointX - currentCenterOffsetX);
        [absoluteValueArray addObject:@(absolute)];
        [absoluteValueDictionary setValue:@(subviewsCenterPointX) forKey:[NSString stringWithFormat:@"%f",absolute]];
    }


    [absoluteValueArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {

        double a = [obj1 doubleValue];
        double b = [obj2 doubleValue];
        if (a>b) {
            return NSOrderedDescending;
        }
        else if (a<b){
            return NSOrderedAscending;
        }
        else{
            return NSOrderedSame;
        }

    }];


    double shortValue = [absoluteValueArray.firstObject doubleValue];
    double centerX = [[absoluteValueDictionary objectForKey:[NSString stringWithFormat:@"%f",shortValue]] doubleValue];
    [UIView animateWithDuration:0.25 animations:^{
        scrollView.contentOffset = CGPointMake(centerX - CGRectGetWidth(self.contentView.frame)/2.0, 0);

    }];

}


@end
