//
//  QPRankInfo.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/15.
//

#import <Foundation/Foundation.h>
#import "QPSongInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface QPRank : NSObject
///排行榜榜单id
@property (nonatomic) NSString *identifier;
///排行榜榜单名
@property (nonatomic) NSString *name;
///类别
@property (nonatomic) NSInteger type;
///听的次数
@property (nonatomic) uint64_t listenCount;
///时间
@property (nonatomic,nullable) NSDate *date;
///排行榜头图url
@property (nonatomic) NSURL *headerURL;
///排行榜横幅图url
@property (nonatomic) NSURL *bannerURL;
///榜单下歌曲数量
@property (nonatomic) NSInteger total;
///榜单描述
@property (nonatomic,nullable) NSString *desc;

- (instancetype)initWithJSON:(NSDictionary *)json;
@end

NS_ASSUME_NONNULL_END
