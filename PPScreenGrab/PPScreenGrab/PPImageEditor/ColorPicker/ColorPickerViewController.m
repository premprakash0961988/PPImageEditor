//
//  ColorPickerViewController.m
//  PPScreenGrab
//
//  Created by Prem Chaurasiya on 25/11/14.
//  Copyright (c) 2014 ScreenGrab. All rights reserved.
//

#import "ColorPickerViewController.h"
#import "ColorPickerView.h"

@interface ColorPickerViewController ()

@end

@implementation ColorPickerViewController

- (void)loadView {
    self.view = [[ColorPickerView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [(ColorPickerView*)self.view configureOptions];
    [self addBarButtons];
}

-(void)setBackgroundImage:(UIImage*)bgImage {
    ColorPickerView* view  = (ColorPickerView*)self.view;
    [view setBackgroundImage:bgImage];
    
}


-(void)addBarButtons {
    UIBarButtonItem *optionsItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonTapped:)];
    self.navigationItem.rightBarButtonItems = @[optionsItem];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTapped:)];
    self.navigationItem.leftBarButtonItems = @[cancelItem];
}

-(void)doneButtonTapped:(id)sender {
    ColorPickerView* view  = (ColorPickerView*)self.view;
    UIColor *selectedColor = [view getSelectedColor];
    if([self.delegate respondsToSelector:@selector(colorSuccessfullySelected:)])
        [self.delegate colorSuccessfullySelected:selectedColor];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)cancelButtonTapped:(id)sender {
    if([self.delegate respondsToSelector:@selector(colorSelectionCancelled)])
        [self.delegate colorSelectionCancelled];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


@end
