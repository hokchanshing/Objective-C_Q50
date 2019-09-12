//
//  ViewController.m
//  Q44
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

//- (BOOL)shouldAutorotate {
//    return NO;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskPortrait;
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    if ([defaults objectForKey:@"imageData"]) {
        NSData *imageData = [defaults objectForKey:@"imageData"];
        UIImage *image = [UIImage imageWithData:imageData];
        [self addfilter:image];
    }
}

- (void)addfilter:(UIImage* )image {
    CIImage *filteredImage = [[CIImage alloc]initWithCGImage:image.CGImage];

    CIFilter *filter =[CIFilter filterWithName:@"CIMinimumComponent"];
    [filter setValue:filteredImage forKey:@"inputImage"];
    
    filteredImage = filter.outputImage;
    
    // CIImageをUIImageに変換する
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [ciContext createCGImage:filteredImage
                                          fromRect:[filteredImage extent]];
    UIImage *outputImage  = [UIImage imageWithCGImage:imageRef
                                                scale:1.0f
                                          orientation:UIImageOrientationRight];
    CGImageRelease(imageRef);
    
    self.imageView.image = outputImage;
}

- (IBAction)openCameraBtnTap:(id)sender {
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Second" bundle:nil];
    CameraViewController *cameraViewController = [secondStoryBoard instantiateInitialViewController];
    [self presentViewController:cameraViewController animated:YES completion:nil];
}

@end

