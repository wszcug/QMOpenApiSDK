//
//  QPAlbum.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/15.
//

#import <Foundation/Foundation.h>
#import "QPSinger.h"

NS_ASSUME_NONNULL_BEGIN

@class QPSongInfo;

@interface QPAlbum : NSObject
///专辑id
@property (nonatomic) NSString *identifier;
///专辑mid
@property (nonatomic) NSString *mid;
///公司id
@property (nonatomic) NSString *companyId;
///公司名称
@property (nonatomic) NSString *companyName;
///专辑名
@property (nonatomic) NSString *name;
///专辑副名
@property (nonatomic) NSString *subName;
///翻译专辑名
@property (nonatomic) NSString *transName;
@property (nonatomic,nullable) NSURL *pic120xURL;
@property (nonatomic,nullable) NSURL *pic150xURL;
@property (nonatomic,nullable) NSURL *pic300xURL;
@property (nonatomic,nullable) NSURL *pic500xURL;
///是否收费(是一个图片地址) 长音频返回
@property (nonatomic,nullable) NSString *vipPic;
///专辑描述
@property (nonatomic) NSString *desc;
///专辑歌手
@property (nonatomic,nullable) NSArray<QPSinger *> *singers;
///发行时间
@property (nonatomic) NSDate *releaseDate;
///专辑歌曲总数
@property (nonatomic) NSInteger total;
///专辑下歌曲id列表
@property (nonatomic,nullable) NSString *songIdList;
///长音频 最近播放时间(秒级时间戳)
@property (nonatomic) NSTimeInterval lastPlayTime;
@property (nonatomic,readonly,nullable) NSURL *smallCoverURL;
@property (nonatomic,readonly,nullable) NSURL *bigCoverURL;

- (instancetype)initWithMid:(NSString *)mid;
- (instancetype)initWithJSON:(NSDictionary *)json;
@end

NS_ASSUME_NONNULL_END
