//
//  ViewController.m
//  Q38
//
//  Created by 陳学誠 on 2019/09/05.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)tweetMain
{
    // Twitter 認証トークンのチェック
    if ([[Twitter sharedInstance].sessionStore hasLoggedInUsers]) { // 認証トークンあり
        [self tweet];
        
    } else { // 認証トークンなし
        // Twitterログイン
        [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
            if (session) { // ログイン OK
                NSLog(@"signed in as %@", [session userName]);
                
                [self tweet];
                
            } else { // ログイン キャンセル
                NSLog(@"error: %@", [error localizedDescription]);
            }
        }];
    }
}

- (void)tweet
{
    // Twitter投稿データ編集
    TWTRComposer *composer = [[TWTRComposer alloc] init];
    [composer setText:@"hoge"];
    [composer setImage:[UIImage imageNamed:@"sample"]];
    [composer setURL:[NSURL URLWithString:@"http://yahoo.co.jp"]];
    
    // Twitter投稿画面表示
    [composer showFromViewController:self completion:^(TWTRComposerResult result) {
        if (result == TWTRComposerResultCancelled) { // キャンセル
            NSLog(@"Tweet composition cancelled");
        }
        else {
            NSLog(@"Sending Tweet!");
        }
    }];
}

- (IBAction)tweetBtnTap:(id)sender {
    

    
    [self tweetMain];
    
    
}


@end
