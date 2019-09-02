//
//  ViewController.m
//  Q33
//
//  Created by 陳学誠 on 2019/09/02.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking/AFNetworking.h"

@interface ViewController ()
//プロパティ
@property (strong, nonatomic) UIAlertController *alertController;

//メソッド
- (void)setAlertController;
- (UIAlertAction *)selectTodayAction;
- (UIAlertAction *)selectTomorrowAction;
- (UIAlertAction *)selectDayAfterTomorrowAction;
- (UIAlertAction *)selectCancelAction;
@end

static NSString *const weatherApiUrl = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=400040";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAlertController];
}

- (void)setAlertController{
    self.alertController = [UIAlertController alertControllerWithTitle:@"いつの天気を知りたいか？"
                                        message:@"ボタンを押してください。"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
   [self.alertController addAction:[self selectTomorrowAction]];
    [self.alertController addAction:[self selectTodayAction]];
//    [self.alertController addAction:[self selectTomorrowAction]];
    [self.alertController addAction:[self selectDayAfterTomorrowAction]];
    [self.alertController addAction:[self selectCancelAction]];
}

- (UIAlertAction *)selectTodayAction{
    UIAlertAction *todayWeather = [UIAlertAction actionWithTitle:@"今日"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action){
        NSString *url = weatherApiUrl;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET : url parameters : nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            //都市名取得
            NSDictionary *location = responseObject[@"location"];
            NSString *city = location[@"city"];
            //天気予報取得
            NSDictionary *forecasts = responseObject[@"forecasts"][0];//今日のデータはforecastsの0番目のデータになる
            NSString *date = forecasts[@"date"];
            NSString *datelabel = forecasts[@"dateLabel"];
            NSString *telop = forecasts[@"telop"];
            
            NSLog(@"%@,%@の%@天気は、%@です。", datelabel, date, city, telop);
            
        } failure:^(NSURLSessionTask *oeration, NSError *error){
            NSLog(@"データを取得できませんでした。");
        }];
    }];
    return todayWeather;
}

- (UIAlertAction *)selectTomorrowAction{
    UIAlertAction *tomorrowWeather = [UIAlertAction actionWithTitle:@"明日" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        NSString *url = weatherApiUrl;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET : url parameters : nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            //都市名取得
            NSDictionary *location = responseObject[@"location"];
            NSString *city = location[@"city"];
            //天気予報取得
            NSDictionary *forecasts = responseObject[@"forecasts"][1];//明日のデータはforecastsの1番目のデータになる
            NSString *date = forecasts[@"date"];
            NSString *datelabel = forecasts[@"dateLabel"];
            NSString *telop = forecasts[@"telop"];
            
            NSLog(@"%@,%@の%@天気は、%@です。", datelabel, date, city, telop);
            
        } failure:^(NSURLSessionTask *oeration, NSError *error){
            NSLog(@"データを取得できませんでした。");
        }];
    }];
    return tomorrowWeather;
}

- (UIAlertAction *)selectDayAfterTomorrowAction{
    UIAlertAction *dayAfterTomorrowWeather = [UIAlertAction actionWithTitle:@"明後日" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        NSString *url = weatherApiUrl;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            //都市名取得
            NSDictionary *location = responseObject[@"location"];
            NSString *city = location[@"city"];
            //天気予報取得
            NSDictionary *forecasts = responseObject[@"forecasts"][2];//明後日のデータはforecastsの2番目のデータになる
            NSString *date = forecasts[@"date"];
            NSString *datelabel = forecasts[@"dateLabel"];
            NSString *telop = forecasts[@"telop"];
            
            NSLog(@"%@,%@の%@天気は、%@です。", datelabel, date, city, telop);
            
        } failure:^(NSURLSessionTask *oeration, NSError *error){
            NSLog(@"データを取得できませんでした。");
        }];
    }];
    return dayAfterTomorrowWeather;
}

- (UIAlertAction *)selectCancelAction{
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        NSLog(@"キャンセルボタン押されました。");
    }];
    return cancelAction;
}


- (IBAction)weatherBtnTap:(id)sender {
    [self presentViewController:self.alertController animated:YES completion:nil];
}

@end
