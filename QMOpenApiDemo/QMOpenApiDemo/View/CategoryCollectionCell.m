//
//  CategoryCollectionCell.m
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/27.
//

#import "CategoryCollectionCell.h"
#import "Masonry.h"
@interface CategoryCollectionCell()
@property (nonatomic) UILabel *titleLabel;
@end
@implementation CategoryCollectionCell

- (void)updateCellWithCategory:(QPCategory *)category {
    self.titleLabel.text = category.name;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = UIColor.blackColor;
    self.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

@end
