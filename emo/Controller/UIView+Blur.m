//
//  UIView+Blur.m
//  emo
//
//  Created by choi hyoung jun on 2022/10/08.
//

#import <Foundation/Foundation.h>
#import "UIView+Blur.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Blur)

+(UIImage*)createBlurredImageFromView:(UIView*)view
{
    //Get a UIImage from the UIView
    CGSize size = view.bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //Blur the UIImage
    CIImage *imageToBlur = [CIImage imageWithCGImage:viewImage.CGImage];
    
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlurFilter setValue:imageToBlur forKey: @"inputImage"];
    [gaussianBlurFilter setValue:[NSNumber numberWithFloat: 10] forKey: @"inputRadius"];
    CIImage *bluredImage = [gaussianBlurFilter valueForKey: @"outputImage"];
    
    CIFilter *cropFilter = [CIFilter filterWithName:@"CICrop"];
    [cropFilter setValue:bluredImage forKey:@"inputImage"];
    CIVector *cropRect = [CIVector vectorWithX:0.0 Y:0.0 Z:size.width W:size.height];
    [cropFilter setValue:cropRect forKey:@"inputRectangle"];
    CIImage *croppedImage = [cropFilter valueForKey:@"outputImage"];
    
    UIImage *endImage = [[UIImage alloc] initWithCIImage:croppedImage];
    
    return endImage;
}

@end
