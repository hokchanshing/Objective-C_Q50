//
//  tourokuViewController.h
//  Q27-31
//
//  Created by 陳学誠 on 2019/08/21.
//  Copyright © 2019 sample. All rights reserved.
//

#import "ViewController.h"
#import <FMDB/FMDatabase.h>
NS_ASSUME_NONNULL_BEGIN

@interface tourokuViewController : ViewController
@property (strong, nonatomic) IBOutlet UITextField *tourokuTitleTextField;
@property (strong, nonatomic) IBOutlet UITextField *tourokuLimitDateTextField;
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong, nonatomic) UIAlertController *tourokuAlertController;
@property (strong, nonatomic) UIAlertController *doneAlertController;

//データベース関連
@property  (nonatomic) int todoId;
@property  (strong, nonatomic) NSString *todoTitle;
@property  (strong, nonatomic) NSString *todoContents;
@property  (strong, nonatomic) NSString *created;
@property  (strong, nonatomic) NSString *modified;
@property  (strong, nonatomic) NSString *limitDate;
@property  (strong, nonatomic) NSString *deleteFlag;

- (void)setAlert;
@end

NS_ASSUME_NONNULL_END
