//
//  FolderListViewController.m
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/27.
//

#import "FolderListViewController.h"
#import "Masonry.h"
#import "SVProgressHUD.h"
#import "FolderTableCell.h"
#import "SongListViewController.h"

@interface FolderListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray<QPFolder *> *folders;
@property (nonatomic) QPCategory *category;
@end

@implementation FolderListViewController

- (instancetype)initWithCategory:(QPCategory *)category{
    self = [super init];
    if (self) {
        self.category = category;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.navigationItem.title = self.category.name;
    self.folders = [NSArray array];

    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.rowHeight = 70;
    self.tableView.delaysContentTouches = NO;
    [self.tableView registerClass:[FolderTableCell class] forCellReuseIdentifier:@"FolderTableCell"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    __weak __typeof(self) weakSelf = self;
    [[QPOpenAPIManager sharedInstance] fetchFolderListByCategoryWithId:self.category.identifier pageNumber:nil pageSize:nil completion:^(NSArray<QPFolder *> * _Nullable folders, NSError * _Nullable error) {
        if (!error) {
            weakSelf.folders = folders;
            [weakSelf.tableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.folders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FolderTableCell *cell = (FolderTableCell *)[tableView dequeueReusableCellWithIdentifier:@"FolderTableCell" forIndexPath:indexPath];
    cell.collectedButton.tag = indexPath.row;
    [cell.collectedButton addTarget:self action:@selector(collectButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell updateCellWithFolder:self.folders[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SongListViewController *vc = [[SongListViewController alloc] initWithFolder:self.folders[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)collectButtonPressed:(UIButton *)sender {
    QPFolder *folder = self.folders[sender.tag];
    if (folder.isCollected) {
        __weak __typeof(self) weakSelf = self;
        [[QPOpenAPIManager sharedInstance] uncollectFolderWithId:folder.identifier completion:^(NSError * _Nullable error) {
            if (!error) {
                folder.isCollected = YES;
                [weakSelf.tableView reloadData];
            }
            else {
                [SVProgressHUD showErrorWithStatus:error.userInfo[@"message"]];
            }
        }];
    }else {
        __weak __typeof(self) weakSelf = self;
        [[QPOpenAPIManager sharedInstance] collectFolderWithId:folder.identifier completion:^(NSError * _Nullable error) {
            if (!error) {
                folder.isCollected = YES;
                [weakSelf.tableView reloadData];
            }
            else {
                [SVProgressHUD showErrorWithStatus:error.userInfo[@"message"]];
            }
        }];
    }
}

@end
