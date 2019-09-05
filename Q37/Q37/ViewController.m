//
//  ViewController.m
//  Q37
//
//  Created by 陳学誠 on 2019/09/04.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFacebookShare];
}

- (void)setFacebookShare {
    FBSDKShareButton *shareButton = [FBSDKShareButton new];
    shareButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:shareButton];
    
    // 適当にautolayoutを指定しておく
    [shareButton.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:8.0f].active = YES;
    [shareButton.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:8.0f].active = YES;
    [shareButton.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-8.0f].active = YES;
    [shareButton.heightAnchor constraintEqualToConstant:44.0f].active = YES;
    
    //写真をシェア
    UIImage *image = [UIImage imageNamed:@"sample"];
    
    FBSDKSharePhoto *photo = [FBSDKSharePhoto new];
    photo.image = image;
    photo.userGenerated = YES;
    
    FBSDKSharePhotoContent *content = [FBSDKSharePhotoContent new];
    content.photos = @[photo];
    
    shareButton.shareContent = content;
}




@end
