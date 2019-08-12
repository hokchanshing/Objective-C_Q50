//
//  SecondViewController.m
//  Q24
//
//  Created by hschan on 2019/08/12.
//  Copyright © 2019 hschan. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.resultLabel.text = self.passMessage;
}

- (IBAction)backBtnTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
