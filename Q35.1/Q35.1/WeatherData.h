//
//  WeatherData.h
//  Q35.1
//
//  Created by 陳学誠 on 2019/09/24.
//  Copyright © 2019 sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>


NS_ASSUME_NONNULL_BEGIN

@interface WeatherData : RLMObject

@property NSString  *Id;
@property NSString *days;
@property NSString *weather;
@property NSData *iconUrl;

- (void)saveWeatherData:(NSString *)Id days:(NSString *)days weatherData:(NSString *)weather iconUrl:(NSData *)iconUrl;
- (void)updateWeatherDataSubThread:(NSString *)Id iconUrl:(NSData *)iconUrl;
- (void)updateWeatherDataMainThread:(NSString *)Id days:(NSString *)days weatherData:(NSString *)weather;

@end

NS_ASSUME_NONNULL_END
