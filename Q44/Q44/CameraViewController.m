//
//  CameraViewController.m
//  Q44
//
//  Created by 陳学誠 on 2019/09/12.
//  Copyright © 2019 sample. All rights reserved.
//

#import "CameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"

@interface CameraViewController () <AVCapturePhotoCaptureDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *cameraImageView;
@property AVCaptureVideoPreviewLayer *previewLayer;
@property (strong, nonatomic) AVCaptureSession *avSession;
@property (nonatomic) AVCapturePhotoOutput *avPhotoOutput;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setAvCapture];
}

- (void)setAvCapture {
    
    self.avSession = [AVCaptureSession new];
    self.avSession.sessionPreset = AVCaptureSessionPresetPhoto;
    self.avPhotoOutput = [AVCapturePhotoOutput new];
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    AVCaptureDeviceInput *deviceInput = [[AVCaptureDeviceInput alloc]initWithDevice:device error:&error];
    
    [self.avSession addInput:deviceInput];
    [self.avSession addOutput:self.avPhotoOutput];
    
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.avSession];
    captureVideoPreviewLayer.frame = self.cameraImageView.bounds;
    captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.cameraImageView.layer addSublayer:captureVideoPreviewLayer];
    
    [self.avSession startRunning];
}

- (IBAction)takePhtotoBtnTap:(id)sender {
    [self takePhoto];
}

- (void)takePhoto {
    AVCapturePhotoSettings *setting = [AVCapturePhotoSettings new];
    setting.flashMode = AVCaptureFlashModeAuto;
    [self.avPhotoOutput capturePhotoWithSettings:setting delegate:self];
}


-(void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(NSError *)error {
    
    NSData *imageData = photo.fileDataRepresentation;
    //    UIImage *image = [UIImage imageWithData:imageData];
    
    [self saveImage:imageData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(NSData *)imageData {
    //userdefaultsで保存する
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    [defaults setObject:imageData forKey:@"imageData"];
    [defaults synchronize];
    
}

- (BOOL)shouldAutorotate {
    return YES;
}


//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return UIInterfaceOrientationLandscapeLeft; // or Right of course
//}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
