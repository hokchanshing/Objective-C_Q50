//
//  SecondViewController.m
//  Q50
//
//  Created by 陳学誠 on 2019/09/03.
//  Copyright © 2019 sample. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (strong, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) IBOutlet UILabel *commentLabel;

- (void)setSchemeText;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSchemeText];
}


//メモ　URLサンプル：stv://?caption=ABC&comment=AAA
- (void)setSchemeText {
    NSArray *schemeParameter = [self.receivedString componentsSeparatedByString:@"&"];
    NSArray *captionPart = [schemeParameter[0] componentsSeparatedByString:@"="];
    NSArray *commentPart = [schemeParameter[1] componentsSeparatedByString:@"="];

//    self.captionLabel.text = @"caption:&@", captionPart[1];
//    self.commentLabel.text = @"comment:&@", commentPart[1];
    self.captionLabel.text = [NSString stringWithFormat:@"%@ : %@", captionPart[0], captionPart[1]];
    self.commentLabel.text = [NSString stringWithFormat:@"%@ : %@", commentPart[0], commentPart[1]];
    
}



@end
