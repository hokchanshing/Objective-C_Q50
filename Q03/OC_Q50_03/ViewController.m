//
//  ViewController.m
//  OC_Q50_03
//
//  Created by hschan on 2019/07/14.
//  Copyright © 2019 hschan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    if文、if〜else文、if〜else if文、三項演算子、for文、高速列挙構文、switchを利用したプログラムを作成し、結果をコンソールに出力する。
    
    NSInteger nsInt = -1;
    NSString *sankouString = @"sankou演算子";
//    三項演算子
    NSString *isSankou = [sankouString  isEqual: @"三項演算子"] ? @"sankou": @"notSankou";
    NSArray *nsAr = [NSArray arrayWithObjects:@"東京", @"名古屋", @"大阪", nil];
    
//    if文、if〜else文、if〜else if文
    NSLog(@"nsIntの値: %ld", nsInt);
    if (nsInt > 0) {
        NSLog(@"nsIntは0より大きい");
    } else if(nsInt == 0) {
        NSLog(@"nsIntは0");
    } else {
        NSLog(@"nsIntは0より小さい");
    }
    
    
    if ([isSankou  isEqual: @"sankou"]){
        NSLog(@"sankouStringの値は三項演算子");
    } else {
        NSLog(@"sankouStringの値は三項演算子ではない");
    }
    
    
//    for文
    for(int i=1; i<6; i++){
        NSLog(@"第%d回目", i);
    }
    
    
//    高速列挙文
    for(NSString *str in nsAr){
        NSLog(@"%@", str);
    }
    
    
//    switch文
    switch(nsInt){
        case 1:
            NSLog(@"nsIntの値は1");
            break;
        
        case -1:
            NSLog(@"nsIntの値は-1");
            break;
        
        default:
            NSLog(@"nsIntは1と−1ではない");
            break;
    }
    
    
}


@end
