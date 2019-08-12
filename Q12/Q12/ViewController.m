//
//  ViewController.m
//  Q12
//
//  Created by 陳学誠 on 2019/08/05.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end


static int const MaxTextLength = 30;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.text.length == 0) {
        textField.enablesReturnKeyAutomatically = YES;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.text.length == 0) {
        textField.enablesReturnKeyAutomatically = YES;
    }
    
    NSMutableString *inputedText = [textField.text mutableCopy];
    
    [inputedText replaceCharactersInRange:range withString:string];
    
    if (inputedText.length > MaxTextLength) {
        NSLog(@"%d文字以上は入力できません。", MaxTextLength);
        return NO;
    }
    return YES;
}

- (IBAction)tapBackground:(id)sender {
    [self.view endEditing:YES];
}

@end
