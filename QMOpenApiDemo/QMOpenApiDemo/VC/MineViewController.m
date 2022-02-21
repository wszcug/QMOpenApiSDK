//
//  MineViewController.m
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/12.
//

#import "MineViewController.h"
#import <QMOpenApiSDK/QMOpenApiSDK.h>
#import "SDWebImage.h"
#import "Masonry.h"
#import "SongInfoTableCell.h"
#import "FolderTableCell.h"
#import "AlbumTableCell.h"
#import "RankTableCell.h"
#import "SingerTableCell.h"
#import "SongListViewController.h"
#import "SVProgressHUD.h"
#import "TestViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "QRCodeLoginVC.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UIImageView *avatarImageView;
@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UIButton *logButton;
@property (nonatomic) UIButton *qqButton;
@property (nonatomic) UIButton *wechatButton;
@property (nonatomic) UIButton *qqmusicButton;
@property (nonatomic) UIButton *qrcodeButton;
@property (nonatomic) UIButton *logoutButton;
@property (nonatomic) UIButton *clearButton;
@property (nonatomic) UIButton *cacheButton;
@property (nonatomic) UIView *line;
@property (nonatomic) UISegmentedControl *segmentedControl;
@property (nonatomic) UITableView *tableView;

@property (nonatomic) NSMutableArray<QPFolder *>  *folders;
@property (nonatomic) NSArray<QPSongInfo *>  *songs;
@property (nonatomic) LoginViewController *loginVC;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
    [self setupConstraints];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height/2.0;
}

