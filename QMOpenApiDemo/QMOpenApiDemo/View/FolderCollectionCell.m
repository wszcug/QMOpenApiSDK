//
//  FolderCollectionCell.m
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/27.
//

#import "FolderCollectionCell.h"
#import "SDWebImage.h"
#import "Masonry.h"
@interface FolderCollectionCell()
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *nameLabel;
@end

@implementation FolderCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)updateCellWithFolder:(QPFolder *)folder {
    self.nameLabel.text = folder.name;
    [self.imageView sd_setImageWithURL:folder.picURL placeholderImage:[UIImage imageNamed:@"default_album"]];
}

- (void)commonInit{
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = UIColor.blackColor;
    self.nameLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.numberOfLines = 0;
                           
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_album"]];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.imageView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self.contentView);
        make.height.mas_equalTo(self.imageView.mas_width);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.contentView);
        make.top.mas_equalTo(self.imageView.mas_bottom).with.offset(0.5);
    }];
}
@end
