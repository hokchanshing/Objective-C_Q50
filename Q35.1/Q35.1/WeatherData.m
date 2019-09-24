//
//  WeatherData.m
//  Q35.1
//
//  Created by 陳学誠 on 2019/09/24.
//  Copyright © 2019 sample. All rights reserved.
//

#import "WeatherData.h"

@implementation WeatherData

+ (NSString *)primaryKey {
    return @"Id";
}

- (void)saveWeatherData:(NSString *)Id days:(NSString *)days weatherData:(NSString *)weather iconUrl:(NSData *)iconUrl{
    WeatherData *weatherData = [WeatherData new];
    weatherData.Id = Id;
    weatherData.days = days;
    weatherData.weather = weather;
    weatherData.iconUrl = iconUrl;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    // 追加コマンド
    [realm addObject:weatherData];
    [realm commitWriteTransaction];
}

- (void)updateWeatherDataSubThread:(NSString *)Id iconUrl:(NSData *)iconUrl{
    WeatherData *weatherData = [[WeatherData alloc]init];
    weatherData.Id = Id;
    weatherData.iconUrl = iconUrl;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    // 追加コマンド
    [WeatherData createOrUpdateInRealm:realm withValue:weatherData];
    [realm commitWriteTransaction];
}

- (void)updateWeatherDataMainThread:(NSString *)Id days:(NSString *)days weatherData:(NSString *)weather{
    WeatherData *weatherData = [[WeatherData alloc]init];
    weatherData.Id = Id;
    weatherData.days = days;
    weatherData.weather = weather;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    // 追加コマンド
    [WeatherData createOrUpdateInRealm:realm withValue:weatherData];
    [realm commitWriteTransaction];
}

@end