- (void) commonInit{
    self.folders = [NSMutableArray array];
    self.edgesForExtendedLayout = UIRectEdgeNone;
        
    UIImage *image = [UIImage imageNamed:@"plus"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(createFolderButtonPressed)];
    item.imageInsets = UIEdgeInsetsMake(5, 5, -5, -5);
    self.navigationItem.rightBarButtonItem = item;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"接口测试" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemPressed)];
        
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.image = [UIImage imageNamed:@"personal"];
    
    self.avatarImageView.clipsToBounds = YES;
    self.avatarImageView.backgroundColor = UIColor.lightGrayColor;
    [self.avatarImageView sd_setImageWithURL:[QPAccountManager sharedInstance].userInfo.avatarURL];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = UIColor.blackColor;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    self.nameLabel.text = [QPAccountManager sharedInstance].isLogin ? [QPAccountManager sharedInstance].userInfo.nickName : @"请先登录";
    
    self.qqButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.qqButton setTitle:@"QQ小程序登录" forState:UIControlStateNormal];
    self.qqButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    self.qqButton.backgroundColor = UIColor.lightGrayColor;
    [self.qqButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    self.qqButton.layer.cornerRadius = 5;
    [self.qqButton addTarget:self action:@selector(qqButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.logButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.logButton setTitle:@"日志上传" forState:UIControlStateNormal];
    self.logButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    self.logButton.backgroundColor = UIColor.lightGrayColor;
    [self.logButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    self.logButton.layer.cornerRadius = 5;
    [self.logButton addTarget:self action:@selector(logButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.wechatButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.wechatButton setTitle:@"微信小程序登录" forState:UIControlStateNormal];
    self.wechatButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    self.wechatButton.backgroundColor = UIColor.lightGrayColor;
    [self.wechatButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    self.wechatButton.layer.cornerRadius = 5;
    [self.wechatButton addTarget:self action:@selector(wechatButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.qqmusicButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.qqmusicButton setTitle:@"QQ音乐登录" forState:UIControlStateNormal];
    self.qqmusicButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    self.qqmusicButton.backgroundColor = UIColor.lightGrayColor;
    [self.qqmusicButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    self.qqmusicButton.layer.cornerRadius = 5;
    [self.qqmusicButton addTarget:self action:@selector(qqmusicButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.qrcodeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.qrcodeButton setTitle:@"二维码登录" forState:UIControlStateNormal];
    self.qrcodeButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    self.qrcodeButton.backgroundColor = UIColor.lightGrayColor;
    [self.qrcodeButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    self.qrcodeButton.layer.cornerRadius = 5;
    [self.qrcodeButton addTarget:self action:@selector(qrcodeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.logoutButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.logoutButton setTitle:@"登出" forState:UIControlStateNormal];
    self.logoutButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    self.logoutButton.backgroundColor = UIColor.lightGrayColor;
    [self.logoutButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    self.logoutButton.layer.cornerRadius = 5;
    [self.logoutButton addTarget:self action:@selector(logoutButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.clearButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.clearButton setTitle:@"清理缓存" forState:UIControlStateNormal];
    self.clearButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    self.clearButton.backgroundColor = UIColor.lightGrayColor;
    [self.clearButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    self.clearButton.layer.cornerRadius = 5;
    [self.clearButton addTarget:self action:@selector(clearButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.cacheButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.cacheButton setTitle:[NSString stringWithFormat:@"缓存上限(%@)",[self stringCache:[QPlayerManager sharedInstance].playbackCache]] forState:UIControlStateNormal];
    self.cacheButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    self.cacheButton.backgroundColor = UIColor.lightGrayColor;
    [self.cacheButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    self.cacheButton.layer.cornerRadius = 5;
    [self.cacheButton addTarget:self action:@selector(cacheButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = UIColor.grayColor;
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"自建歌单",@"收藏歌单",@"最近播放"]];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl addTarget:self action:@selector(segmentedValueChanged:) forControlEvents:UIControlEventValueChanged];
    
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
    [self.tableView registerClass:[SingerTableCell class] forCellReuseIdentifier:@"SingerTableCell"];
    
    [self.view addSubview:self.avatarImageView];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.qqButton];
    [self.view addSubview:self.logButton];
    [self.view addSubview:self.qqmusicButton];
    [self.view addSubview:self.qrcodeButton];
    [self.view addSubview:self.wechatButton];
    [self.view addSubview:self.logoutButton];
    [self.view addSubview:self.clearButton];
    [self.view addSubview:self.cacheButton];
    [self.view addSubview:self.line];
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.tableView];
    
    __weak __typeof(self) weakSelf = self;
    [[QPOpenAPIManager sharedInstance] fetchPersonalFolderWithCompletion:^(NSArray<QPFolder *> * _Nullable folders, NSError * _Nullable error) {
        if (!error) {
            weakSelf.folders = [folders mutableCopy];
            [weakSelf.tableView reloadData];
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusChanged) name: QPOpenIDServiceLoginStatusChanged object:nil];
}

- (void)setupConstraints{
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(88);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20);
        make.leading.mas_equalTo(self.view.mas_leading).with.offset(20);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.avatarImageView.mas_centerX);
        make.top.mas_equalTo(self.avatarImageView.mas_bottom).with.offset(4);
    }];
    [self.qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(20);
        make.width.mas_equalTo(125);
        make.height.mas_equalTo(40);
        make.trailing.mas_equalTo(self.view.mas_trailing).with.offset(-12);
    }];
    [self.logButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qqButton);
        make.width.height.equalTo(self.qqButton);
        make.right.equalTo(self.qqButton.mas_left).offset(-8);
    }];
    [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.centerX.equalTo(self.logButton);
        make.top.mas_equalTo(self.wechatButton.mas_top);
    }];
    [self.cacheButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.centerX.equalTo(self.logButton);
        make.top.mas_equalTo(self.qqmusicButton.mas_top);
    }];
    [self.wechatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.trailing.equalTo(self.qqButton);
        make.top.mas_equalTo(self.qqButton.mas_bottom).with.offset(15);
    }];
    [self.qqmusicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.trailing.equalTo(self.qqButton);
        make.top.mas_equalTo(self.wechatButton.mas_bottom).with.offset(15);
    }];
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.avatarImageView.mas_centerX);
        make.bottom.equalTo(self.qqmusicButton);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(90);
    }];
    [self.qrcodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(self.qqButton);
        make.bottom.equalTo(self.avatarImageView.mas_top).offset(10);
        make.centerX.equalTo(self.avatarImageView);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.qqmusicButton.mas_bottom).with.offset(12);
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(0.5);
    }];
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view.mas_leading).with.offset(10);
        make.top.mas_equalTo(self.line.mas_bottom).with.offset(5);
        make.trailing.mas_lessThanOrEqualTo(self.view.mas_trailing).with.offset(-10);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view);
        make.top.mas_equalTo(self.segmentedControl.mas_bottom).with.offset(4);
    }];
}

