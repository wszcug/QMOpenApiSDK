//
//  RadioViewController.m
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/12.
//

#import "RadioViewController.h"
#import "Masonry.h"
#import <QMOpenApiSDK/QMOpenApiSDK.h>
#import "CategoryCollectionCell.h"
#import "CategoryHeaderView.h"
#import "LongAudioListController.h"

@interface RadioViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) NSArray<QPCategory *> *categories;
@end

@implementation RadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void) commonInit{
    self.categories = [NSArray array];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    CGFloat width = self.view.bounds.size.width/4.0;
    layout.itemSize = CGSizeMake(width,width/2.0);

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                         collectionViewLayout:layout];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = UIColor.whiteColor;
    [self.collectionView registerClass:[CategoryCollectionCell class]
        forCellWithReuseIdentifier:@"CategoryCollectionCell"];
    [self.collectionView registerClass:[CategoryHeaderView class]
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:@"CategoryHeaderView"];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    [[QPOpenAPIManager sharedInstance] createGreenOrderWithMchId:@"95B26A42074C906A" numberOfMonth:3 completion:^(NSString * _Nullable orderId, NSError * _Nullable error) {
        
    }];
    
    __weak __typeof(self) weakSelf = self;
    [[QPOpenAPIManager sharedInstance] fetchCategoryOfLongAudioWithCompletion:^(NSArray<QPCategory *> * _Nullable filterCategories, NSError * _Nullable error) {
        weakSelf.categories = filterCategories;
        [weakSelf.collectionView reloadData];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusChanged) name: QPOpenIDServiceLoginStatusChanged object:nil];
}

#pragma mark: - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.categories.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categories[section].subCategories.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCollectionCell" forIndexPath:indexPath];
    [cell updateCellWithCategory:self.categories[indexPath.section].subCategories[indexPath.row]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
  if (kind == UICollectionElementKindSectionHeader) {
    CategoryHeaderView *header = [collectionView
        dequeueReusableSupplementaryViewOfKind:
            UICollectionElementKindSectionHeader
                           withReuseIdentifier:@"CategoryHeaderView"
                                  forIndexPath:indexPath];
    header.titleLabel.text = self.categories[indexPath.section].name;
    return header;
  }
  return [[UICollectionReusableView alloc] init];
}

#pragma mark : - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                             layout:
                                 (UICollectionViewLayout *)collectionViewLayout
    referenceSizeForHeaderInSection:(NSInteger)section {
  return CGSizeMake(self.view.bounds.size.width, 45);
    
}
#pragma mark: - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LongAudioListController *vc = [[LongAudioListController alloc] initWithCategory:self.categories[indexPath.section] subCategory:self.categories[indexPath.section].subCategories[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loginStatusChanged {
    if ([QPAccountManager sharedInstance].isLogin) {
        __weak __typeof(self) weakSelf = self;
        [[QPOpenAPIManager sharedInstance] fetchCategoryOfLongAudioWithCompletion:^(NSArray<QPCategory *> * _Nullable filterCategories, NSError * _Nullable error) {
            weakSelf.categories = filterCategories;
            [weakSelf.collectionView reloadData];
        }];
    }
    else {
        self.categories = [NSArray array];
        [self.collectionView reloadData];
    }
}

@end
