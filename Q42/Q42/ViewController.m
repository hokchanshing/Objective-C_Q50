//
//  ViewController.m
//  Q42
//
//  Created by 陳学誠 on 2019/09/12.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"
#import "CameraViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    if ([defaults objectForKey:@"imageData"]) {
        NSData *imageData = [defaults objectForKey:@"imageData"];
        UIImage *image = [UIImage imageWithData:imageData];
        self.imageView.image = image;
    } 
}

- (IBAction)openCameraBtnTap:(id)sender {
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Second" bundle:nil];
    CameraViewController *cameraViewController = [secondStoryBoard instantiateInitialViewController];
    [self presentViewController:cameraViewController animated:YES completion:nil];
}

@end
