//
//  ViewController.m
//  Q40
//
//  Created by 陳学誠 on 2019/09/04.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnTap:(id)sender {
    
    MFMailComposeViewController *mailViewController = [MFMailComposeViewController new];
    
    mailViewController.mailComposeDelegate = self;
    
    NSString *subject = [NSBundle.mainBundle localizedStringForKey:@"subject" value:nil table:@"Localizable"];
    NSString *body = [NSBundle.mainBundle localizedStringForKey:@"body" value:nil table:@"Localizable"];
    
    [mailViewController setSubject:subject];
    [mailViewController setMessageBody:body isHTML:NO];
    
    [self presentViewController:mailViewController animated:YES completion:nil];
    
}

@end
