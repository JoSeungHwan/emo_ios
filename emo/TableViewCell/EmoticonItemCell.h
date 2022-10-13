//
//  EmoticonItemCell.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/08.
//

#ifndef EmoticonItemCell_h
#define EmoticonItemCell_h

@interface EmoticonItemCell : UICollectionViewCell {
    UIImageView *imgContent;
    UIView *contView;
}

@property (nonatomic, retain) IBOutlet UIImageView *imgContent;
@property (nonatomic, retain) IBOutlet UIView *contView;

@end

#endif /* EmoticonItemCell_h */
