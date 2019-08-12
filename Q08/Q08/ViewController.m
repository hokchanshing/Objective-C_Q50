//
//  ViewController.m
//  Q08
//
//  Created by 陳学誠 on 2019/08/02.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property NSArray *imageList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageList = @[@"cafe", @"driver", @"reporter", @"staff", @"tantei"];
}

- (IBAction)changeBackgroundBtn:(id)sender {
    int randomCount = arc4random_uniform((int)self.imageList.count);
    self.backgroundImageView.image = [UIImage imageNamed: self.imageList[randomCount]];
}

@end