#pragma mark- Actions
- (void)leftBarButtonItemPressed {
    TestViewController *vc = [[TestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cacheButtonPressed {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"设置缓存上限" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"100 MB" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [QPlayerManager sharedInstance].playbackCache = QPlaybackCache_100MB;
        [self.cacheButton setTitle:[NSString stringWithFormat:@"缓存上限(%@)",[self stringCache:[QPlayerManager sharedInstance].playbackCache]] forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"500 MB" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [QPlayerManager sharedInstance].playbackCache = QPlaybackCache_500MB;
        [self.cacheButton setTitle:[NSString stringWithFormat:@"缓存上限(%@)",[self stringCache:[QPlayerManager sharedInstance].playbackCache]] forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"800 MB" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [QPlayerManager sharedInstance].playbackCache = QPlaybackCache_800MB;
        [self.cacheButton setTitle:[NSString stringWithFormat:@"缓存上限(%@)",[self stringCache:[QPlayerManager sharedInstance].playbackCache]] forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"1 GB" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [QPlayerManager sharedInstance].playbackCache = QPlaybackCache_1GB;
        [self.cacheButton setTitle:[NSString stringWithFormat:@"缓存上限(%@)",[self stringCache:[QPlayerManager sharedInstance].playbackCache]] forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)clearButtonPressed {
    [[QPlayerManager sharedInstance] clearCache];
}

- (void)logoutButtonPressed {
    [[QPAccountManager sharedInstance] logout];
}

- (void)createFolderButtonPressed {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"新建歌单"
                               message:nil
                               preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = @"五月天歌曲合集";
    }];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
        NSString *text = alert.textFields.firstObject.text;
        if (text) {
            [[QPOpenAPIManager sharedInstance] createFolderWithName:text completion:^(NSString * _Nullable folderId, NSError * _Nullable error) {
                if (error) {
                    [SVProgressHUD showErrorWithStatus:error.userInfo[@"message"]];
                }else {
                    [SVProgressHUD showSuccessWithStatus:@"创建成功"];
                    [self segmentedValueChanged:self.segmentedControl];
                }
            }];
        }
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)segmentedValueChanged:(UISegmentedControl *)control {
    [self fetchData];
}

- (void) qqmusicButtonPressed {
    
    [[QPAccountManager sharedInstance] startQQMusicAuthenticationWithCompletion:^(BOOL success, NSString * _Nonnull msg) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"QQ音乐认证"
                                                                       message:[NSString stringWithFormat:@"status:%@\n message:%@",success?@"success":@"failed",msg] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:NULL];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:NULL];
        [self.avatarImageView sd_setImageWithURL:[QPAccountManager sharedInstance].userInfo.avatarURL];
        [self.nameLabel setText:[QPAccountManager sharedInstance].userInfo.nickName];
    }];
}

- (void)qrcodeButtonPressed {
    QRCodeLoginVC *qrvc = [[QRCodeLoginVC alloc] init];
    [self presentViewController:qrvc animated:YES completion:NULL];
}

- (void) qqButtonPressed {
//    [[QPAccountManager sharedInstance] startQQMiniAppAuthenticationWithCompletion:^(BOOL success, NSString * _Nonnull msg) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"QQ小程序认证"
//                                                                       message:[NSString stringWithFormat:@"status:%@\n message:%@",success?@"success":@"failed",msg] preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:NULL];
//        [alert addAction:action];
//        [self presentViewController:alert animated:YES completion:NULL];
//        [self.avatarImageView sd_setImageWithURL:[QPAccountManager sharedInstance].userInfo.avatarURL];
//        [self.nameLabel setText:[QPAccountManager sharedInstance].userInfo.nickName];
//    }];
//
    
    [[QPAccountManager sharedInstance] startQQH5AuthenticationWithWebUrl:^(NSString * _Nonnull webUrl) {
        if (webUrl.length) {
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            UIViewController *vc = window.rootViewController;
            if (vc) {
                self.loginVC = [[LoginViewController alloc] initWithUrl:webUrl];
                self.loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
                [vc presentViewController:self.loginVC animated:YES completion:NULL];
            }
        }
    } Completion:^(BOOL success, NSString * _Nonnull msg) {
        if (self.loginVC) {
            [self.loginVC dismissViewControllerAnimated:YES completion:NULL];
        }
    }];
}

- (void)logButtonPressed {
    NSInteger logid = [[QPAccountManager sharedInstance] uploadSDKLog];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:[NSString stringWithFormat:@"日志上传成功ID：(%ld)",logid]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)wechatButtonPressed {
    
    [[QPAccountManager sharedInstance] startWXMiniAppAuthenticationWithCompletion:^(BOOL success, NSString * _Nonnull msg) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"微信小程序认证"
                                                                       message:[NSString stringWithFormat:@"status:%@\n message:%@",success?@"success":@"failed",msg] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:NULL];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:NULL];
        [self.avatarImageView sd_setImageWithURL:[QPAccountManager sharedInstance].userInfo.avatarURL];
        [self.nameLabel setText:[QPAccountManager sharedInstance].userInfo.nickName];
    }];
}

