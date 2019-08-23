//
//  ViewController.m
//  Q27-31
//
//  Created by 陳学誠 on 2019/08/20.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"
#import <FMDB/FMDatabase.h>

@interface ViewController ()

- (BOOL)checkFirstTime;

@end

//接続するデータベースの名前
NSString *const AccessDatabaseName = @"test.db";
//初回起動確認キー
static NSString *const CheckFirstTimeKey = @"firsttime";


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

@end
