//
//  SongInfoTableCell.h
//  QQMusicID
//
//  Created by macrzhou(周荣) on 2020/8/18.
//  Copyright © 2020 TME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QMOpenApiSDK/QPSongInfo.h>

NS_ASSUME_NONNULL_BEGIN

@interface SongInfoTableCell : UITableViewCell
- (void) updateCellWithSongInfo:(QPSongInfo *)songInfo;
@end

NS_ASSUME_NONNULL_END
