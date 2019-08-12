//
//  ViewController.m
//  Q22
//
//  Created by hschan on 2019/08/12.
//  Copyright © 2019 hschan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)presentSecondViewController:(id)sender {
    
    UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"Second" bundle:nil];
    SecondViewController *secondViewController = [secondStoryboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    
    [self presentViewController:secondViewController animated:YES completion:nil];
    
}

@end
