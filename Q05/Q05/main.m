//
//  main.m
//  Q05
//
//  Created by 陳学誠 on 2019/07/30.
//  Copyright © 2019 sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "FavoriteProgrammingLanguage.h"
#import "Account.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Account *account = [Account new];
        [account callJoinInternship];
        
    }
    return 0;
}

