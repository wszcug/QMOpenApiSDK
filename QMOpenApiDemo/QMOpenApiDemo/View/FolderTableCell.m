//
//  FolderTableCell.m
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/13.
//

#import "FolderTableCell.h"
#import "Masonry.h"
#import "SDWebImage.h"

@interface FolderTableCell()
@property (strong, nonatomic) UIImageView   *albumCoverImageView;
@property (strong, nonatomic) UILabel       *songLabel;
@property (strong, nonatomic) UILabel       *singerLabel;
@end

@implementation FolderTableCell

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
        _songLabel.font          = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    }
    
    return _songLabel;
}

- (UILabel *) singerLabel {
    
    if (!_singerLabel) {
        _singerLabel = [[UILabel alloc] init];
        _singerLabel.text = @"五月天";
        _singerLabel.textAlignment = NSTextAlignmentLeft;
        _singerLabel.textColor     = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _singerLabel.font          = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    }
    
    return _singerLabel;
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
    self.collectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.collectedButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    self.collectedButton.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
    
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.albumCoverImageView];
    [self.contentView addSubview:self.songLabel];
    [self.contentView addSubview:self.singerLabel];
    [self.contentView addSubview:self.collectedButton];
  
}

- (void)setupConstraints {
    [self.albumCoverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(20);
        make.width.height.mas_equalTo(50);
        make.centerY.equalTo(self.contentView);
    }];
    [self.songLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.albumCoverImageView.mas_right).with.offset(17);
        make.right.lessThanOrEqualTo(self.collectedButton.mas_left).with.offset(-4);
        make.centerY.mas_equalTo(self.albumCoverImageView.mas_centerY).with.multipliedBy(0.75);
    }];
    [self.collectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView.mas_trailing).with.offset(-8);
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(60);
    }];
    [self.singerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.songLabel.mas_bottom).with.offset(4);
        make.left.equalTo(self.songLabel);
        make.trailing.mas_equalTo(self.songLabel.mas_trailing);
    }];
}

- (void) updateCellWithFolder:(QPFolder *)folder {
    self.songLabel.text = folder.name;
    self.singerLabel.text = folder.creator.name;
    [self.albumCoverImageView sd_setImageWithURL:folder.picURL placeholderImage:[UIImage imageNamed:@"default_album"]];
    [self.collectedButton setTitle:folder.isCollected ? @"取消收藏" : @"收藏" forState:UIControlStateNormal];
}

@end
