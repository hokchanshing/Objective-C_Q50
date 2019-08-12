//
//  ViewController.m
//  Q11
//
//  Created by 陳学誠 on 2019/08/05.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *goBackButton;
@property (weak, nonatomic) IBOutlet UIButton *goForwardButton;
@property (weak, nonatomic) IBOutlet UIButton *reloadButton;
@property (weak, nonatomic) IBOutlet UIView *tabView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // デリゲート
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    // Webページの大きさを画_webView合わせる
    // iPhoneXではSafeAreaの考慮が必要
    CGRect rect = self.view.frame;
    _webView.frame = rect;

    // インスタンスをビューに追加する
    [self.view addSubview:_webView];
    [self.view addSubview:_tabView];

    // URLを指定
    NSURL *url = [NSURL URLWithString:@"https://www.apple.com/iphone/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // リクエストを投げる
    [_webView loadRequest:request];
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"didFailProvisionalNavigation");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"オフライン"
                                                                             message:@"ネットにつながっていません。"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"はい"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          
                                                      }]];
    

    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)goBackTap:(id)sender {
    [self.webView goBack];
}

- (IBAction)goForwardTap:(id)sender {
    [self.webView goForward];
}

- (IBAction)reloadTap:(id)sender {
    [self.webView reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
