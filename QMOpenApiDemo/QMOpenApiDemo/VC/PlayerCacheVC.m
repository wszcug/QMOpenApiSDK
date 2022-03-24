//
//  PlayerCacheVC.m
//  QMOpenApiDemo
//
//  Created by wsz on 2022/3/23.
//

#import "PlayerCacheVC.h"
#import "Masonry.h"
#import <QMOpenApiSDK/QMOpenApiSDK.h>
#import "PlayerViewManager.h"
@interface PlayerCacheVC ()
@property (nonatomic, strong)QPSongInfo *song;
@property (nonatomic, strong)UILabel *cacheSize;
@property (nonatomic, strong)UILabel *progress;

@end

@implementation PlayerCacheVC

- (id)initWithSong:(QPSongInfo *)song {
    self = [super init];
    if (self) {
        self.song = song;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *name  = [[UILabel alloc] init];
    name.text = [NSString stringWithFormat:@"歌曲名：   %@",self.song.name];
    [self.view addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(100);
        make.left.mas_equalTo(self.view).offset(20);
        make.width.mas_equalTo(@300);
        make.height.mas_equalTo(@20);
    }];
    
    UILabel *mid  = [[UILabel alloc] init];
    mid.text = [NSString stringWithFormat:@"歌曲ID：   %@",self.song.mid];
    [self.view addSubview:mid];
    [mid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(name.mas_bottom).offset(30);
        make.left.mas_equalTo(self.view).offset(20);
        make.width.mas_equalTo(@300);
        make.height.mas_equalTo(@20);
    }];
    
    UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkBtn.backgroundColor = [UIColor blueColor];
    checkBtn.layer.cornerRadius = 3.f;
    [checkBtn setTitle:@"检查缓存" forState:UIControlStateNormal];
    [checkBtn addTarget:self action:@selector(checkBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkBtn];
    [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.left.mas_equalTo(self.view).offset(20);
        make.top.mas_equalTo(mid.mas_bottom).offset(30);
    }];
    
    self.cacheSize = [[UILabel alloc] init];
    [self.view addSubview:self.cacheSize];
    [self.cacheSize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(checkBtn.mas_right).offset(80);
        make.width.mas_equalTo(@100);
        make.centerY.mas_equalTo(checkBtn);
    }];
    
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.backgroundColor = [UIColor blueColor];
    startBtn.layer.cornerRadius = 3.f;
    [startBtn setTitle:@"开始缓存" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.left.mas_equalTo(checkBtn);
        make.top.mas_equalTo(checkBtn.mas_bottom).offset(30);
    }];
    self.progress = [[UILabel alloc] init];
    [self.view addSubview:self.progress];
    [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(startBtn.mas_right).offset(80);
        make.width.mas_equalTo(@100);
        make.centerY.mas_equalTo(startBtn);
    }];
    
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playBtn.backgroundColor = [UIColor blueColor];
    playBtn.layer.cornerRadius = 3.f;
    [playBtn setTitle:@"播放缓存" forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(playBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.left.mas_equalTo(checkBtn);
        make.top.mas_equalTo(checkBtn.mas_bottom).offset(110);
    }];
    
    [self checkBtnClicked];
}

- (void)checkBtnClicked {
    [[QPlayerManager sharedInstance] isSongCached:self.song handler:^(int status, BOOL cached, NSString * _Nonnull errMsg) {
        if (status != 0) {
            //查询失败
        } else {
            if (cached) {
                self.cacheSize.text = @"已缓存";
            } else {
                self.cacheSize.text = @"未缓存";
            }
        }
    }];
}

- (void)startBtnClicked {
    [[QPlayerManager sharedInstance] preDownloadSong:self.song handler:^(int status, float progress, NSString * _Nonnull errMsg) {
        if (status == 2) {
            //缓存出错
        } else {
            self.progress.text = [NSString stringWithFormat:@"%0.f%%",progress * 100.f];
            if (status == 1) {
                [self checkBtnClicked];
            }
        }
    }];
}

- (void)playBtnClicked {
    [[PlayerViewManager sharedInstance] showWithSongList:@[self.song] index:0 autoPlay:YES];
}

@end
