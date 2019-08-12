//
//  ViewController.m
//  OC_Q50_02
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
    // Do any additional setup after loading the view.
    NSArray *nsAr = [NSArray arrayWithObjects:@"東京", @"名古屋", @"大阪", nil];
    NSDictionary *nsDic = [NSDictionary dictionaryWithObject:@"hoge" forKey:@"Key"];
    
    NSLog(@"NSArray: %@、%@、%@", nsAr[0], nsAr[1], nsAr[2]);
    NSLog(@"NSDictionary: %@", nsDic);
    
}


@end
