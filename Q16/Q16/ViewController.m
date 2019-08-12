//
//  ViewController.m
//  Q16
//
//  Created by hschan on 2019/08/11.
//  Copyright © 2019 hschan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *sectionNameList;
@property (strong, nonatomic) NSArray *cellImageList;
@property (strong, nonatomic) NSArray *cellInfoList;
@property (strong, nonatomic) NSDictionary *plistDictionary;

- (void)setupTableView;
- (void)getPlistData;

@end


typedef NS_ENUM(NSUInteger, mealCategory) {
    foodCategory,
    soupCategory,
    drinkCategory
};

// セクションの高さ
static CGFloat const CellHeight = 30;
// セルの高さ
static CGFloat const cellRowEstimateHeight = 200;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self getPlistData];
}

//tableViewをセット
- (void)setupTableView{
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = cellRowEstimateHeight;
}

//plistからデータを取得
- (void)getPlistData{
    NSBundle *bundle = NSBundle.mainBundle;
    NSString *path = [bundle pathForResource:@"Property List" ofType:@"plist"];
    self.plistDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    self.sectionNameList = self.plistDictionary[@"sectionName"];
    self.cellImageList = self.plistDictionary[@"foodImageName"];
    self.cellInfoList = self.plistDictionary[@"foodInfo"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionNameList.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionNameList[section];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return CellHeight;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CellHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MAX(self.cellImageList.count, self.cellInfoList.count);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // インスタンス化
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // 違うセッションにし違う配列を設置
    switch (indexPath.section) {
        case foodCategory:
            self.cellImageList = self.plistDictionary[@"foodImageName"];
            self.cellInfoList = self.plistDictionary[@"foodInfo"];
            break;
        case soupCategory:
            self.cellImageList = self.plistDictionary[@"soupImageName"];
            self.cellInfoList = self.plistDictionary[@"soupInfo"];
            break;
        case drinkCategory:
            self.cellImageList = self.plistDictionary[@"drinkImageName"];
            self.cellInfoList = self.plistDictionary[@"drinkInfo"];
            break;
        default:
            break;
    }
    cell.textLabel.text = self.cellInfoList[indexPath.row];
    cell.imageView.image = [UIImage imageNamed: self.cellImageList[indexPath.row]];
    return cell;
}


@end
