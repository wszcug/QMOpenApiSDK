//
//  PlaylistViewController.m
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/26.
//

#import "PlaylistViewController.h"
#import "Masonry.h"
#import "PlaylistTableCell.h"
#import <QMOpenApiSDK/QMOpenApiSDK.h>

@interface PlaylistViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@end

@implementation PlaylistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.rowHeight = 60;
    [self.tableView registerClass:[PlaylistTableCell class] forCellReuseIdentifier:@"PlaylistTableCell"];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(songDidChanged) name:QPlayer_CurrentSongChanged object:nil];
}

#pragma mark: - Notification
- (void)songDidChanged {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark: - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [QPlayerManager sharedInstance].playlist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlaylistTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaylistTableCell" forIndexPath:indexPath];
    QPSongInfo *song = [QPlayerManager sharedInstance].playlist[indexPath.row];
    [cell updateCellWithSongInfo:song isHighted:[song.mid isEqualToString:[QPlayerManager sharedInstance].currentSong.mid]];
    return cell;
}

#pragma mark: - UITableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"共%ld首",[QPlayerManager sharedInstance].playlist.count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[QPlayerManager sharedInstance] playAtIndex:indexPath.row];
}

@end
