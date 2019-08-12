//
//  PageViewController.m
//  Q21
//
//  Created by hschan on 2019/08/12.
//  Copyright © 2019 hschan. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@property (strong, nonatomic) NSArray *viewControllerList;
@property (strong, nonatomic) UIViewController *viewController;
@property int viewControllerIndex;

-(void)setupPageviewController;
@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPageviewController];
}

// pageviewcontrollerの設定
-(void)setupPageviewController {
    self.delegate = self;
    self.dataSource = self;
    
    self.viewControllerList = @[@"ViewController",
                                @"SecondViewController",
                                @"ThirdViewController"];
    
    // 初めに表示するViewControllerのindexを指定
    self.viewControllerIndex = 0;
    
    // ViewControllerをセット
    self.viewController = [self.storyboard instantiateViewControllerWithIdentifier:self.viewControllerList[0]];
    
    self.viewController.view.tag = self.viewControllerIndex;
    
    [self setViewControllers:@[self.viewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}


// 右スワイプ
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
//    現在表示しているViewControllerのタグをもらう
    self.viewControllerIndex = (int)viewController.view.tag;
    
//    表示したいViewControllerの番号にする
    self.viewControllerIndex++;
    
//    表示したいViewControllerが現在表示しているものより大きいかを判断
    if ( (self.viewControllerIndex >= self.viewControllerList.count) || (self.viewControllerIndex == NSNotFound) ) {
        return nil;
    }
    
    self.viewController = [self.storyboard instantiateViewControllerWithIdentifier:self.viewControllerList[self.viewControllerIndex]];
    
//    表示したいViewControllerのタグを更新
    self.viewController.view.tag = self.viewControllerIndex;
    
    return self.viewController;
}


// 左スワイプ
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    //    現在表示したいViewControllerのタグをもらう
    self.viewControllerIndex = (int)viewController.view.tag;
//    現在表示しているViewControllerは最初のページかを判断
    if( (self.viewControllerIndex == 0) || (self.viewControllerIndex == NSNotFound) ) {
        return nil;
    }

    //    表示したいViewControllerの番号にする
    self.viewControllerIndex--;
    
    self.viewController = [self.storyboard instantiateViewControllerWithIdentifier:self.viewControllerList[self.viewControllerIndex]];
    
    //    表示したいViewControllerのタグを更新
    self.viewController.view.tag = self.viewControllerIndex;
    
    return self.viewController;
}


@end
