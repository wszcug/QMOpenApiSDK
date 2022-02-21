//
//  AlbumListViewController.m
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/30.
//

#import "AlbumListViewController.h"
#import "Masonry.h"
#import "AlbumTableCell.h"
#import "SongListViewController.h"

@interface AlbumListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@property (nonatomic,nullable) QPSinger *singer;
@property (nonatomic) NSArray<QPAlbum *>  *albums;
@end

@implementation AlbumListViewController

- (instancetype)initWithSinger:(QPSinger *)singer{
    self = [super init];
    if (self) {
        self.singer = singer;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.albums= [NSArray array];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.rowHeight = 70;
    [self.tableView registerClass:[AlbumTableCell class] forCellReuseIdentifier:@"AlbumTableCell"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    if (self.singer) {
        self.navigationItem.title = self.singer.name;
        __weak __typeof(self) weakSelf = self;
        [[QPOpenAPIManager sharedInstance] fetchAlbumOfSingerWithId:self.singer.identifier pageNumber:[NSNumber numberWithInt:0] pageSize:[NSNumber numberWithInt:50] order:1 completion:^(NSArray<QPAlbum *> * _Nullable albums, NSInteger total, NSError * _Nullable error) {
            if (!error) {
                weakSelf.albums = albums;
                [weakSelf.tableView reloadData];
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

@end
