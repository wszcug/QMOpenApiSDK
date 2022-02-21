//
//  CategoryCollectionCell.h
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/27.
//

#import <UIKit/UIKit.h>
#import <QMOpenApiSDK/QPCategory.h>
NS_ASSUME_NONNULL_BEGIN

@interface CategoryCollectionCell : UICollectionViewCell
- (void) updateCellWithCategory:(QPCategory *)category;
@end

NS_ASSUME_NONNULL_END
