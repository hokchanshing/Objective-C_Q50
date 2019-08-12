//
//  ViewController.m
//  Q14
//
//  Created by 陳学誠 on 2019/08/06.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *pickerHiddenButton;
@property (strong, nonatomic) NSDateFormatter *formatter;

- (void)settingTodaydate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingTodaydate];
}

- (void)settingTodaydate {
    NSDate *todaydate = [[NSDate alloc]init];
    todaydate = [NSDate date];
    
    self.formatter = [[NSDateFormatter alloc] init];
    
    self.formatter.dateFormat = @"yyyy年M月dd日";
    
    self.dateLabel.text = [self.formatter stringFromDate:todaydate];
}

- (IBAction)dateChangedAction:(id)sender {
    self.dateLabel.text = [self.formatter stringFromDate:self.datePicker.date];
}

- (IBAction)touchLabel:(id)sender {
    self.datePicker.hidden = NO;
    self.pickerHiddenButton.hidden = NO;
}

- (IBAction)closeDatePickerAndDoneButton:(id)sender {
    self.datePicker.hidden = YES;
    self.pickerHiddenButton.hidden = YES;
}

@end
