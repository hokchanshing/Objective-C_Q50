//
//  ViewController.m
//  OC_Q50_01
//
//  Created by hschan on 2019/07/13.
//  Copyright © 2019 hschan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BOOL hoge = YES;
    NSString *nsStr = @"ほげ";
    NSInteger nsInt = 3;
    NSNumber *nsNum = [NSNumber numberWithInt:2147483647];
    
    NSLog(@"BOOL型: %@",(hoge ? @"YES":@"NO"));
    NSLog(@"NSString型: %@", nsStr);
    NSLog(@"NSInteger型: %ld", nsInt);
    NSLog(@"NSNumber型: %ld", [nsNum integerValue]);
  
    
    // Do any additional setup after loading the view.
}


@end
