//
//  TestTableCell.m
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/11/4.
//

#import "TestTableCell.h"
#import "Masonry.h"
@implementation TestTableCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = [UIColor blackColor];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        
        self.stateImageView = [[UIImageView alloc] init];
        [self.stateImageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.stateImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.stateImageView];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.contentView.mas_leading).with.offset(8);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.trailing.mas_equalTo(self.stateImageView.mas_leading).with.offset(-4);
        }];
        [self.stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self.contentView.mas_trailing).with.offset(-8);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(26, 26));
        }];
        
    }
    
    return self;
}

@end
