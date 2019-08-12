//
//  Account.m
//  Q05
//
//  Created by 陳学誠 on 2019/07/30.
//  Copyright © 2019 sample. All rights reserved.
//

#import "Account.h"
#import <Foundation/Foundation.h>
#import "FavoriteProgrammingLanguage.h"

// 依頼人クラス
@interface Account ()
@end

@implementation Account : NSObject

-(void)callJoinInternship {
    FavoriteProgrammingLanguage *favoriteProgrammingLanguage = [FavoriteProgrammingLanguage new];
    favoriteProgrammingLanguage.delegate = self;
    [favoriteProgrammingLanguage joinInternship];
}

- (void)canDoObjc{
    NSLog(@"canDoObjc通知を受信しました。");
}

@end
