//
//  SearchViewController.m
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/12.
//

#import "SearchViewController.h"
#import "Masonry.h"
#import "PlayerViewManager.h"
#import "SongInfoTableCell.h"
#import "FolderTableCell.h"
#import "AlbumTableCell.h"
#import "LyricTableCell.h"
#import "SingerTableCell.h"
#import <QMOpenApiSDK/QMOpenApiSDK.h>
#import "SongListViewController.h"
#import "AlbumListViewController.h"
#import "SVProgressHUD.h"

@interface SearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UISearchController *searchController;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) UITapGestureRecognizer *tapped;
@property (nonatomic) NSArray<QPSongInfo *>  *songs;
@property (nonatomic) NSArray<QPSinger *>  *singers;
@property (nonatomic) NSArray<QPAlbum *>  *albums;
@property (nonatomic) NSArray<QPLyricInfo *>  *lyrics;
@property (nonatomic) NSArray<QPFolder *>  *folders;
@property (nonatomic) NSInteger searchType; // 0：单曲搜索 3:歌单搜索 8：专辑搜索 15：电台 歌词：100//(默认为0)
@property (nonatomic) NSMutableDictionary *progressInfo;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
    [self setupConstraints];
    
    QPSongInfo *song = [[QPSongInfo alloc] init];
    song.identifier = @"5105986";
    
    
    [[QPOpenAPIManager sharedInstance] fetchSongInfoBatchWithId:@[song] completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
        
    }];
}

- (void) commonInit{
    
    self.songs = [NSArray array];
    self.folders = [NSArray array];
    self.albums = [NSArray array];
    self.lyrics = [NSArray array];
    self.singers = [NSArray array];
    self.progressInfo= [NSMutableDictionary dictionary];
    
    self.tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.obscuresBackgroundDuringPresentation = NO;
    self.searchController.searchBar.placeholder = @"搜索";
    
    if (@available(iOS 11.0, *)) {
        self.navigationItem.searchController = self.searchController;
    } else {
        UIImage *image = [UIImage imageNamed:@"search"];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(createFolderButtonPressed)];
        item.imageInsets = UIEdgeInsetsMake(5, 5, -5, -5);
        self.navigationItem.rightBarButtonItem = item;
    }
    self.definesPresentationContext = YES;
    self.searchController.searchBar.scopeButtonTitles = @[@"单曲",@"歌单",@"专辑",@"电台",@"歌词",@"歌手"];
    self.searchController.searchBar.delegate = self;
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.rowHeight = 70;
    [self.tableView registerClass:[SongInfoTableCell class] forCellReuseIdentifier:@"SongInfoTableCell"];
    [self.tableView registerClass:[FolderTableCell class] forCellReuseIdentifier:@"FolderTableCell"];
    [self.tableView registerClass:[AlbumTableCell class] forCellReuseIdentifier:@"AlbumTableCell"];
    [self.tableView registerClass:[LyricTableCell class] forCellReuseIdentifier:@"LyricTableCell"];
    [self.tableView registerClass:[SingerTableCell class] forCellReuseIdentifier:@"SingerTableCell"];
    
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)createFolderButtonPressed {
    [self presentViewController:self.searchController animated:YES completion:^{}];
}

