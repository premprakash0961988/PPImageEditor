//
//  ColorPickerViewController.h
//  PPScreenGrab
//
//  Created by Prem Chaurasiya on 25/11/14.
//  Copyright (c) 2014 ScreenGrab. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorPickerDelegate <NSObject>
-(void)colorSuccessfullySelected:(UIColor*)color;
-(void)colorSelectionCancelled;
@end

@interface ColorPickerViewController : UIViewController

@property(nonatomic, strong) id <ColorPickerDelegate> delegate;

-(void)setBackgroundImage:(UIImage*)bgImage;
@end
