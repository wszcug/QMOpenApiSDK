//
//  LongAudioViewController.m
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/30.
//

#import "LongAudioListController.h"
#import "Masonry.h"
#import "AlbumTableCell.h"
#import "SongListViewController.h"
#import "FilterTableHeaderView.h"

@interface LongAudioListController ()<UITableViewDelegate,UITableViewDataSource,FilterTableHeaderViewDelegate>
@property (nonatomic) UITableView *tableView;
@property (nonatomic) QPCategory *category;
@property (nonatomic) QPCategory *subCategory;
@property (nonatomic) NSArray<QPAlbum *>  *albums;
@property (nonatomic) NSDictionary<NSString *,NSArray<QPCategory *> *> *filters;//所有过滤分类
@property (nonatomic) NSArray<QPCategory *> *filterCategories;//网络请求传送过滤分类
@end

@implementation LongAudioListController

- (instancetype)initWithCategory:(QPCategory *)category subCategory:(QPCategory *)subCategory{
    self = [super init];
    if (self) {
        self.category = category;
        self.subCategory = subCategory;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.albums= [NSArray array];
    self.filters = [NSDictionary dictionary];
    self.filterCategories = [NSArray array];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.rowHeight = 70;
    [self.tableView registerClass:[AlbumTableCell class] forCellReuseIdentifier:@"AlbumTableCell"];
    [self.tableView registerClass:[FilterTableHeaderView class] forHeaderFooterViewReuseIdentifier:@"FilterTableHeaderView"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    if (self.category) {
        self.navigationItem.title = self.subCategory.name;
        __weak __typeof(self) weakSelf = self;
        [[QPOpenAPIManager sharedInstance] fetchCategoryFilterOfLongAudioWithId:self.category.identifier subCateoryId:self.subCategory.identifier completion:^(NSDictionary<NSString *,NSArray<QPCategory *> *> * _Nullable categories, NSError * _Nullable error) {
            if (!error) {
                weakSelf.filters = categories;
                [[QPOpenAPIManager sharedInstance] fetchAlbumListOfLongAuidoByCategoryWithId:self.category.identifier subCategoryId:self.subCategory.identifier sortType:1 pageSize:[NSNumber numberWithInt:60] pageNumber:[NSNumber numberWithInt:0] filterCategories:self.filterCategories completion:^(NSArray<QPAlbum *> * _Nullable albums, NSInteger total, NSError * _Nullable error) {
                    if (!error) {
                        weakSelf.albums = albums;
                        [weakSelf.tableView reloadData];
                    }
                }];
            }
        }];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.albums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlbumTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumTableCell" forIndexPath:indexPath];
    [cell updateCellWithAlbum:self.albums[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SongListViewController *vc = [[SongListViewController alloc] initWithAlbum:self.albums[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FilterTableHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FilterTableHeaderView"];
    header.delegate = self;
    [header updateWithFilters:self.filters];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.filters.count) {
        return self.filters.count*40+(self.filters.count+1)*20;
    }
    return 0;
}

#pragma  mark: -FilterTableHeaderViewDelegate
- (void)selectedFilterDidChanged:(NSArray<QPCategory *> *)filters {
    self.filterCategories = filters;
    __weak __typeof(self) weakSelf = self;
    [[QPOpenAPIManager sharedInstance] fetchCategoryFilterOfLongAudioWithId:self.category.identifier subCateoryId:self.subCategory.identifier completion:^(NSDictionary<NSString *,NSArray<QPCategory *> *> * _Nullable categories, NSError * _Nullable error) {
        if (!error) {
            weakSelf.filters = categories;
            [[QPOpenAPIManager sharedInstance] fetchAlbumListOfLongAuidoByCategoryWithId:self.category.identifier subCategoryId:self.subCategory.identifier sortType:1 pageSize:[NSNumber numberWithInt:60] pageNumber:[NSNumber numberWithInt:0] filterCategories:self.filterCategories completion:^(NSArray<QPAlbum *> * _Nullable albums, NSInteger total, NSError * _Nullable error) {
                if (!error) {
                    weakSelf.albums = albums;
                    [weakSelf.tableView reloadData];
                }
            }];
        }
    }];
}
@end
