//
//  WeatherDataViewController.m
//  Q35
//
//  Created by 陳学誠 on 2019/09/04.
//  Copyright © 2019 sample. All rights reserved.
//

#import "WeatherDataViewController.h"
#import "ViewController.h"

@interface WeatherDataViewController ()

@end

static NSString *const DateFormat = @"yyyy/MM/dd";


@implementation WeatherDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)registerAction {
    
    ViewController *viewController = [ViewController new];
    FMDatabase *db =[viewController connectDatabase:AccessDatabaseName];
    
}


@end
