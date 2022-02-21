//
//  SingerTableCell.h
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/30.
//

#import <UIKit/UIKit.h>
#import <QMOpenApiSDK/QPSinger.h>
NS_ASSUME_NONNULL_BEGIN

@interface SingerTableCell : UITableViewCell
- (void) updateCellWithSinger:(QPSinger *)singer;
@end

NS_ASSUME_NONNULL_END
