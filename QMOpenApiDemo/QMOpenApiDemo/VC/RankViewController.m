//
//  RankViewController.m
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/22.
//

#import "RankViewController.h"
#import "Masonry.h"
#import <QMOpenApiSDK/QMOpenApiSDK.h>
#import "RankTableCell.h"
#import "SVProgressHUD.h"
#import "SongListViewController.h"

@interface RankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray<QPCategory *>  *categories;
@property (nonatomic) NSMutableDictionary<NSString*,NSArray<QPRank *>*> *data;
@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.categories = [NSArray array];
    self.data = [NSMutableDictionary dictionary];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.rowHeight = 70;
    [self.tableView registerClass:[RankTableCell class] forCellReuseIdentifier:@"RankTableCell"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self fetchData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusChanged) name: QPOpenIDServiceLoginStatusChanged object:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.categories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray<QPRank *> *ranks = [self.data objectForKey:self.categories[section].identifier];
    return ranks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RankTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankTableCell" forIndexPath:indexPath];
    NSArray<QPRank *> *ranks = [self.data objectForKey:self.categories[indexPath.section].identifier];
    if (ranks) {
        QPRank *rank = ranks[indexPath.row];
        [cell updateCellWithRank:rank];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.categories[section].name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray<QPRank *> *ranks = [self.data objectForKey:self.categories[indexPath.section].identifier];
    if (ranks) {
        QPRank *rank = ranks[indexPath.row];
        SongListViewController *vc = [[SongListViewController alloc] initWithRank:rank];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

- (void)loginStatusChanged {
    if ([QPAccountManager sharedInstance].isLogin) {
        [self fetchData];
    }
    else {
        self.categories = [NSArray array];
        self.data = [NSMutableDictionary dictionary];
        [self.tableView reloadData];
    }
}

- (void)fetchData {
    __weak __typeof(self) weakSelf = self;
    [[QPOpenAPIManager sharedInstance] fetchCategoryOfRankWithCompletion:^(NSArray<QPCategory *> * _Nullable categories, NSError * _Nullable error) {
        if (!error) {
            weakSelf.categories = categories;
            for (QPCategory *category in categories) {
                [[QPOpenAPIManager sharedInstance] fetchRankListByCategoryWithId:category.identifier completion:^(NSArray<QPRank *> * _Nullable ranks, NSError * _Nullable error) {
                    if (!error) {
                        if (ranks) {
                            [weakSelf.data setObject:ranks forKey:category.identifier];
                        }
                        [weakSelf.tableView reloadData];
                    }
                }];
            }
        }
    }];
}

@end