- (void)loginStatusChanged {
    if ([QPAccountManager sharedInstance].isLogin) {
        [self fetchData];
        [self.avatarImageView sd_setImageWithURL:[QPAccountManager sharedInstance].userInfo.avatarURL];
        [self.nameLabel setText:[QPAccountManager sharedInstance].userInfo.nickName];
    }
    else {
        self.folders = [NSMutableArray array];
        self.songs = [NSArray array];
        self.avatarImageView.image = nil;
        self.nameLabel.text = @"请先登录";
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        return self.folders.count;
    }
    else if (self.segmentedControl.selectedSegmentIndex == 1){
        return self.folders.count;
    }
    else if (self.segmentedControl.selectedSegmentIndex == 2){
        return self.songs.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.segmentedControl.selectedSegmentIndex == 0 || self.segmentedControl.selectedSegmentIndex == 1) {
        FolderTableCell *cell = (FolderTableCell *)[tableView dequeueReusableCellWithIdentifier:@"FolderTableCell" forIndexPath:indexPath];
        if (self.segmentedControl.selectedSegmentIndex == 0) {
            [cell.collectedButton setHidden:YES];
        }else {
            [cell.collectedButton setHidden:NO];
            cell.collectedButton.tag = indexPath.row;
            [cell.collectedButton addTarget:self action:@selector(collectButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
        [cell updateCellWithFolder:self.folders[indexPath.row]];
        return cell;
    }
    else if (self.segmentedControl.selectedSegmentIndex == 2){
        SongInfoTableCell *cell = (SongInfoTableCell *)[tableView dequeueReusableCellWithIdentifier:@"SongInfoTableCell" forIndexPath:indexPath];
        [cell updateCellWithSongInfo:self.songs[indexPath.row]];
        return  cell;
    }
    return [[UITableViewCell alloc] init];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000
#pragma mark - UITableViewDelegate
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.segmentedControl.selectedSegmentIndex != 0) {
        return nil;
    }
    UIContextualAction *add = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"添加歌曲" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        [self addSongToFolder:self.folders[indexPath.row].identifier];
        completionHandler(YES);
    }];
    add.backgroundColor = [UIColor  lightGrayColor]; //arbitrary color
    
    UIContextualAction *delete = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"移除歌曲" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        [self deleteSongToFolder:self.folders[indexPath.row].identifier];
        completionHandler(YES);
    }];
    delete.backgroundColor = [UIColor redColor]; //arbitrary color
    
    UISwipeActionsConfiguration *swipeActionConfig = [UISwipeActionsConfiguration configurationWithActions:@[add,delete]];
    swipeActionConfig.performsFirstActionWithFullSwipe = NO;
    return swipeActionConfig;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.segmentedControl.selectedSegmentIndex != 0) {
        return nil;
    }
    UIContextualAction *delete = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        [[QPOpenAPIManager sharedInstance] deleteFolderWithId:self.folders[indexPath.row].identifier completion:^(NSError * _Nullable error) {
            if (!error) {
                [self.folders removeObjectAtIndex:indexPath.row];
                [tableView reloadData];
            }
            else {
                [SVProgressHUD showErrorWithStatus:error.userInfo[@"message"]];
            }
        }];
        completionHandler(YES);
    }];
    delete.backgroundColor = [UIColor  purpleColor]; //arbitrary color
    UISwipeActionsConfiguration *swipeActionConfig = [UISwipeActionsConfiguration configurationWithActions:@[delete]];
    swipeActionConfig.performsFirstActionWithFullSwipe = NO;
    return swipeActionConfig;
}
#endif

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.segmentedControl.selectedSegmentIndex == 0 || self.segmentedControl.selectedSegmentIndex == 1) {
        SongListViewController *vc = [[SongListViewController alloc] initWithFolder:self.folders[indexPath.row]];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)collectButtonPressed:(UIButton *)sender {
    QPFolder *folder = self.folders[sender.tag];
    if (folder.isCollected) {
        __weak __typeof(self) weakSelf = self;
        [[QPOpenAPIManager sharedInstance] uncollectFolderWithId:folder.identifier completion:^(NSError * _Nullable error) {
            if (!error) {
                if (self.segmentedControl.selectedSegmentIndex == 1){
                    [[QPOpenAPIManager sharedInstance] fetchCollectedFolderWithCompletion:^(NSArray<QPFolder *> * _Nullable folders, NSError * _Nullable error) {
                        if (!error) {
                            weakSelf.folders = [folders mutableCopy];
                            [weakSelf.tableView reloadData];
                        }
                    }];
                }
            }
            else {
                [SVProgressHUD showErrorWithStatus:error.userInfo[@"message"]];
            }
        }];
    }
}

