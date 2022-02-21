//
//  FilterTableHeaderView.m
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/30.
//

#import "FilterTableHeaderView.h"
#import "Masonry.h"
@interface FilterTableHeaderView()
@property (nonatomic) NSDictionary<NSString *,NSArray<QPCategory *> *> *filters;
@property (nonatomic) NSMutableArray<UISegmentedControl *> *segmentedControls;
@property (nonatomic) NSMutableArray<NSArray<QPCategory *> *> *filterArray;
@end
@implementation FilterTableHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
      [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.filterArray = [NSMutableArray array];
    self.segmentedControls = [NSMutableArray array];
}

- (void)updateWithFilters:(NSDictionary<NSString *,NSArray<QPCategory *> *> *)filters {
    if (self.segmentedControls.count) {
        return;
    }
    self.filters = filters;
    if (!self.filters.count) {
        return;
    }
    NSInteger index = 0;
    for (NSString *key in filters.allKeys) {
        NSArray<QPCategory *> *filter = [filters objectForKey:key];
        [self.filterArray addObject:filter];
        
        NSMutableArray *items = [NSMutableArray array];
        for (QPCategory *cate in filter) {
            [items addObject:cate.name];
        }
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
        segmentedControl.tag = index;
        segmentedControl.selectedSegmentIndex = 0;
        [segmentedControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        [self.contentView addSubview:segmentedControl];
        [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
            if (index == 0) {
                make.leading.mas_equalTo(self.contentView.mas_leading).with.offset(8);
                make.trailing.mas_lessThanOrEqualTo(self.contentView.mas_trailing).with.offset(-8);
                make.top.mas_equalTo(self.contentView.mas_top).with.offset(20);
            }
            else if (index == self.filters.count-1){
                make.leading.mas_equalTo(self.contentView.mas_leading).with.offset(8);
                make.trailing.mas_lessThanOrEqualTo(self.contentView.mas_trailing).with.offset(-8);
                make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-20);
            }
            else {
                make.leading.mas_equalTo(self.contentView.mas_leading).with.offset(8);
                make.trailing.mas_lessThanOrEqualTo(self.contentView.mas_trailing).with.offset(-8);
                make.top.mas_equalTo(self.segmentedControls[index-1].mas_bottom).with.offset(20);
            }
        }];
        
        [self.segmentedControls addObject:segmentedControl];
        index += 1;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)segmentValueChanged:(UISegmentedControl *)control{
    NSMutableArray<QPCategory *> *result = [NSMutableArray array];
    for (UISegmentedControl *seg in self.segmentedControls) {
        [result addObject:self.filterArray[seg.tag][seg.selectedSegmentIndex]];
    }
    if (self.delegate) {
        [self.delegate selectedFilterDidChanged:result];
    }
}

@end
