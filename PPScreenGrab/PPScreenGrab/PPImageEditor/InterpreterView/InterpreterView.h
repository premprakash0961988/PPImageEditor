//
//  InterpreterView.h
//  PPScreenGrab
//
//  Created by Prem Chaurasiya on 23/11/14.
//  Copyright (c) 2014 ScreenGrab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InterpreterView : UIView

-(void)setCapturedImage:(UIImage*)image;
-(void)resetToDefault;
-(void)setDrawingColor:(UIColor*)color;
@end
