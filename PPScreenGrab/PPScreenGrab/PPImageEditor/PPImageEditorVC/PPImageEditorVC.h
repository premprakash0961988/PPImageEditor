//
//  PPImageEditorVC.h
//  PPScreenGrab
//
//  Created by Prem Chaurasiya on 22/11/14.
//  Copyright (c) 2014 ScreenGrab. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PPImageEditorDelegate <NSObject>
@required
-(void)dismissImageEditor;

@end


@interface PPImageEditorVC : UIViewController

@property(nonatomic, strong) id<PPImageEditorDelegate> imageEditorDelegate;

-(id)initWithView:(UIView*)view;
-(void)setRecipients:(NSArray*)recipients;
@end
