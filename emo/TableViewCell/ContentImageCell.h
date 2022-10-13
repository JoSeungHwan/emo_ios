//
//  ContentImageCell.h
//  emo
//
//  Created by choi hyoung jun on 2022/09/11.
//

#ifndef ContentImageCell_h
#define ContentImageCell_h

@interface ContentImageCell : UICollectionViewCell {
    UIImageView *imgContent, *imgmulti;
}

@property (nonatomic, retain) IBOutlet UIImageView *imgContent, *imgmulti;

@end

#endif /* ContentImageCell_h */
