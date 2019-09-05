//
//  CameraViewController.m
//  Q42
//
//  Created by 陳学誠 on 2019/09/04.
//  Copyright © 2019 sample. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()
@property (strong, nonatomic) IBOutlet UIView *previewView;
@property AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (strong, nonatomic) AVCaptureSession *session;
@property (nonatomic) AVCapturePhotoOutput *stillImageOutput;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAvCapture];
}

- (void)setupAvCapture {
    
    self.session = [AVCaptureSession new];
    self.session.sessionPreset = AVCaptureSessionPreset1920x1080;
    
    self.stillImageOutput = [AVCapturePhotoOutput new];
    
    AVCaptureDevice* device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = [NSError new];
    
    AVCaptureDeviceInput* deviceInput = [[AVCaptureDeviceInput alloc]initWithDevice:device error:&error];
    [self.session addInput:deviceInput];
    
    [self.session addOutput:self.stillImageOutput];
    
    AVCaptureVideoPreviewLayer* captureVideoLayer = [[AVCaptureVideoPreviewLayer new]initWithSession:self.session];
    captureVideoLayer.frame = self.previewView.bounds;
    captureVideoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [self.session startRunning];
    
}

- (IBAction)takePhotoBtn:(id)sender {
    [self takePhoto];
}

- (void)takePhoto {
    
    AVCapturePhotoSettings* settings = [AVCapturePhotoSettings new];
    settings.flashMode = AVCaptureFlashModeAuto;
    [self.stillImageOutput capturePhotoWithSettings:settings delegate:self];
    
}

- (void)savePhotoData:(NSData *)photoData {
    // 画像を保存する
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    [defaults setObject:photoData forKey:@"imageData"];
    [defaults synchronize];
    // メイン画面に戻る
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)captureOutput:(AVCapturePhotoOutput *)captureOutput
didFinishProcessingPhotoSampleBuffer:(nullable CMSampleBufferRef)photoSampleBuffer
previewPhotoSampleBuffer:(nullable CMSampleBufferRef)previewPhotoSampleBuffer
    resolvedSettings:(nonnull AVCaptureResolvedPhotoSettings *)resolvedSettings
     bracketSettings:(nullable AVCaptureBracketedStillImageSettings *)bracketSettings
               error:(nullable NSError *)error {
    // jpeg形式で撮影画像をデータ化
    NSData* photoData = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:previewPhotoSampleBuffer];
    // 画像の保存、画面遷移
    [self savePhotoData:photoData];
}


@end
