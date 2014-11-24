//
//  InterpreterView.m
//  PPScreenGrab
//
//  Created by Prem Chaurasiya on 23/11/14.
//  Copyright (c) 2014 ScreenGrab. All rights reserved.
//

#import "InterpreterView.h"
#import "DrawableView.h"

@interface InterpreterView ()
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) DrawableView *drawableView;
@end

@implementation InterpreterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addDrawableView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addDrawableView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addDrawableView];
    }
    return self;
}

-(void)addDrawableView {
    _drawableView = [[DrawableView alloc] init];
    [self addSubview:_drawableView];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [_drawableView setFrame:self.bounds];
    [self bringSubviewToFront:_drawableView];
}


#pragma Image Setting

-(void)setCapturedImage:(UIImage*)image {
    [self.imageView setImage:image];
}

-(UIImageView*)imageView {
    if(!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [_imageView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_imageView];
        [self sendSubviewToBack:_imageView];
    }
    return _imageView;
}

-(void)resetToDefault {
    [_drawableView resetToDefault];
}

-(void)setDrawingColor:(UIColor*)color {
    [_drawableView setDrawingColor:color];
}

@end
