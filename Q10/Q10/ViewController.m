//
//  ViewController.m
//  Q10
//
//  Created by 陳学誠 on 2019/08/02.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property UIAlertController * alertController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.alertController = [UIAlertController alertControllerWithTitle:@"共有" message:@"SNSに共有" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * facebookAction = [UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        NSLog(@"Facebookが押されました。");
    }];
    
    UIAlertAction * twitterAction = [UIAlertAction actionWithTitle:@"Twitter" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        NSLog(@"Twitterが押されました。");
    }];
    
    UIAlertAction * lineAction = [UIAlertAction actionWithTitle:@"Line" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        NSLog(@"Lineが押されました。");
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action){
        NSLog(@"キャンセルが押されました。");
    }];
    
    [self.alertController addAction:facebookAction];
    [self.alertController addAction:twitterAction];
    [self.alertController addAction:lineAction];
    [self.alertController addAction:cancelAction];
    
}

- (IBAction)actionSheetbtn:(id)sender {
    [self presentViewController:self.alertController animated:YES completion:nil];
}

@end
