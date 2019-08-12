//
//  main.m
//  Q04
//
//  Created by 陳学誠 on 2019/07/30.
//  Copyright © 2019 sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Account.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
//        参加者リスト作成
        Account *sankasya1 = [[Account alloc]initName:@"山田花子" initSex:@"女性" initAge:@22 initLanguage:@"Kotlin"];
        Account *sankasya2 = [[Account alloc]initName:@"山田太郎" initSex:@"男性" initAge:@33 initLanguage:@"Swift"];
        Account *sankasya3 = [[Account alloc]initName:@"山田二郎" initSex:@"男性" initAge:@44 initLanguage:@"Objective-C"];
        Account *sankasya4 = [[Account alloc]initName:@"山田楓子" initSex:@"女性" initAge:@55 initLanguage:@"JAVA"];
        
        NSArray *sankasyaList = @[sankasya1, sankasya2, sankasya3, sankasya4];
        
        for(Account *sankasya in sankasyaList){
            [sankasya outputSankasyaList];
        }
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
