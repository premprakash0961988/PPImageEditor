//
//  PPScreenGraber.m
//  PPScreenGrab
//
//  Created by Prem Chaurasiya on 21/11/14.
//  Copyright (c) 2014 ScreenGrab. All rights reserved.
//

#import "PPScreenGraber.h"

@implementation PPScreenGraber

+(UIImage*)imageForLayer:(CALayer*)layer {
    CGRect rect = [[UIScreen mainScreen] bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+(UIImage*)grabView:(UIView*)view {
    CALayer *layer = nil;
    if(!view)
        layer = [[[UIApplication sharedApplication] delegate] window].layer;
    else
        layer = view.layer;
    
    return [self imageForLayer:view.layer];
}




@end
