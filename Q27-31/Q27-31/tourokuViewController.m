//
//  tourokuViewController.m
//  Q27-31
//
//  Created by 陳学誠 on 2019/08/21.
//  Copyright © 2019 sample. All rights reserved.
//

#import "tourokuViewController.h"

@interface tourokuViewController () <UITextFieldDelegate,UITextViewDelegate>

@end

// 日付のフォーマット
static NSString *const DateFormat = @"yyyy/MM/dd";
// DB内で値に振るIDの増数値
static int const AddCountTodoId = 1;


@implementation tourokuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAlert];
}

- (void)setAlert {
    self.tourokuAlertController = [UIAlertController
                                    alertControllerWithTitle:@"アラート"
                                    message:@"タイトルを入力してください。"
                                    preferredStyle:UIAlertControllerStyleAlert];
    
   
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action) {
                                                       NSLog(@"clicked Button title: %@", action.title);
                                                   }];
    [self.tourokuAlertController addAction:action];
}


- (NSString *)getCreated {
    // 現在時刻を取得
    NSDateFormatter *format = [NSDateFormatter new];
    [format setDateFormat:DateFormat];
    
    NSString *todayDate = [format stringFromDate:[NSDate date]];
    
    return todayDate;
}


-(int)addTodoId {
    // データベース
    ViewController *viewController = [ViewController new];
    FMDatabase *db = [viewController connectDataBase:AccessDatabaseName];
    //count文の作成
    NSString *countTodoId = [[NSString alloc] initWithFormat:@"select count(*) as count from tr_todo where todo_id"];
    // DBをオープン
    [db open];
    // セットしたcount文を回して、todo_idの数を数える
    FMResultSet *countRequest = [db executeQuery:countTodoId];
    if([countRequest next]) {
        self.todoId = [countRequest intForColumn:@"count"];
    }
    // DBを閉じる
    [db close];
    // idを書き換える
    int latestTodoId = self.todoId + AddCountTodoId;
    
    return latestTodoId;
}

// 登録アクション
- (void)registerAction {
    
    ViewController *viewController = [[ViewController alloc]init];
    FMDatabase *db = [viewController connectDataBase:AccessDatabaseName];
    
    // todoIdをセット（0をセットまたは+1で返す）
    self.todoId = [self addTodoId];
    // createdを取得
    self.created = [self getCreated];
    // modifiedを取得
    self.modified = [self getCreated];
    // limitDateを取得
    self.limitDate = self.tourokuLimitDateTextField.text;
    // deleteFlagを設定
    self.deleteFlag = @"OFF";
    // テキストフィールドからタイトルを取得
    self.todoTitle = self.tourokuTitleTextField.text;
    // テキストビューから内容を取得
    self.todoContents = self.contentTextView.text;
    
    // 取得した情報をデータベースに登録
    NSString *insert = [[NSString alloc] initWithFormat:@"INSERT INTO tr_todo(todo_id, todo_title, todo_contents, created, modified, limit_date, delete_flg) VALUES('%d', '%@', '%@', '%@', '%@', '%@', '%@')", self.todoId, self.todoTitle, self.todoContents, self.created, self.modified, self.limitDate, self. deleteFlag];
    
    [db open];
    [db executeUpdate:insert];
    [db close];
    
    NSLog(@"%d番目のデータを作成しました", self.todoId);
}




- (IBAction)tourokuBtnTap:(id)sender {
    //タイトルが空のときにアラートを出す
    if (self.tourokuTitleTextField.text.length == 0) {
        [self presentViewController:self.tourokuAlertController animated:YES completion:nil];
    } else {
        [self registerAction];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}


- (IBAction)dismissTorokuBtn:(id)sender {
    //キーボード開いたまま登録画面を閉じると、キーボードが登録画面よりおそくきえるので、ここでもキーボードを閉じる処理を加えました。
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}


@end
