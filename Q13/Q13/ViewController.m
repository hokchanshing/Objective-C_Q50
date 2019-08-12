//
//  ViewController.m
//  Q13
//
//  Created by 陳学誠 on 2019/08/06.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *pickerHiddenButton;
@property (strong, nonatomic) NSArray *stations;

- (void)setupPickerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPickerView];
}

- (void)setupPickerView {
    // ピッカーの選択肢
    self.stations = @[@"", @"新宿", @"代々木", @"原宿", @"渋谷", @"恵比寿"];
}

// ピッカーの列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView{
    return 1;
}

// ピッカーの行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.stations.count;
}

// 表示内容
-(NSString*)pickerView:(UIPickerView*)pickerView
           titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return self.stations[row];
    
}

//選んだものを表示する
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if ([self.stations[row] isEqualToString:@""]) {
        self.resultLabel.text = @"降車駅を選んでください";
    } else {
        self.resultLabel.text = [NSString stringWithFormat:@"降車駅は%@です。", self.stations[row]];
    }
    
}

- (IBAction)labelTouch:(id)sender {

    if ((self.pickerView.hidden = YES) && (self.pickerHiddenButton.hidden = YES)) {
        self.pickerView.hidden = NO;
        self.pickerHiddenButton.hidden = NO;
    }
}

- (IBAction)closePckerAndDoneButton:(id)sender {
    self.pickerView.hidden = YES;
    self.pickerHiddenButton.hidden = YES;
}

@end
