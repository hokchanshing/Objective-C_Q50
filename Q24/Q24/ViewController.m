//
//  ViewController.m
//  Q24
//
//  Created by hschan on 2019/08/12.
//  Copyright © 2019 hschan. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidDisappear:(BOOL)animated {
    self.textField.text = [NSString new];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //リターンで遷移
    [self sendBtnTap:nil];
    //遷移後のテキストフィールドをリセット
    return [textField resignFirstResponder];
}


//背景タップでけキーボードを消す
- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)sendBtnTap:(id)sender {
    
    //Second.storyboardを指定する
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Second" bundle:nil];
    //Second.storyboardのクラスのScondeViewControllerを指定する
    SecondViewController *secondViewController = [secondStoryBoard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    
    //テキストフィールドの文字列を別のsecondViewControllerにパス
    secondViewController.passMessage = self.textField.text;
    
    
    [self presentViewController:secondViewController animated:YES completion:nil];
    
}

@end
