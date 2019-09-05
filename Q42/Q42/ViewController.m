//
//  ViewController.m
//  Q42
//
//  Created by 陳学誠 on 2019/09/04.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)presentCameraBtn:(id)sender {
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Second" bundle:nil];
    CameraViewController *cameraCiewController = [secondStoryBoard instantiateInitialViewController];
    [self presentViewController:cameraCiewController animated:YES completion:nil];
}

@end
