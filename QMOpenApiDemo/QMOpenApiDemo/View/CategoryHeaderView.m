//
//  CategoryHeaderView.m
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/27.
//

#import "CategoryHeaderView.h"
#import "Masonry.h"
@implementation CategoryHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel      = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
        self.titleLabel.textColor = UIColor.grayColor;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
        }];
        
    }
    return self;
}
@end