- (void)setupConstraints{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewTapped {
    [self.searchController.searchBar resignFirstResponder];
    [self.view endEditing:YES];
}

#pragma mark - Notifactions
- (void)keyboardDidShow:(NSNotification *)notification {
    [self.view addGestureRecognizer:self.tapped];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self.view removeGestureRecognizer:self.tapped];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    if (selectedScope == 0) {
        self.searchType = 0;
    }
    else if (selectedScope == 1){
        self.searchType = 3;
    }
    else if (selectedScope == 2){
        self.searchType = 8;
    }
    else if (selectedScope == 3){
        self.searchType = 15;
    }else if (selectedScope == 4){
        self.searchType = 100;
    }
    else if (selectedScope == 5){
        self.searchType = -1;
    }
    if (self.searchController.searchBar.text.length) {
        if (selectedScope == 5) {//歌手搜索单独的接口
            __weak __typeof(self) weakSelf = self;
            [[QPOpenAPIManager sharedInstance] searchSingerWithKeyword:self.searchController.searchBar.text pageNumber:nil pageSize:nil completion:^(NSArray<QPSinger *> * _Nullable singers, NSError * _Nullable error) {
                if (!error) {
                    weakSelf.singers = singers;
                    [weakSelf.tableView reloadData];
                }
            }];
        }else {
            [self beginToSearch];
        }
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (self.searchType == -1) {//歌手搜索单独的接口
        __weak __typeof(self) weakSelf = self;
        [[QPOpenAPIManager sharedInstance] searchSingerWithKeyword:self.searchController.searchBar.text pageNumber:nil pageSize:nil completion:^(NSArray<QPSinger *> * _Nullable singers, NSError * _Nullable error) {
            if (!error) {
                weakSelf.singers = singers;
                [weakSelf.tableView reloadData];
            }
        }];
    }else {
        [self beginToSearch];
    }
}

- (void)beginToSearch {
    __weak __typeof(self) weakSelf = self;
    [[QPOpenAPIManager sharedInstance] searchWithKeyword:self.searchController.searchBar.text typeNumber:[NSNumber numberWithInteger:self.searchType] pageSize:nil pageNumber:nil completion:^(QPSearchResult * _Nullable result, NSError * _Nullable error) {
        if (result.songs.count) {
            weakSelf.songs = result.songs;
        }else if (result.folders.count){
            weakSelf.folders = result.folders;
        }
        else if (result.albums.count){
            weakSelf.albums = result.albums;
        }
        else if (result.lyrics.count){
            weakSelf.lyrics = result.lyrics;
        }
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.searchType == 0) {
        [[PlayerViewManager sharedInstance] showWithSongList:self.songs index:indexPath.row autoPlay:YES];
    }
    else if (self.searchType == 3){
        SongListViewController *vc = [[SongListViewController alloc] initWithFolder:self.folders[indexPath.row]];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (self.searchType == 8 || self.searchType == 15){
        SongListViewController *vc = [[SongListViewController alloc] initWithAlbum:self.albums[indexPath.row]];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (self.searchType == 100){

    }
    else if (self.searchType == -1){//歌手 单独接口
        QPSinger *singer = self.singers[indexPath.row];
        if (singer.totalAlbums) {
            AlbumListViewController *vc = [[AlbumListViewController alloc] initWithSinger:singer];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (singer.totalSongs) {
            SongListViewController *vc = [[SongListViewController alloc] initWithSinger:singer];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else {
            [SVProgressHUD showInfoWithStatus:@"这位歌手啥也没有"];
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchType == 0) {
        return self.songs.count;
    }
    else if (self.searchType == 3){
        return self.folders.count;
    }
    else if (self.searchType == 8 || self.searchType == 15){
        return self.albums.count;
    }
    else if (self.searchType == 100){
        return self.lyrics.count;
    }
    else if (self.searchType == -1){//歌手 单独接口
        return self.singers.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.searchType == 0) {
        SongInfoTableCell *cell = (SongInfoTableCell *)[tableView dequeueReusableCellWithIdentifier:@"SongInfoTableCell" forIndexPath:indexPath];
        [cell updateCellWithSongInfo:self.songs[indexPath.row]];
        __weak typeof(cell) weakCell = cell;
        __weak typeof(self) weakSelf = self;
        cell.downloadBtnClicked = ^{
            [[QPlayerManager sharedInstance] preDownloadSong:self.songs[indexPath.row] handler:^(int status,float progress, NSString * _Nonnull errMsg) {
                [weakSelf.progressInfo setObject:[NSNumber numberWithFloat:progress] forKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
                [weakCell updateProgress:progress];
            }];
        };
        NSNumber *number = [weakSelf.progressInfo objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
        [cell updateProgress:number.floatValue];
        return cell;
    }
    else if (self.searchType == 3){
        FolderTableCell *cell = (FolderTableCell *)[tableView dequeueReusableCellWithIdentifier:@"FolderTableCell" forIndexPath:indexPath];
        [cell.collectedButton setHidden:YES];
        [cell updateCellWithFolder:self.folders[indexPath.row]];
        return cell;
    }
    else if (self.searchType == 8 || self.searchType == 15){
        AlbumTableCell *cell = (AlbumTableCell *)[tableView dequeueReusableCellWithIdentifier:@"AlbumTableCell" forIndexPath:indexPath];
        [cell updateCellWithAlbum:self.albums[indexPath.row]];
        return cell;
    }
    else if (self.searchType == 100){
        LyricTableCell *cell = (LyricTableCell *)[tableView dequeueReusableCellWithIdentifier:@"LyricTableCell" forIndexPath:indexPath];
        [cell updateCellWithLyricInfo:self.lyrics[indexPath.row]];
        return cell;
    }
    else if (self.searchType == -1){
        SingerTableCell *cell = (SingerTableCell *)[tableView dequeueReusableCellWithIdentifier:@"SingerTableCell" forIndexPath:indexPath];
        [cell updateCellWithSinger:self.singers[indexPath.row]];
        return cell;
    }
    return [[UITableViewCell alloc] init];
}
@end
