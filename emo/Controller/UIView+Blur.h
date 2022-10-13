//
//  UIView+Blur.h
//  emo
//
//  Created by choi hyoung jun on 2022/10/08.
//

#ifndef UIView_Blur_h
#define UIView_Blur_h
#import <UIKit/UIKit.h>

@interface UIView (Blur)

+(UIImage*)createBlurredImageFromView:(UIView*)view;

@end

#endif /* UIView_Blur_h */
