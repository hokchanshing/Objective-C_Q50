//
//  Account.m
//  Q04
//
//  Created by 陳学誠 on 2019/07/30.
//  Copyright © 2019 sample. All rights reserved.
//

#import "Account.h"

@implementation Account

- (instancetype)initName:(NSString*)name initSex:(NSString*)sex initAge:(NSNumber*)age initLanguage:(NSString*)language {
    self = [super init];
    if (self) {
        self.sankasyaName = name;
        self.sankasyaSex = sex;
        self.sankasyaAge = age;
        self.sankasyaLanguage = language;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    return [self initName:self.sankasyaName initSex:self.sankasyaSex initAge:self.sankasyaAge initLanguage:self.sankasyaLanguage];
}

-(void)outputSankasyaList{
    if ([self.sankasyaSex  isEqual : @"男性"]){
        NSLog(@"%@君は、%@が得意な%@歳です。",
              self.sankasyaName,
              self.sankasyaLanguage,
              self.sankasyaAge);
    }
}

@end
