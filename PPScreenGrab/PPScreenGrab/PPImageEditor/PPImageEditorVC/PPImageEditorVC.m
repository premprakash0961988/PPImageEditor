//
//  PPImageEditorVC.m
//  PPScreenGrab
//
//  Created by Prem Chaurasiya on 22/11/14.
//  Copyright (c) 2014 ScreenGrab. All rights reserved.
//

#import "PPImageEditorVC.h"
#import "PPScreenGraber.h"
#import "InterpreterView.h"
#import <MessageUI/MessageUI.h>
#import "ColorPickerView.h"
#import "ColorPickerViewController.h"

#define OPTIONS_TITLE @"Choose Options"

@interface PPImageEditorVC ()<ColorPickerDelegate,MFMailComposeViewControllerDelegate, UIActionSheetDelegate>
@property(nonatomic, strong) InterpreterView *interpreterView;
@property(nonatomic, strong) NSArray *recipientList;
@property(nonatomic, strong) NSString *defaultSubject;
@end

@implementation PPImageEditorVC {
    NSArray *options;
}


-(id)init {
    self = [super init];
    if(self){
        [self.interpreterView setCapturedImage:[self captureView:nil]];
    }
    return self;
}

-(id)initWithView:(UIView*)view {
    self = [super init];
    if(self){
        [self.interpreterView setCapturedImage:[self captureView:view]];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBarButtons];
    options = @[@"Share Image",@"Choose Color",@"Reset",@"Cancel"];
}


-(UIImage*)captureView:(UIView*)view {
    if(!view) {
        view = [[[UIApplication sharedApplication] delegate] window];
    }
    UIImage *capturedImage = [PPScreenGraber grabView:view];
    return capturedImage;
}


-(void)addBarButtons {
    UIBarButtonItem *optionsItem = [[UIBarButtonItem alloc] initWithTitle:@"Options" style:UIBarButtonItemStylePlain target:self action:@selector(showEditingOptions)];
    self.navigationItem.rightBarButtonItems = @[optionsItem];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(removePPImageEditorVC)];
    self.navigationItem.leftBarButtonItems = @[cancelItem];
}

-(InterpreterView*)interpreterView {
    if(!_interpreterView) {
        _interpreterView = [[InterpreterView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_interpreterView];
    }
    return _interpreterView;
}


-(void)removePPImageEditorVC {
    if([_imageEditorDelegate respondsToSelector:@selector(dismissImageEditor)]) {
        [_imageEditorDelegate dismissImageEditor];
    }
}

-(void)showEditingOptions {
    if ([UIAlertController class]) {
        [self presentAlertController];
    }
    else {
        [self presentActionSheet];
    }
}

-(void)presentAlertController {
    __weak InterpreterView *weakInterpreterView = _interpreterView;
    __weak PPImageEditorVC *weakSelf = self;
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:OPTIONS_TITLE
                                          message:@""
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    

    
    UIAlertAction *shareAction = [UIAlertAction
                                  actionWithTitle:NSLocalizedString(options[0], @"Share Image action")
                                  style:UIAlertActionStyleDestructive
                                  handler:^(UIAlertAction *action)
                                  {
                                      [weakSelf shareAction];
                                      NSLog(@"Share Image action");
                                  }];
    
    
    UIAlertAction *chooseColorAction = [UIAlertAction
                                        actionWithTitle:NSLocalizedString(options[1], @"Choose Color action")
                                        style:UIAlertActionStyleDestructive
                                        handler:^(UIAlertAction *action)
                                        {
                                            [weakSelf showColorPickerController];
                                            NSLog(@"Choose Color action");
                                        }];
    
    
    UIAlertAction *resetAction = [UIAlertAction
                                  actionWithTitle:NSLocalizedString(options[2], @"Reset action")
                                  style:UIAlertActionStyleDestructive
                                  handler:^(UIAlertAction *action)
                                  {
                                      [weakInterpreterView resetToDefault];
                                      NSLog(@"Reset action");
                                  }];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(options[3], @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    
    
    [alertController addAction:shareAction];
    [alertController addAction:chooseColorAction];
    [alertController addAction:resetAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)presentActionSheet {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:OPTIONS_TITLE delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"" otherButtonTitles:options[0],options[1],options[2],nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self shareAction];
            break;
        case 2: {
            [self showColorPickerController];
        }
            break;
        case 3:
            [_interpreterView resetToDefault];
            break;
            
        default:
            break;
    }
}

-(void)showColorPickerController {
    ColorPickerViewController *colorPickerVC = [[ColorPickerViewController alloc] init];
    UIImage *bgImage = [PPScreenGraber grabView:self.navigationController.view];
    colorPickerVC.delegate = self;
    UINavigationController *navVC = [[ UINavigationController alloc] initWithRootViewController:colorPickerVC];
    [self.navigationController presentViewController:navVC animated:YES completion:nil];
    [colorPickerVC setBackgroundImage:bgImage];

}

#pragma mark--
#pragma Color Picker Delegate

-(void)colorSuccessfullySelected:(UIColor*)color {
    [_interpreterView setDrawingColor:color];
}

-(void)colorSelectionCancelled {
    
}

#pragma Share Action

-(void)setRecipients:(NSArray*)recipients {
    _recipientList = recipients;
}

-(void)setDefaultSubject:(NSString *)defaultSubject {
    _defaultSubject = defaultSubject;
}

-(void)shareAction {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        
        NSMutableString *emailBody = [[NSMutableString alloc] initWithString:@"<html><body>"];
        [emailBody appendString:@"<p>Feedback</p>"];
        UIImage *image = [PPScreenGraber grabView:self.view];
        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
        NSString *base64String = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [emailBody appendString:[NSString stringWithFormat:@"<p><b><img src='data:image/png;base64,%@'></b></p>",base64String]];
        [emailBody appendString:@"</body></html>"];
        [picker setMessageBody:emailBody isHTML:YES];
        if (_recipientList) {
            [picker setToRecipients:_recipientList];
        }
        
        if (_defaultSubject) {
            [picker setSubject:_defaultSubject];
        }
        
        [self presentViewController:picker animated:YES completion:^{}];
    }
}








@end
