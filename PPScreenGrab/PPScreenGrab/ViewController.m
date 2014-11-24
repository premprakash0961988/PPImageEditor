//
//  ViewController.m
//  PPScreenGrab
//
//  Created by Prem Chaurasiya on 21/11/14.
//  Copyright (c) 2014 ScreenGrab. All rights reserved.
//

#import "ViewController.h"
#import "PPImageEditorVC.h"
@interface ViewController ()<PPImageEditorDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(IBAction)doyyb{
    PPImageEditorVC *_ppImageEditorVC = [[PPImageEditorVC alloc] init];
    _ppImageEditorVC.imageEditorDelegate = self;
    [self.navigationController pushViewController:_ppImageEditorVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissImageEditor {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
