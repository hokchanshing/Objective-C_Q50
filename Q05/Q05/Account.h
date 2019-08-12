//
//  Account.h
//  Q05
//
//  Created by 陳学誠 on 2019/07/30.
//  Copyright © 2019 sample. All rights reserved.
//

#import "FavoriteProgrammingLanguage.h"

NS_ASSUME_NONNULL_BEGIN

@interface Account : NSObject <FavoriteProgrammingLanguageDelegate>

- (void)callJoinInternship;
@end

NS_ASSUME_NONNULL_END
