//
//  ViewController.m
//  Q39
//
//  Created by 陳学誠 on 2019/09/06.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong)UIDocumentInteractionController* docController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)postInstaBtn:(id)sender {
    
    UIImage *image = [UIImage imageNamed:@"sample"];
    NSString *imagePath = [NSString stringWithFormat:@"%@/image.igo", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
    self.docController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:imagePath]];
    
    self.docController.delegate = self;
    self.docController.UTI = @"com.instagram.exclusivegram";
    [self.docController presentOpenInMenuFromRect:self.view.frame inView:self.view animated:YES];
    
    
    
}

@end
