//
//  ViewController.m
//  Q46
//
//  Created by 陳学誠 on 2019/09/05.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>


@interface ViewController () <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    
    double latitude = 35.623613;
    double longitude = 139.725030;
    
    MKCoordinateRegion region = self.mapView.region;
    region.span.latitudeDelta = 0.001;
    region.span.longitudeDelta = 0.001;
    region.center = CLLocationCoordinate2DMake(latitude, longitude);
    
    [self.mapView setRegion:region animated:YES];
    
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    annotation.title = @"株式会社　スマートテック・ベンチャーズ";
    annotation.subtitle = @"高徳ビル４F";
    
    [self.mapView addAnnotation:annotation];
    
}


@end
