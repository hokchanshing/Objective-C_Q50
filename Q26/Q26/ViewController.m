//
//  ViewController.m
//  Q26
//
//  Created by 陳学誠 on 2019/08/19.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *resultLabel;

- (void)setData;
- (BOOL)firstTimeCheck;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self firstTimeCheck]) {
        self.resultLabel.text = @"初回起動です";
    } else {
        self.resultLabel.text = @"初回起動ではないです";
        [self setData];
        
    }
    
}


- (BOOL)firstTimeCheck {
    NSUserDefaults *userDefaults = NSUserDefaults.standardUserDefaults;
    
    if ([userDefaults objectForKey:@"firstTime"]) {
        return NO;
    }
    
    [userDefaults setBool:YES forKey:@"firstTime"];
    
    [userDefaults synchronize];
    return YES;
}


- (void)setData {
    NSUserDefaults *userDefaults = NSUserDefaults.standardUserDefaults;
    
    [userDefaults setInteger:1000 forKey:@"intKey"];
    [userDefaults setDouble:0.01 forKey:@"doubleKey"];
    [userDefaults setObject:@"happy" forKey:@"stringKey"];
    
    [userDefaults synchronize];
}

- (IBAction)tapBtn:(id)sender {
    
    NSUserDefaults *userDefaults = NSUserDefaults.standardUserDefaults;
    int intValue = (int)[userDefaults integerForKey:@"intKey"];
    double doubleValue = [userDefaults doubleForKey:@"doubleKey"];
    NSString *stringValue = [userDefaults stringForKey:@"stringKey"];
//    初回起動の場合
    if (!intValue && !doubleValue && !stringValue) {
        NSLog(@"初回起動のため、データをセットしていません。");
    } else {
        NSLog(@"int型：%d", intValue);
        NSLog(@"double型：%f", doubleValue);
        NSLog(@"string型：%@", stringValue);
    }
    
//    初回起動時以外の場合
    
    
}

@end
