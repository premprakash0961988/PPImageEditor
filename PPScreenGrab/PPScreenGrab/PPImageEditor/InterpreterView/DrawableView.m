//
//  DrawableView.m
//  PPScreenGrab
//
//  Created by Prem Chaurasiya on 23/11/14.
//  Copyright (c) 2014 ScreenGrab. All rights reserved.
//

#import "DrawableView.h"

#define DEFAUT_DRAWING_COLOR [UIColor blackColor]

@interface DrawableView () {
    CGPoint pts[5];
    uint ctr;
}
@property(nonatomic, strong) NSMutableDictionary *colorPathKeyValues;
@property(nonatomic, strong) UIBezierPath *path;
@property(nonatomic, strong) UIColor *drawingColor;
@property(nonatomic, strong) UIImage *incrementalImage;
@end

@implementation DrawableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        _drawingColor = DEFAUT_DRAWING_COLOR;
        _colorPathKeyValues = [[NSMutableDictionary alloc] init];
        [self setDrawingColor:[UIColor blackColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [_incrementalImage drawInRect:rect];
}

-(void)resetToDefault {
    _incrementalImage = nil;
    [self setNeedsDisplay];
}


#pragma mark--
#pragma Touches Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [_path removeAllPoints];
    [self.path moveToPoint:p];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    if(ctr == 0) {
        pts[0] = pts[1] = pts[2] =pts[3] = pts[4] = p;
    }
    ctr++;
    pts[ctr] = p;
    if (ctr == 4)
    {
        pts[3] = CGPointMake((pts[2].x + pts[4].x)/2.0, (pts[2].y + pts[4].y)/2.0); // move the endpoint to the middle of the line joining the second control point of the first Bezier segment and the first control point of the second Bezier segment
        
        [self.path moveToPoint:pts[0]];
        [self.path addCurveToPoint:pts[3] controlPoint1:pts[1] controlPoint2:pts[2]]; // add a cubic Bezier from pt[0] to pt[3], with control points pt[1] and pt[2]
        
        [self drawBitmap];
        [self setNeedsDisplay];
        // replace points and get ready to handle the next segment
        pts[0] = pts[3];
        pts[1] = pts[4];
        ctr = 1;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self drawBitmap];
    [self setNeedsDisplay];
    [self.path removeAllPoints];
    ctr = 0;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
    [self.path removeAllPoints];
}

-(void)setDrawingColor:(UIColor*)color {
    _drawingColor = color;
}

-(UIBezierPath*)path {
    if(!_path) {
        _path = [UIBezierPath bezierPath];
        [_path setLineWidth:2.0];
    }
    return _path;
}



- (void)drawBitmap
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    if (!self.incrementalImage)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.superview.layer renderInContext:context];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        [[UIColor colorWithPatternImage:image] setFill];
    }
    [_drawingColor setStroke];
    [self.incrementalImage drawAtPoint:CGPointZero];
    [self.path stroke];
    self.incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}



@end
