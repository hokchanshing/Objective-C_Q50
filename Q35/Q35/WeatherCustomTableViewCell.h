//
//  WeatherCustomTableViewCell.h
//  Q35
//
//  Created by 陳学誠 on 2019/09/04.
//  Copyright © 2019 sample. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherCustomTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *weatherLabel;
@property (strong, nonatomic) IBOutlet UILabel *introductionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;

@end

NS_ASSUME_NONNULL_END
