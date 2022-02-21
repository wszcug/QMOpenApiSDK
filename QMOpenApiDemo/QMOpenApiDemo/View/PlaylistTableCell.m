//
//  PlaylistTableCell.m
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/26.
//

#import "PlaylistTableCell.h"
#import "Masonry.h"

@interface PlaylistTableCell()
@property (strong, nonatomic) UILabel       *songLabel;
@end
@implementation PlaylistTableCell
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

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setupUI];
        [self setupConstraints];
    }
    
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.songLabel];
}

- (void)setupConstraints {
    
    [self.songLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-20);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(20);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
}

- (void) updateCellWithSongInfo:(QPSongInfo *)songInfo isHighted:(BOOL)isHighted{
    self.songLabel.textColor = isHighted ? UIColor.blueColor : UIColor.blackColor;
    self.songLabel.text = [NSString stringWithFormat:@"%@-%@",songInfo.name,songInfo.singer.name];
}

@end
