//
//  MIBatchTableCell.m
//  QQMusicID
//
//  Created by macrzhou(周荣) on 2020/8/18.
//  Copyright © 2020 TME. All rights reserved.
//

#import "SongInfoTableCell.h"
#import "Masonry.h"
#import "SDWebImage.h"
#import <QMOpenApiSDK/QMOpenApiSDK.h>

@interface SongInfoTableCell()

@property (strong, nonatomic) UIImageView   *albumCoverImageView;
@property (strong, nonatomic) UILabel       *songLabel;
@property (strong, nonatomic) UILabel       *singerLabel;
@property (strong, nonatomic) UIButton      *downloadBtn;
@property (strong, nonatomic) UILabel       *progress;
@end

@implementation SongInfoTableCell

- (UIImageView *) albumCoverImageView {
    
    if (!_albumCoverImageView) {
        _albumCoverImageView = [[UIImageView alloc] init];
        _albumCoverImageView.image = [UIImage imageNamed:@"default_album"];
    }
    
    return _albumCoverImageView;
}

- (UILabel *) songLabel {
    
    if (!_songLabel) {
        _songLabel = [[UILabel alloc] init];
        _songLabel.text = @"你不是真正的快乐";
        _songLabel.textAlignment = NSTextAlignmentLeft;
        _songLabel.textColor     = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        _songLabel.font          = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    }
    
    return _songLabel;
}

- (UILabel *) singerLabel {
    
    if (!_singerLabel) {
        _singerLabel = [[UILabel alloc] init];
        _singerLabel.text = @"五月天";
        _singerLabel.textAlignment = NSTextAlignmentLeft;
        _singerLabel.textColor     = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _singerLabel.font          = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    }
    
    return _singerLabel;
}

- (UIButton *) downloadBtn {
    if (!_downloadBtn) {
        _downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];

        [_downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
        _downloadBtn.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        _downloadBtn.backgroundColor = UIColor.lightGrayColor;
        [_downloadBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        _downloadBtn.layer.cornerRadius = 3;
        [_downloadBtn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadBtn;
}

- (UILabel *) progress {
    
    if (!_progress) {
        _progress = [[UILabel alloc] init];
        _progress.text = @"";
        _progress.textAlignment = NSTextAlignmentLeft;
        _progress.textColor     = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        _progress.font          = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    }
    return _progress;
}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setupUI];
        [self setupConstraints];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _albumCoverImageView.layer.cornerRadius  = 5.5;
    _albumCoverImageView.layer.masksToBounds = YES;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.albumCoverImageView];
    [self.contentView addSubview:self.songLabel];
    [self.contentView addSubview:self.singerLabel];
    [self.contentView addSubview:self.downloadBtn];
    [self.contentView addSubview:self.progress];
}

- (void)setupConstraints {
    
    [self.albumCoverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(20);
        make.width.height.mas_equalTo(50);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.songLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.albumCoverImageView.mas_right).with.offset(17);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-17);
        make.centerY.mas_equalTo(self.albumCoverImageView.mas_centerY).with.multipliedBy(0.75);
    }];
    
    [self.singerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.songLabel.mas_bottom).with.offset(4);
        make.left.right.equalTo(self.songLabel);
    }];
    [self.downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 25));
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView).offset(-20);
    }];
    [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.downloadBtn.mas_left).offset(-20);
        make.height.mas_equalTo(@16);
    }];
}

- (void) updateCellWithSongInfo:(QPSongInfo *)songInfo {
    self.songLabel.text = songInfo.name;
    self.singerLabel.text = songInfo.singer.name;
    [self.albumCoverImageView sd_setImageWithURL:songInfo.smallCoverURL placeholderImage:[UIImage imageNamed:@"default_album"]];
    if ([[QPlayerManager sharedInstance].currentSong.mid isEqualToString:songInfo.mid]) {
        self.songLabel.textColor = UIColor.blueColor;
        self.singerLabel.textColor = [UIColor.blueColor colorWithAlphaComponent:0.5];
    }
    else {
        if (songInfo.canPlay || songInfo.canTryPlay) {
            self.songLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
            self.singerLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        }else {
            self.songLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
            self.singerLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        }
    }
}

- (void) updateProgress:(float)progress {
    if (progress > 1) {
        progress = 1;
    }
    if (progress < 0) {
        progress = 0;
    }
    progress = progress * 100.f;
    self.progress.text = [NSString stringWithFormat:@"%0.f%%",progress];
}

- (void)btnClicked {
    if (self.downloadBtnClicked) {
        self.downloadBtnClicked();
    }
}

@end
