//
//  ColorPickerActionSheet.h
//  PPScreenGrab
//
//  Created by Prem Chaurasiya on 24/11/14.
//  Copyright (c) 2014 ScreenGrab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorPickerView : UIView
-(void)configureOptions;
-(void)setBackgroundImage:(UIImage*)image;
-(UIColor*)getSelectedColor;
@end
