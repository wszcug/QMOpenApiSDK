//
//  RankTableCell.h
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/22.
//

#import <UIKit/UIKit.h>
#import <QMOpenApiSDK/QPRank.h>
NS_ASSUME_NONNULL_BEGIN

@interface RankTableCell : UITableViewCell
- (void) updateCellWithRank:(QPRank *)rank;
@end

NS_ASSUME_NONNULL_END
