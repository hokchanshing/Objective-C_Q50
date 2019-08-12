//
//  ViewController.m
//  Q23
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

- (IBAction)pushSecondViewController:(id)sender {
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Second" bundle:nil];
    SecondViewController *secondViewController = [secondStoryBoard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    
    [self.navigationController pushViewController:secondViewController animated:YES];
}

@end
