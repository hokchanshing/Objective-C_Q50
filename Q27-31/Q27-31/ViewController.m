//
//  ViewController.m
//  Q27-31
//
//  Created by 陳学誠 on 2019/08/20.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"
#import <FMDB/FMDatabase.h>
#import "tourokuViewController.h"
#import "CustomCellTableViewCell.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) int cellCount;
@property (strong, nonatomic) NSMutableArray *titleList;
@property (strong, nonatomic) NSMutableArray *limitDateList;
@property (strong, nonatomic) NSMutableArray *todoIdList;

- (BOOL)checkFirstTime;
- (int)countId;
- (void)createDataSource;
- (void)createFirstDB;

@end

NSString *const AccessDatabaseName = @"test.db";

static NSString *const CheckFirstTimeKey = @"firstRun";

static NSString *const IndicateJudgeStatus = @"OFF";

// セル高さ
static CGFloat const CellHeightValue = 100;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初回起動確認
    if ([self checkFirstTime]) {
        // データベース作成
        NSLog(@"初回起動です。");
        [self createFirstDB];
    }
    // カスタムセルの登録
    UINib *nib = [UINib nibWithNibName:@"CustomCellTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.cellCount = 0;
    self.cellCount = [self countId];

    [self createDataSource];
    [self.tableView reloadData];
}


- (BOOL)checkFirstTime {
    
    NSUserDefaults *userDefaults = NSUserDefaults.standardUserDefaults;
    
    if ([userDefaults objectForKey:CheckFirstTimeKey]) {
        return NO;
    }

    [userDefaults setBool:YES forKey:CheckFirstTimeKey];
    [userDefaults synchronize];
    return YES;
}

// データベース接続
- (id)connectDataBase:(NSString *)dbName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir = paths[0];
    FMDatabase *database = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:dbName]];
    return database;
}

//データソースを作成
- (void)createDataSource {

    FMDatabase *db = [self connectDataBase:AccessDatabaseName];

    NSString *select = [[NSString alloc] initWithFormat:@"SELECT * from tr_todo order by limit_date asc"];
    // DBを開く
    [db open];
    // FMResultSetにDB先をセット
    FMResultSet *resultSet = [db executeQuery:select];
    //　取り出したデータの格納を用意
    self.todoIdList = [@[] mutableCopy];
    self.titleList = [@[] mutableCopy];
    self.limitDateList = [@[] mutableCopy];
    
    while([resultSet next]) {
        // ラベルに直接取り出した値を代入していく
        NSString *todoIdText = [resultSet stringForColumn:@"todo_id"];
        NSString *title = [resultSet stringForColumn:@"todo_title"];
        NSString *limit = [resultSet stringForColumn:@"limit_date"];
        NSString *deleteFlag = [resultSet stringForColumn:@"delete_flg"];
        
        if ([deleteFlag isEqualToString:IndicateJudgeStatus]) {
            [self.todoIdList addObject:todoIdText];
            [self.titleList addObject:title];
            [self.limitDateList addObject:limit];
        }
    }
    [db close];
}

// セルの数を決定（deleteフラグがOFFの要素のみ）
- (int)countId {
    tourokuViewController *tourokuViewCon = [[tourokuViewController alloc]init];
    FMDatabase *db = [self connectDataBase:AccessDatabaseName];

    NSString *countId = [[NSString alloc]initWithFormat:@"select count(*) as count from tr_todo where delete_flg='OFF'"];
    
    [db open];
    
    FMResultSet *countRequest = [db executeQuery:countId];
    
    if([countRequest next]) {
        tourokuViewCon.todoId = [countRequest intForColumn:@"count"];
    }
    
    [db close];
    
    return tourokuViewCon.todoId;
}

- (void)createFirstDB {

    FMDatabase *db = [self connectDataBase:AccessDatabaseName];

    NSString *createTableCommand = @"CREATE TABLE IF NOT EXISTS tr_todo (id INTEGER PRIMARY KEY,todo_id INTEGER,todo_title TEXT,todo_contents TEXT,created INTEGER,modified INTEGER,limit_date INTEGER,delete_flg TEXT);";

    [db open];

    [db executeUpdate:createTableCommand];

    [db close];
}

// セルの数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellCount;
}

// セルの作成
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CustomCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.titleLabel.text = self.titleList[indexPath.row];
    cell.limitLabel.text = [[NSString alloc] initWithFormat:@"期限日：%@", self.limitDateList[indexPath.row]];

    return cell;
}

// 削除アクション
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        

        FMDatabase *db = [self connectDataBase:AccessDatabaseName];
        //削除ボタンが押された時、deleteFlagのvalueをONに
        NSString *deleteFlagText = @"ON";
        // 該当データのインデックス
        NSString *deleteTodoIdIndex = self.todoIdList[indexPath.row];
        NSString *update = [[NSString alloc]initWithFormat:@"UPDATE tr_todo set delete_flg='%@' where id=%@", deleteFlagText, deleteTodoIdIndex];

        [db open];
        [db executeUpdate:update];
        [db close];
        
        NSLog(@"%@番目のデータを削除しました。", self.todoIdList[indexPath.row]);
        
        // 再度セル数の設定
        self.cellCount = [self countId];
        // 最新のデータソースを作成
        [self createDataSource];
        // テーブルビューを更新
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeightValue;
}

@end
