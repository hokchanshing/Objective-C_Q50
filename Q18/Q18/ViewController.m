//
//  ViewController.m
//  Q18
//
//  Created by hschan on 2019/08/12.
//  Copyright © 2019 hschan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

// プロパティ定義
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *sectionName;
@property (strong, nonatomic) NSArray *foodImageName;
@property (strong, nonatomic) NSArray *soupImageName;
@property (strong, nonatomic) NSArray *drinkImageName;

// メソッド定義
- (void)getPlistData;
- (void)setupNibFile;
@end

// セルの大きさの割合を決める定数を用意
static double const CellSizeDivisionNumber  = 2.5;
// セクションの高さ
static CGFloat const SectionHeight = 30;
//　セル画像判別用の変数を定義
typedef NS_ENUM(NSUInteger, mealCategory) {
    foodCategory,
    soupCategory,
    drinkCategory,
};

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNibFile];
    [self getPlistData];
}

// nibファイルの登録、セットアップ
- (void)setupNibFile {
    UINib *cellNibFile = [UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNibFile forCellWithReuseIdentifier:@"Cell"];
    
    UINib *headerNibFile = [UINib nibWithNibName:@"CustomCollectionReusableView" bundle:nil];
    [self.collectionView registerNib:headerNibFile forSupplementaryViewOfKind:UICollectionElementKindSectionHeader      withReuseIdentifier:@"Header"];
}

// 表示データの取得
- (void)getPlistData {
    // セル内のデータを用意
    //プロジェクト内のファイルにアクセスできるオブジェクトを宣言
    NSBundle *bundle = NSBundle.mainBundle;
    //読み込むプロパティリストのファイルパスを指定
    NSString *path = [bundle pathForResource:@"Property List" ofType:@"plist"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    self.foodImageName = dictionary[@"foodImageName"];
    self.soupImageName = dictionary[@"soupImageName"];
    self.drinkImageName = dictionary[@"drinkImageName"];
    self.sectionName = dictionary[@"sectionName"];
}

// セクションの数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionName.count;
}

// セッションを作成
- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    
    header.headerLabel.text = self.sectionName[indexPath.section];
    
    // セクションを実装
    return header;
}

// セクションのサイズ
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGFloat sectionWidth = self.collectionView.bounds.size.width;
    CGSize sectionSize = CGSizeMake(sectionWidth, SectionHeight);
    return sectionSize;
}

// セルの数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.foodImageName.count;
}

// セルを作成
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    // セクションの内容を分ける
    switch (indexPath.section) {
        case foodCategory:
            cell.cellImageView.image = [UIImage imageNamed:self.foodImageName[indexPath.row]];
            break;
        case soupCategory:
            cell.cellImageView.image = [UIImage imageNamed:self.soupImageName[indexPath.row]];
            break;
        case drinkCategory:
            cell.cellImageView.image = [UIImage imageNamed:self.drinkImageName[indexPath.row]];
            break;
        default:
            break;
    }
    // セルを実装
    return cell;
}

// セルのサイズ
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat CellSize = self.collectionView.bounds.size.width/CellSizeDivisionNumber;
    CGSize size = CGSizeMake(CellSize, CellSize);
    return size;
}

@end

