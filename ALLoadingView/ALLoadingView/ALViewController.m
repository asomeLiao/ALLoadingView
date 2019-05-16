//
//  ALViewController.m
//  ALLoadingView
//
//  Created by asml on 2018/4/25.
//  Copyright © 2018年 asm. All rights reserved.
//

#import "ALViewController.h"

@interface ALViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ALViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.btn addGestureRecognizer:pan];
}
- (IBAction)slider:(UISlider*)sender {
    self.height.constant = sender.value*150;
}

- (void) pan:(UIPanGestureRecognizer*)pan {
    CGPoint point = [pan translationInView:pan.view];
    NSLog(@"pont %@",NSStringFromCGPoint(point));
    self.height.constant = point.y/2.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
