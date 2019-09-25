//
//  ViewController.m
//  Q47
//
//  Created by 陳学誠 on 2019/09/06.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"
@import Firebase;

@implementation ViewController

-(void)viewDidLoad {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(displayFCMToken:)
                                                 name:@"FCMToken"
                                               object:nil];
}

- (IBAction)handleLogTokenTouch:(id)sender {
    // [START log_fcm_reg_token]
    NSString *fcmToken = [FIRMessaging messaging].FCMToken;
    NSLog(@"Local FCM registration token: %@", fcmToken);
    // [END log_fcm_reg_token]
    
    NSString* displayToken = [NSString stringWithFormat:@"Logged FCM token: %@", fcmToken];
    self.fcmTokenMessage.text = displayToken;
    
    // [START log_iid_reg_token]
    [[FIRInstanceID instanceID] instanceIDWithHandler:^(FIRInstanceIDResult * _Nullable result,
                                                        NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error fetching remote instance ID: %@", error);
        } else {
            NSLog(@"Remote instance ID token: %@", result.token);
            NSString* message =
            [NSString stringWithFormat:@"Remote InstanceID token: %@", result.token];
            self.instanceIDTokenMessage.text = message;
        }
    }];
    // [END log_iid_reg_token]
}

- (IBAction)handleSubscribeTouch:(id)sender {
    // [START subscribe_topic]
    [[FIRMessaging messaging] subscribeToTopic:@"weather"
                                    completion:^(NSError * _Nullable error) {
                                        NSLog(@"Subscribed to weather topic");
                                    }];
    // [END subscribe_topic]
}

- (void) displayFCMToken:(NSNotification *) notification {
    NSString* message =
    [NSString stringWithFormat:@"Received FCM token: %@", notification.userInfo[@"token"]];
    self.fcmTokenMessage.text = message;
}

@end