#pragma Helpers
- (void)addSongToFolder:(NSString *)folderId {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"添加歌曲到歌单"
                               message:@"把五月天 后来的我们 和 知足 加进该歌单"
                               preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
        QPSongInfo *song1 = [[QPSongInfo alloc] initWithMid:@"0022QuVR1LcRHN"];
        QPSongInfo *song2 = [[QPSongInfo alloc] initWithMid:@"003SDOfs2wJvJh"];
        [[QPOpenAPIManager sharedInstance] addSongWithMid:@[song1,song2] to:folderId completion:^(NSError * _Nullable error) {
            if(error){
                [SVProgressHUD showErrorWithStatus:error.userInfo[@"message"]];
            }else {
                [SVProgressHUD showSuccessWithStatus:@"添加成功"];
            }
        }];
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)deleteSongToFolder:(NSString *)folderId {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"从歌单移除歌曲"
                               message:@"把五月天 后来的我们 和 知足 从歌单移除"
                               preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
        QPSongInfo *song1 = [[QPSongInfo alloc] initWithMid:@"0022QuVR1LcRHN"];
        QPSongInfo *song2 = [[QPSongInfo alloc] initWithMid:@"003SDOfs2wJvJh"];
        [[QPOpenAPIManager sharedInstance] deleteSongWithMid:@[song1,song2] from:folderId completion:^(NSError * _Nullable error) {
            if(error){
                [SVProgressHUD showErrorWithStatus:error.userInfo[@"message"]];
            }else {
                [SVProgressHUD showSuccessWithStatus:@"移除成功"];
            }
        }];
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)fetchData {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        __weak __typeof(self) weakSelf = self;
        [[QPOpenAPIManager sharedInstance] fetchPersonalFolderWithCompletion:^(NSArray<QPFolder *> * _Nullable folders, NSError * _Nullable error) {
            if (!error) {
                weakSelf.folders = [folders mutableCopy];
                [weakSelf.tableView reloadData];
            }
        }];
    }
    else if (self.segmentedControl.selectedSegmentIndex == 1){
        __weak __typeof(self) weakSelf = self;
        [[QPOpenAPIManager sharedInstance] fetchCollectedFolderWithCompletion:^(NSArray<QPFolder *> * _Nullable folders, NSError * _Nullable error) {
            if (!error) {
                weakSelf.folders = [folders mutableCopy];
                [weakSelf.tableView reloadData];
            }
        }];
    }
    else if (self.segmentedControl.selectedSegmentIndex == 2){
        __weak __typeof(self) weakSelf = self;
        [[QPOpenAPIManager sharedInstance] fetchRecentPlaySongWithUpdateTime:0 completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSTimeInterval updateTime, NSError * _Nullable error) {
            if (!error) {
                //再拉取一次歌曲详情
                [self fetchSongInfo:songs completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
                    if (!error) {
                        weakSelf.songs = [songs mutableCopy];
                        [weakSelf.tableView reloadData];
                    }
                }];
            }
        }];
    }
}

#pragma mark: - Helpers
//因为songInfo接口一次最多50
- (void)fetchSongInfo:(NSArray *)songs completion:(void (^)(NSArray<QPSongInfo *> *_Nullable items, NSError * _Nullable error))completion {
    NSInteger count = ceil((float)songs.count / 50.0);
    __block NSError *errorOccoured = nil;
    NSMutableArray<QPSongInfo *> *result = [NSMutableArray array];
    
    dispatch_group_t group = dispatch_group_create();
    for (NSInteger index=0; index < count; index++) {
        
        NSArray<QPSongInfo *> *currentSongs = nil;
        if (index == count - 1) {
            currentSongs = [songs subarrayWithRange:NSMakeRange(index*50, songs.count - index*50)];
        }else {
            currentSongs = [songs subarrayWithRange:NSMakeRange(index*50, 50)];
        }
        dispatch_group_enter(group);
        [[QPOpenAPIManager sharedInstance] fetchSongInfoBatchWithMid:currentSongs completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
            if (!error) {
                if (songs) {
                    [result addObjectsFromArray:songs];
                }
            }else {
                errorOccoured = error;
            }
            dispatch_group_leave(group);
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (errorOccoured) {
            completion(nil,errorOccoured);
        }else {
            completion(result,nil);
        }
    });
}

- (NSString *)stringCache:(QPlaybackCache)cache {
    if (cache == QPlaybackCache_100MB) {
        return @"100MB";
    }
    else if (cache == QPlaybackCache_500MB){
        return @"500MB";
    }
    else if (cache == QPlaybackCache_800MB){
        return @"800MB";
    }
    return @"1G";
}

@end
