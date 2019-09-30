//
//  AppDelegate.m
//  Q48
//
//  Created by hschan on 2019/09/29.
//  Copyright © 2019 hschan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () <UNUserNotificationCenterDelegate, NSURLSessionDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:
     (UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert ) completionHandler:^(BOOL granted, NSError *_Nullable error) {
         if (granted) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [UIApplication.sharedApplication registerForRemoteNotifications];
             });
         }
     }];

    [UNUserNotificationCenter currentNotificationCenter].delegate = self;

    [application registerForRemoteNotifications];


    return YES;
}

-(void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{

    NSMutableString *token = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@", deviceToken]];
    //トークンの文字列を整理
    [token setString:[token stringByReplacingOccurrencesOfString:@"<" withString:@""]];
    [token setString:[token stringByReplacingOccurrencesOfString:@">" withString:@""]];
    [token setString:[token stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    [self sendToken:token];
    NSLog(@"deviceToken = %@", token);
}

//in-app notification
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    completionHandler(UNNotificationPresentationOptionAlert);
    
    NSLog(@"Recevied foreground notification.");
}

-(void)sendToken:(NSString *)token {
    
    //localhostではスマホが認識できないので、IPアドレスにしないと接続できない。
    NSString *serverPHP = @"http://192.168.11.53:8888/training/training/push/index.php";
    NSString *postString = [NSString stringWithFormat:@"DeviceToken=%@", token];
    NSMutableURLRequest *reqest = [[NSMutableURLRequest alloc]init];
    
    [reqest setURL:[NSURL URLWithString:serverPHP]];
    [reqest setHTTPMethod:@"POST"];
    [reqest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionConfiguration* configuration = [[NSURLSessionConfiguration alloc]init];
    configuration = NSURLSessionConfiguration.defaultSessionConfiguration;

    NSURLSession *task = [NSURLSession sessionWithConfiguration:configuration];
    
    [[task dataTaskWithRequest:reqest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (response && ! error) {
            NSString *responseString = [[NSString alloc] initWithData: data  encoding: NSUTF8StringEncoding];
            NSLog(@"成功: %@", responseString);
        }
        else {
            NSLog(@"失敗: %@", error);
        }
    }] resume];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(nonnull NSError *)error {
    NSLog(@"%@", error);
}


@end
