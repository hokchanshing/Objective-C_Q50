//
//  ViewController.m
//  Q45
//
//  Created by 陳学誠 on 2019/09/05.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"
#import  <CoreLocation/CoreLocation.h>


@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
//緯度
@property (strong, nonatomic) IBOutlet UILabel *latLabel;

//経度
@property (strong, nonatomic) IBOutlet UILabel *lonLabel;

- (void)getLocationData;
- (void)outputLocationDataAction;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)getLocationData {
    if ([CLLocationManager locationServicesEnabled]) {
        if (self.locationManager == nil) {
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            if (UIDevice.currentDevice.systemVersion.floatValue >= 8.0) {
                [self.locationManager requestWhenInUseAuthorization];
            }
        } else {
            // データの出力
            [self outputLocationDataAction];
        }
    } else {
        NSLog(@"現在地情報の取得に失敗しました。");
    }
}

- (void)outputLocationDataAction {
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    NSLog(@"緯度 %+.6f, 経度 %+.6f\n", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
    
}


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self outputLocationDataAction];
        self.latLabel.text = [NSString stringWithFormat:@"緯度：%+.6f", self.locationManager.location.coordinate.latitude];
        self.lonLabel.text = [NSString stringWithFormat:@"経度；%+.6f", self.locationManager.location.coordinate.longitude];
    }
}

- (IBAction)getLocationBtnTap:(id)sender {
    [self getLocationData];
}


@end
