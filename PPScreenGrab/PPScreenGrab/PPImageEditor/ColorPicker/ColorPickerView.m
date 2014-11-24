//
//  ColorPickerActionSheet.m
//  PPScreenGrab
//
//  Created by Prem Chaurasiya on 24/11/14.
//  Copyright (c) 2014 ScreenGrab. All rights reserved.
//

#import "ColorPickerView.h"
#import "PPScreenGraber.h"
#import "UIImage+ImageEffects.h"
#define SLIDER_HEIGHT 23

#define RED_SLIDER   100
#define GREEN_SLIDER 101
#define BLUE_SLIDER  102


@implementation ColorPickerView {
    float *components;
    UISlider *redSlider;
    UISlider *greenSlider;
    UISlider *blueSlider;
    UIView *derivedColorHolderView;
}


-(void)setBackgroundImage:(UIImage*)image {
    [self setBackgroundColor:[UIColor colorWithPatternImage:[image applyLightEffect]]];
}

-(void)configureOptions {
    components = (float *)malloc(sizeof(float) * 3);
    [self addRGBSliders];
}

-(void)addRGBSliders {
    CGFloat padding =  20;
    CGFloat viewHeight = 200;
    CGFloat yOrigin = CGRectGetHeight(self.frame) - 3*SLIDER_HEIGHT  - viewHeight - 7*padding;
    CGFloat width = CGRectGetWidth(self.frame) - 2*padding;
    
    CGRect frame = CGRectMake((CGRectGetWidth(self.frame) - viewHeight)/2 , yOrigin, viewHeight, viewHeight);
    derivedColorHolderView = [[UIView alloc] initWithFrame:frame];
    [[derivedColorHolderView layer] setCornerRadius:viewHeight/2];
    [[derivedColorHolderView layer] setMasksToBounds:YES];
    [self addSubview:derivedColorHolderView];
    yOrigin += viewHeight + 3*padding;

    redSlider = [[UISlider alloc] initWithFrame:CGRectMake(padding, yOrigin, width, SLIDER_HEIGHT)];
    [redSlider setMaximumTrackTintColor:[UIColor redColor]];
    [redSlider setTag:RED_SLIDER];
    [redSlider setMinimumTrackTintColor:[UIColor lightGrayColor]];
    [redSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:redSlider];
    yOrigin += SLIDER_HEIGHT + padding;
    
    
    greenSlider = [[UISlider alloc] initWithFrame:CGRectMake(padding, yOrigin, width, SLIDER_HEIGHT)];
    [greenSlider setTag:GREEN_SLIDER];
    [greenSlider setMaximumTrackTintColor:[UIColor greenColor]];
    [greenSlider setMinimumTrackTintColor:[UIColor lightGrayColor]];
    [greenSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:greenSlider];
    yOrigin += SLIDER_HEIGHT + padding;
    
    blueSlider = [[UISlider alloc] initWithFrame:CGRectMake(padding, yOrigin, width, SLIDER_HEIGHT)];
    [blueSlider setTag:BLUE_SLIDER];
    [blueSlider setMaximumTrackTintColor:[UIColor blueColor]];
    [blueSlider setMinimumTrackTintColor:[UIColor lightGrayColor]];
    [blueSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:blueSlider];
    yOrigin += SLIDER_HEIGHT + padding;
    
    [self setDefaultValues];
}

-(void)setDefaultValues {
    CGFloat initialValue = 0.5f;
    [redSlider   setValue:initialValue animated:NO];
    [greenSlider setValue:initialValue animated:NO];
    [blueSlider  setValue:initialValue animated:NO];
    components[0] = components[1] = components[2] =  initialValue;
    [derivedColorHolderView setBackgroundColor:[UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:1]];
}


- (IBAction)sliderValueChanged:(UISlider*)slider
{
    NSInteger tag = slider.tag;
    switch (tag) {
        case RED_SLIDER:
            components[0] = slider.value;
            break;
        case GREEN_SLIDER:
            components[1] = slider.value;
            break;
        case BLUE_SLIDER:
            components[2] = slider.value;
            break;
            
        default:
            break;
    }
    [derivedColorHolderView setBackgroundColor:[UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:1]];
}

-(UIColor*)getSelectedColor {
    return derivedColorHolderView.backgroundColor;
}

@end
