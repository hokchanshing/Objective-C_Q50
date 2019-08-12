//
//  FavoriteProgrammingLanguage.m
//  Q05
//
//  Created by 陳学誠 on 2019/07/30.
//  Copyright © 2019 sample. All rights reserved.
//

#import "FavoriteProgrammingLanguage.h"


// 代理人クラス
@interface FavoriteProgrammingLanguage ()

@end

@implementation FavoriteProgrammingLanguage

-(void)joinInternship{
    if ([self.delegate respondsToSelector:@selector(canDoObjc)]) {
        [self.delegate canDoObjc];
    }
}

@end
