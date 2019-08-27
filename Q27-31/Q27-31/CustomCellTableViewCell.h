//
//  CustomCellTableViewCell.h
//  Q27-31
//
//  Created by 陳学誠 on 2019/08/27.
//  Copyright © 2019 sample. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomCellTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *limitLabel;

@end

NS_ASSUME_NONNULL_END
