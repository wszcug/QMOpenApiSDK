//
//  FilterTableHeaderView.h
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/30.
//

#import <UIKit/UIKit.h>
#import <QMOpenApiSDK/QPCategory.h>
NS_ASSUME_NONNULL_BEGIN
@protocol FilterTableHeaderViewDelegate <NSObject>
- (void)selectedFilterDidChanged:(NSArray<QPCategory *> *)filters;
@end
@interface FilterTableHeaderView : UITableViewHeaderFooterView
@property (nonatomic,weak,nullable) id<FilterTableHeaderViewDelegate> delegate;
- (void)updateWithFilters:(NSDictionary<NSString *,NSArray<QPCategory *> *> *) filters;
@end

NS_ASSUME_NONNULL_END
