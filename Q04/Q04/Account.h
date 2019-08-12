//
//  Account.h
//  Q04
//
//  Created by 陳学誠 on 2019/07/30.
//  Copyright © 2019 sample. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Account : NSObject

@property NSString *sankasyaName;
@property NSString *sankasyaSex;
@property NSNumber *sankasyaAge;
@property NSString *sankasyaLanguage;

- (void) outputSankasyaList;
- (id)initName:(NSString*)name initSex:(NSString*)sex initAge:(NSNumber*)age initLanguage:(NSString*)language;


@end

NS_ASSUME_NONNULL_END
