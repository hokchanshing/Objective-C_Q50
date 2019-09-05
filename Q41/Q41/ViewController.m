//
//  ViewController.m
//  Q41
//
//  Created by 陳学誠 on 2019/09/04.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

//- (void)viewDidAppear:(BOOL)animated {
//
//    [super viewDidAppear:animated];
//    [self showUIImagePicker];
//
//}

-(void)viewDidLoad{
    
    [super viewDidLoad];
}

//- (void)showUIImagePicker {
//    //カメラ使えるかどうか判定する
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        return;
//    }
//
//    UIImagePickerController *imagePickerController = [UIImagePickerController new];
//
//    imagePickerController.delegate = self;
//    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//    imagePickerController.allowsEditing = YES;
//
//    [self presentViewController:imagePickerController animated:YES completion:nil];
//
//}
- (IBAction)cameraBtnTap:(id)sender {
    //カメラ使えるかどうか判定する
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"カメラが使えない");
        return;
    }
    
    UIImagePickerController *imagePickerController = [UIImagePickerController new];
    
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.allowsEditing = YES;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    UIImage *savedImage = info[UIImagePickerControllerOriginalImage];
    [self.imageView setImage:savedImage];
    
//    [self dismissViewControllerAnimated:YES completion:nil];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
}


@end
