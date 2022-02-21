//
//  AlbumTableCell.h
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/13.
//

#import <UIKit/UIKit.h>
#import <QMOpenApiSDK/QPAlbum.h>
NS_ASSUME_NONNULL_BEGIN

@interface AlbumTableCell : UITableViewCell
- (void) updateCellWithAlbum:(QPAlbum *)album;
@end

NS_ASSUME_NONNULL_END
