//
//  FavoriteProgrammingLanguage.h
//  Q05
//
//  Created by 陳学誠 on 2019/07/30.
//  Copyright © 2019 sample. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//プロトコルを作る
@protocol FavoriteProgrammingLanguageDelegate <NSObject>
//オプショナル
@optional

- (void)canDoObjc;

@end



@interface FavoriteProgrammingLanguage : NSObject

@property id <FavoriteProgrammingLanguageDelegate> delegate;

-(void)joinInternship;

@end

NS_ASSUME_NONNULL_END
