//
//  ViewController.m
//  Q36
//
//  Created by 陳学誠 on 2019/09/24.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "AFNetworking/AFAutoPurgingImageCache.h"
#import "AFNetworking/AFURLRequestSerialization.h"
#import "WeatherCustomTableViewCell.h"
#import "WeatherData.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) UIAlertController *alertController;
@property (nonatomic,strong) NSMutableArray *threeDaysDateList;
@property (nonatomic,strong) NSMutableArray *threeDaysTelopList;
@property (nonatomic,strong) NSMutableArray *threeDaysTextList;
@property (nonatomic,strong) NSMutableArray *threeDaysImageUrlList;


@end


//メモ　天気API　http://weather.livedoor.com/weather_hacks/webservice
//久留米市のURL
static NSString *const weatherApiUrl = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=400040";

static int const todayApiNumber = 0;//今日の天気のindex
static int const tomorrowApiNumber = 1;//明日の天気のindex
static int const dayAfterTomorrowApiNumber = 2;//あさっての天気のindex

static int const allDaysDataCount = 3;//全部の天気の数

static NSString *const unfinishedImageName = @"noImageIcon";

static CGFloat CellEstimatedRowHeight = 100.0;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAlertController];
    [self setTableView];
}

//tebleViewを設置
- (void)setTableView{
    UINib *nib = [UINib nibWithNibName:@"WeatherCustomTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = CellEstimatedRowHeight;
}

//alertControllerを設置
- (void)setAlertController{
    //Localizable.stringsから文字列を取り出す
    NSString *titleText = [NSBundle.mainBundle localizedStringForKey:@"alertTitle" value:nil table:@"Localizable"];
    NSString *messageText = [NSBundle.mainBundle localizedStringForKey:@"alertMessage" value:nil table:@"Localizable"];
    //
    self.alertController = [UIAlertController alertControllerWithTitle:titleText message:messageText preferredStyle:UIAlertControllerStyleActionSheet];
    
    //alertControllerにボタンアクションを追加
    [self.alertController addAction: [self selectTodayAction]];
    [self.alertController addAction: [self selectTomorrowAction]];
    [self.alertController addAction: [self selectDayAfterTomorrowAction]];
    [self.alertController addAction: [self selcetCancelAction]];
    
}

//todayボタンのアクション
- (UIAlertAction *)selectTodayAction {
    
    NSString *titleText = [NSBundle.mainBundle localizedStringForKey:@"aleartActionTitleToday" value:nil table:@"Localizable"];
    UIAlertAction *todayWeather =
    [UIAlertAction actionWithTitle:titleText
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               // 並列処理
                               //軽い処理をメイン
                               dispatch_queue_t mainQueue = dispatch_get_main_queue();
                               //重い処理をサブ
                               dispatch_queue_t subQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                               // リストの配列
                               self.threeDaysDateList = [@[] mutableCopy];
                               self.threeDaysTelopList = [@[] mutableCopy];
                               self.threeDaysTextList = [@[] mutableCopy];
                               self.threeDaysImageUrlList = [@[] mutableCopy];
                               // URLからJSONデータを取得
                               NSString *url = weatherApiUrl;
                               AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                               //キャッシュ
                               [manager.requestSerializer setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
                               
                               [manager GET:url parameters:nil progress:nil
                                    success:^(NSURLSessionTask *task, id responseObject) {
                                        // サブスレッド処理
                                        dispatch_async(subQueue, ^{
                                            NSDictionary *forecasts = responseObject[@"forecasts"][todayApiNumber];
                                            [self createDataSoruceSubThread:forecasts index:todayApiNumber];
                                            dispatch_async(mainQueue, ^{
                                                [self.tableView reloadData];
                                            });
                                        });
                                        // メインスレッド処理
                                        dispatch_async(mainQueue, ^{
                                            NSDictionary *forecasts = responseObject[@"forecasts"][todayApiNumber];
                                            NSDictionary *description = responseObject[@"description"];
                                            [self createDataSoruceMainThread:forecasts descriptionDictionary:description index:todayApiNumber];
                                        });
                                    } failure:^(NSURLSessionTask *operation, NSError *error) {
                                        // エラーの場合の処理
                                        NSLog(@"予報データの取得に失敗しました。");
                                    }
                                ];
                           }];
    return todayWeather;
}

//tomorrowボランのアクション
- (UIAlertAction *)selectTomorrowAction {
    
    NSString *titleText = [NSBundle.mainBundle localizedStringForKey:@"aleartActionTitleTomorrow" value:nil table:@"Localizable"];
    UIAlertAction *tomorrowWeather =
    [UIAlertAction actionWithTitle:titleText
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               // 並列処理
                               //軽い処理をメイン
                               dispatch_queue_t mainQueue = dispatch_get_main_queue();
                               //重い処理をサブ
                               dispatch_queue_t subQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                               // リストの配列
                               self.threeDaysDateList = [@[] mutableCopy];
                               self.threeDaysTelopList = [@[] mutableCopy];
                               self.threeDaysTextList = [@[] mutableCopy];
                               self.threeDaysImageUrlList = [@[] mutableCopy];
                               // URLからJSONデータを取得
                               NSString *url = weatherApiUrl;
                               AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                               //キャッシュ
                               [manager.requestSerializer setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
                               [manager GET:url parameters:nil progress:nil
                                    success:^(NSURLSessionTask *task, id responseObject) {
                                        // サブスレッド処理
                                        dispatch_async(subQueue, ^{
                                            NSDictionary *forecasts = responseObject[@"forecasts"][tomorrowApiNumber];
                                            [self createDataSoruceSubThread:forecasts index:tomorrowApiNumber];
                                            dispatch_async(mainQueue, ^{
                                                [self.tableView reloadData];
                                            });
                                        });
                                        // メインスレッド処理
                                        dispatch_async(mainQueue, ^{
                                            NSDictionary *forecasts = responseObject[@"forecasts"][tomorrowApiNumber];
                                            NSDictionary *description = responseObject[@"description"];
                                            [self createDataSoruceMainThread:forecasts descriptionDictionary:description index:tomorrowApiNumber];
                                        });
                                    } failure:^(NSURLSessionTask *operation, NSError *error) {
                                        // エラーの場合の処理
                                        NSLog(@"予報データの取得に失敗しました。");
                                    }
                                ];
                           }];
    return tomorrowWeather;
}

//dayaftertomorrowボタンのアクション
- (UIAlertAction *)selectDayAfterTomorrowAction {
    
    NSString *titleText = [NSBundle.mainBundle localizedStringForKey:@"aleartActionTitleAfterTomorrow" value:nil table:@"Localizable"];
    UIAlertAction *dayAfterTomorrowWeather =
    [UIAlertAction actionWithTitle:titleText
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               // 並列処理
                               //軽い処理をメイン
                               dispatch_queue_t mainQueue = dispatch_get_main_queue();
                               //重い処理をサブ
                               dispatch_queue_t subQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                               // リストの配列
                               self.threeDaysDateList = [@[] mutableCopy];
                               self.threeDaysTelopList = [@[] mutableCopy];
                               self.threeDaysTextList = [@[] mutableCopy];
                               self.threeDaysImageUrlList = [@[] mutableCopy];
                               // URLからJSONデータを取得
                               NSString *url = weatherApiUrl;
                               AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                               //キャッシュ
                               [manager.requestSerializer setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
                               [manager GET : url parameters : nil progress:nil
                                     success:^(NSURLSessionTask *task, id responseObject) {
                                         NSArray *checkInfomationList = responseObject[@"forecasts"];
                                         if (checkInfomationList.count == allDaysDataCount) {
                                             dispatch_async(subQueue, ^{
                                                 NSDictionary *forecasts = responseObject[@"forecasts"][dayAfterTomorrowApiNumber];
                                                 [self createDataSoruceSubThread:forecasts index:dayAfterTomorrowApiNumber];
                                                 dispatch_async(mainQueue, ^{
                                                     // 終わった後の処理
                                                     [self.tableView reloadData];
                                                 });
                                             });
                                             // メインスレッド処理
                                             dispatch_async(mainQueue, ^{
                                                 NSDictionary *forecasts = responseObject[@"forecasts"][dayAfterTomorrowApiNumber];
                                                 NSDictionary *description = responseObject[@"description"];
                                                 [self createDataSoruceMainThread:forecasts descriptionDictionary:description index:dayAfterTomorrowApiNumber];
                                             });
                                         } else {
                                             NSLog(@"明後日の天気予報がありません。");
                                         }
                                     } failure:^(NSURLSessionTask *operation, NSError *error) {
                                         // エラーの場合の処理
                                         NSLog(@"予報データの取得に失敗しました。");
                                     }
                                ];
                           }];
    return dayAfterTomorrowWeather;
}

//cancelボタンのアクション
- (UIAlertAction *)selcetCancelAction {
    NSString *titleText = [NSBundle.mainBundle localizedStringForKey:@"aleartActionTitleCancel" value:nil table:@"Localizable"];
    // キャンセルアクションを生成
    UIAlertAction *cancelAction =
    [UIAlertAction actionWithTitle:titleText
                             style:UIAlertActionStyleCancel
                           handler:^(UIAlertAction * action) {
                               NSLog(@"ボタン操作をキャンセルしました。");
                           }];
    return cancelAction;
}

// 非同期detasource（サブ）
//画像をロード
- (void)createDataSoruceSubThread:(NSDictionary *)forecastsDictionary index:(int)index{
    NSDictionary *image = forecastsDictionary[@"image"];
    NSData *imageData = [self createImageData:image[@"url"]];
    NSString *indexId = [NSString stringWithFormat:@"%d",index];
    
    //    データベースをアップデート
    WeatherData *weatherData = [WeatherData new];
    [weatherData updateWeatherDataSubThread:indexId iconUrl:imageData];
    //データベースから取り出しTableView表示する
    RLMResults *result = [WeatherData objectsWhere:[NSString stringWithFormat:@"Id='%@'", indexId]];
    
    [self.threeDaysImageUrlList addObject:result[0][@"iconUrl"]];
//    [self.tableView reloadData];
}

// 非同期detasource（メイン）
//文字列をロード
- (void)createDataSoruceMainThread:(NSDictionary *)forecastsDictionary descriptionDictionary:(NSDictionary *)descriptionDictionary  index:(int)index {
    
    NSString *indexId = [NSString stringWithFormat:@"%d",index];
    NSString *dateData = forecastsDictionary[@"date"];
    NSString *telopData = forecastsDictionary[@"telop"];
    
    //    データベースをアップデート
    WeatherData *weatherData = [WeatherData new];
    [weatherData updateWeatherDataMainThread:indexId days:dateData weatherData:telopData];
    //データベースから取り出しTableView表示する
    RLMResults *result = [WeatherData objectsWhere:[NSString stringWithFormat:@"Id='%@'", indexId]];
    
    [self.threeDaysDateList addObject:result[0][@"days"]];
    [self.threeDaysTelopList addObject:result[0][@"weather"]];
    [self.threeDaysTextList addObject:descriptionDictionary[@"text"]];
    [self.tableView reloadData];
}

// NSString型データをNSData型に変換する
- (NSData *)createImageData:(NSString *)imageDataText {
    NSURL *imageUrl = [NSURL URLWithString:imageDataText];
    NSData *data = [NSData dataWithContentsOfURL:imageUrl];
    return data;
}

// セルの数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.threeDaysDateList.count;
}

// セルの内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WeatherCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.dateLabel.text = self.threeDaysDateList[indexPath.row];
    cell.weatherLabel.text = self.threeDaysTelopList[indexPath.row];
    cell.introductionLabel.text = self.threeDaysTextList[indexPath.row];
    
    if (self.threeDaysImageUrlList.count > indexPath.row) {
        cell.iconImage.image = [[UIImage alloc]initWithData:self.threeDaysImageUrlList[indexPath.row]];
    } else {
        cell.iconImage.image = [UIImage imageNamed:unfinishedImageName];
    }
    
    return cell;
}

- (IBAction)weatherBtnTap:(id)sender {
    [self presentViewController:self.alertController animated:YES completion:nil];
}

@end
