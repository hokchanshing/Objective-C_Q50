//
//  ViewController.m
//  Q19
//
//  Created by hschan on 2019/08/12.
//  Copyright © 2019 hschan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *characterImageNameList;
@property (strong, nonatomic) NSArray *characterInfoList;

-(void)getPlistData;
-(void)setTableView;

@end

static CGFloat const cellRowEstimateHeight = 100;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPlistData];
    [self setTableView];
}

-(void)getPlistData {
    NSBundle *bundle = NSBundle.mainBundle;
    NSString *path = [bundle pathForResource:@"character" ofType:@"plist"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    
    self.characterImageNameList = dictionary[@"characterImageName"];
    self.characterInfoList = dictionary[@"characterInfo"];
    
}

-(void)setTableView {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = cellRowEstimateHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MAX(self.characterImageNameList.count, self.characterInfoList.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.characterInfoList[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.characterImageNameList[indexPath.row]];
    
    return cell;
}

@end
