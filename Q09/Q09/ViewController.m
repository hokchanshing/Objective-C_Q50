//
//  ViewController.m
//  Q09
//
//  Created by 陳学誠 on 2019/08/02.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property UIAlertController *alertController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.alertController = [UIAlertController
                            alertControllerWithTitle:@"アラート"
                            message:@"アラートが表示されました。"
                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelButton = [UIAlertAction
                                   actionWithTitle:@"キャンセル"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       NSLog(@"キャンセルボタンが押されました。");
                                   }];

    UIAlertAction *okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   NSLog(@"OKボタンが押されました。");
                               }];
    

    [self.alertController addAction:cancelButton];
    [self.alertController addAction:okButton];
}

- (IBAction)tapBtn:(id)sender {
    [self presentViewController:self.alertController animated:YES completion:nil];
}

@end
