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

- (BOOL)checkFirstTime;
- (int)countId;
- (void)createDataSource;
- (void)createFirstTable;
- (void)deleteAction;

@end

//接続するデータベースの名前
NSString *const AccessDatabaseName = @"test.db";
//初回起動確認キー
static NSString *const CheckFirstTimeKey = @"firsttime";

static CGFloat const CellHeightValue = 80;


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self checkFirstTime]) {
        NSLog(@"初回起動です");
//        初回起動時、データベースにターブルを作成
        [self createFirstTable];
    } else {
        NSLog(@"初回起動ではないです");
    }
    // カスタムセルの登録
    UINib *nib = [UINib nibWithNibName:@"CustomCellTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // セルの数を決定する(初期化をしてから)
    self.cellCount = 0;
    self.cellCount = [self countId];
    // ここでDataSourceを作る
    [self createDataSource];
    // テーブルをリロード
    [self.tableView reloadData];
}

//初回起動の確認
- (BOOL)checkFirstTime {
    NSUserDefaults *userdefaults = NSUserDefaults.standardUserDefaults;
    
    if ([userdefaults objectForKey:CheckFirstTimeKey]) {
        return NO;
    } else {
        [userdefaults setBool:YES forKey:CheckFirstTimeKey];
        [userdefaults synchronize];
        return YES;
    }
}

- (int)countId {
    // DB接続
    tourokuViewController *tourokuViewCon = [tourokuViewController new];
    FMDatabase *db = [self connectDataBase:AccessDatabaseName];
    //count文の作成
    NSString *countId = [[NSString alloc]initWithFormat:@"select count(*) as count from tr_todo where todo_id"];
    // DBをオープン
    [db open];
    // セットしたcount文を回して、todo_idの数を数える
    FMResultSet *countRequest = [db executeQuery:countId];
    if([countRequest next]) {
        tourokuViewCon.todoId = [countRequest intForColumn:@"count"];
    }
    // DBを閉じる
    [db close];
    // 数えた値を返す
    return tourokuViewCon.todoId;
}


//DataSourceを作成
- (void)createDataSource {
    // DBの呼び出し
    FMDatabase *db = [self connectDataBase:AccessDatabaseName];
    //select文の作成（DB内のデータをlimitDateカラムに準ずる形で並べ替えて取り出す）
    // どのDBからデータを取得するかを指定
    NSString *select = [[NSString alloc] initWithFormat:@"SELECT * from tr_todo order by limit_date asc"];
    // DBを開く
    [db open];
    // FMResultSetにDB先をセット
    FMResultSet *resultSet = [db executeQuery:select];
    //　カラムtodoTitle,limitDateの値を格納する配列を用意
    self.titleList = [@[] mutableCopy];
    self.limitDateList = [@[] mutableCopy];
    
    while([resultSet next]) {
        // ラベルに直接取り出した値を代入していく
        NSString *title = [resultSet stringForColumn:@"todo_title"];
        [self.titleList addObject:title];
        NSString *limit = [resultSet stringForColumn:@"limit_date"];
        [self.limitDateList addObject:limit];
    }
    // DBを閉じる
    [db close];
}

//データベースに接続
- (id)connectDataBase:(NSString *)dbName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir = paths[0];
    
    FMDatabase *database = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:dbName]];
    
    return database;
}

// テーブルとカラムを作る
- (void)createFirstTable {
    
    FMDatabase *db = [self connectDataBase:AccessDatabaseName];
//    tableとカラムを生成
    NSString *createTableColumn = @"CREATE TABLE IF NOT EXISTS tr_todo (id INTEGER PRIMARY KEY,todo_id INTEGER,todo_title TEXT,todo_contents TEXT,created INTEGER,modified INTEGER,limit_date INTEGER,delete_flg TEXT);";
    
    [db open];
    [db executeUpdate:createTableColumn];
    [db close];
    
    NSLog(@"テーブルとカラムを作成しました。");
}

//削除アクション
- (void)deleteAction {
    
    ViewController *viewController = [[ViewController alloc]init];
    FMDatabase *db = [viewController connectDataBase:AccessDatabaseName];
    
    // 取得した情報をデータベースに登録
    NSString *update = [[NSString alloc] initWithFormat:@"UPDATE tr_todo SET delete_flg = 'OFF' WHERE todo_id = '%d';", ];
    //    NSString *update = [[NSString alloc] initWithFormat:@"UPDATE tr_todo SET delete_flg = 'ON'"];
    
    [db open];
    [db executeUpdate:update];
    [db close];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCellTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.titleLabel.text = self.titleList[indexPath.row];
    cell.limitLabel.text = [[NSString alloc] initWithFormat:@"期限日：%@",self.limitDateList[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeightValue;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @[
             [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                title:@"Delete"
                                              handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                  // own delete action
//                                                 [self.titleList deleteData:indexPath.row];
                                                  [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                                              }],
             ];
}



@end
