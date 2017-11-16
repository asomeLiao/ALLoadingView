//
//  ViewController.m
//  ALLoadingView
//
//  Created by asm.L on 2017/11/16.
//  Copyright © 2017年 asm. All rights reserved.
//

#import "ViewController.h"
#import "ALLoadingView.h"
@interface ViewController ()
@property(nonatomic, weak) IBOutlet ALLoadingView *lview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)btnAction:(UIButton *)sender {
    NSString *title = sender.titleLabel.text;
    if ([title containsString:@"load"]) {
        [self.lview start];
    }else if ([title containsString:@"success"]) {
        [self.lview endAnimationWithResult:ALLoadingViewResultTypeSuccess];
    }else if ([title containsString:@"error"]) {
        [self.lview endAnimationWithResult:ALLoadingViewResultTypeError];
    }else if ([title containsString:@"Mark"]) {
        [self.lview endAnimationWithResult:ALLoadingViewResultTypeExclamationMark];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
