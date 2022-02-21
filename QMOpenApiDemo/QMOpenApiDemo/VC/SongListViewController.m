//
//  SongListViewController.m
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/22.
//

#import "SongListViewController.h"
#import "Masonry.h"
#import "SongInfoTableCell.h"
#import "PlayerViewManager.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"

@interface SongListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSString *titleStr;
@property (nonatomic) NSString *identifier;
@property (nonatomic) NSMutableArray<QPSongInfo *> *songs;
@property (nonatomic, nullable)QPFolder *folder;
@property (nonatomic, nullable)QPSinger *singer;
@property (nonatomic, nullable)QPAlbum *album;
@property (nonatomic, nullable)QPRank *rank;
@property (nonatomic) NSNumber *pageNumber;
@end

@implementation SongListViewController

- (instancetype)initWithSinger:(QPSinger *)singer {
    self = [super init];
    if (self) {
        self.singer = singer;
    }
    return self;
}

- (instancetype)initWithFolder:(QPFolder *)folder {
    self = [super init];
    if (self) {
        self.folder = folder;
    }
    return self;
}

- (instancetype)initWithAlbum:(QPAlbum *)album {
    self = [super init];
    if (self) {
        self.album = album;
    }
    return self;
}

- (instancetype)initWithRank:(QPRank *)rank {
    self = [super init];
    if (self) {
        self.rank = rank;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.pageNumber = [NSNumber numberWithInt:0];
    self.songs = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.rowHeight = 70;
    [self.tableView registerClass:[SongInfoTableCell class] forCellReuseIdentifier:@"SongInfoTableCell"];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    __weak __typeof(self) weakSelf = self;
    if (self.folder) {
        self.navigationItem.title = self.folder.name;
        [[QPOpenAPIManager sharedInstance] fetchSongOfFolderWithId:self.folder.identifier pageNumber:self.pageNumber pageSize:[NSNumber numberWithInt:50] completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
            if (!error) {
                if (songs) {
                    [weakSelf.songs addObjectsFromArray:songs];
                }
                [weakSelf.tableView reloadData];
            }
        }];
    }else if (self.rank){
        self.navigationItem.title = self.rank.name;
        [[QPOpenAPIManager sharedInstance] fetchSongOfRankWithId:self.rank.identifier pageNumber:self.pageNumber pageSize:[NSNumber numberWithInt:50] completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
            if (!error) {
                if (songs) {
                    [weakSelf.songs addObjectsFromArray:songs];
                }
                [weakSelf.tableView reloadData];
            }
        }];
    }
    else if (self.album){
        self.navigationItem.title = self.album.name;
        [[QPOpenAPIManager sharedInstance] fetchSongOfAlbumWithId:self.album.identifier pageNumber:[NSNumber numberWithInt:0] pageSize:[NSNumber numberWithInt:50] completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
            if (!error) {
                if (songs) {
                    [weakSelf.songs addObjectsFromArray:songs];
                }
                [weakSelf.tableView reloadData];
            }
        }];
    }
    else if (self.singer){
        [[QPOpenAPIManager sharedInstance] fetchSongOfSingerWithId:self.singer.identifier pageNumber:[NSNumber numberWithInt:0] pageSize:[NSNumber numberWithInt:50] order:1 completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
            if (!error) {
                if (songs) {
                    [weakSelf.songs addObjectsFromArray:songs];
                }
                [weakSelf.tableView reloadData];
            }
        }];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(songDidChanged) name:QPlayer_CurrentSongChanged object:nil];
}

- (void)songDidChanged {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QPSongInfo *song = self.songs[indexPath.row];
    if (song.canPlay || song.canTryPlay) {
        [[PlayerViewManager sharedInstance] showWithSongList:self.songs index:indexPath.row autoPlay:YES];
    }else {
        [SVProgressHUD showInfoWithStatus:song.unplayableMessage];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SongInfoTableCell *cell = (SongInfoTableCell *)[tableView dequeueReusableCellWithIdentifier:@"SongInfoTableCell" forIndexPath:indexPath];
    [cell updateCellWithSongInfo:self.songs[indexPath.row]];
    return cell;
}

#pragma mark: - Actions
- (void)loadMoreData {
    __weak __typeof(self) weakSelf = self;
    if (self.folder) {
        if (self.songs.count >= self.folder.totalNum) {
            return;
        }
        self.pageNumber = [NSNumber numberWithInt:self.pageNumber.intValue+1];
        self.navigationItem.title = self.folder.name;
        [[QPOpenAPIManager sharedInstance] fetchSongOfFolderWithId:self.folder.identifier pageNumber:self.pageNumber pageSize:[NSNumber numberWithInt:50] completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
            if (!error) {
                [weakSelf.tableView.mj_footer endRefreshing];
                if (songs) {
                    [weakSelf.songs addObjectsFromArray:songs];
                }
                [weakSelf.tableView reloadData];
            }
        }];
    }else if (self.rank){
        if (self.songs.count >= self.rank.total) {
            return;
        }
        self.pageNumber = [NSNumber numberWithInt:self.pageNumber.intValue+1];
        self.navigationItem.title = self.rank.name;
        [[QPOpenAPIManager sharedInstance] fetchSongOfRankWithId:self.rank.identifier pageNumber:self.pageNumber pageSize:[NSNumber numberWithInt:50] completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
            if (!error) {
                [weakSelf.tableView.mj_footer endRefreshing];
                if (songs) {
                    [weakSelf.songs addObjectsFromArray:songs];
                }
                [weakSelf.tableView reloadData];
            }
        }];
    }
    else if (self.album){
        if (self.songs.count >= self.album.total) {
            return;
        }
        self.pageNumber = [NSNumber numberWithInt:self.pageNumber.intValue+1];
        self.navigationItem.title = self.album.name;
        [[QPOpenAPIManager sharedInstance] fetchSongOfAlbumWithId:self.album.identifier pageNumber:self.pageNumber pageSize:[NSNumber numberWithInt:50] completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
            if (!error) {
                [weakSelf.tableView.mj_footer endRefreshing];
                if (songs) {
                    [weakSelf.songs addObjectsFromArray:songs];
                }
                [weakSelf.tableView reloadData];
            }
        }];
    }
    else if (self.singer){
        if (self.songs.count >= self.singer.totalSongs) {
            return;
        }
        self.pageNumber = [NSNumber numberWithInt:self.pageNumber.intValue+1];
        [[QPOpenAPIManager sharedInstance] fetchSongOfSingerWithId:self.singer.identifier pageNumber:self.pageNumber pageSize:[NSNumber numberWithInt:50] order:1 completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
            if (!error) {
                if (!error) {
                    [weakSelf.tableView.mj_footer endRefreshing];
                    if (songs) {
                        [weakSelf.songs addObjectsFromArray:songs];
                    }
                    [weakSelf.tableView reloadData];
                }
            }
        }];
    }
}

@end
