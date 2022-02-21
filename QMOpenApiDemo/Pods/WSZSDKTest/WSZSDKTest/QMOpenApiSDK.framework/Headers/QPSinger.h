//
//  QPSinger.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class QPSongInfo;
@class QPAlbum;
@interface QPSinger : NSObject
///歌手id
@property (nonatomic) NSString *identifier;
///歌手mid
@property (nonatomic) NSString *mid;
///歌手名
@property (nonatomic) NSString *name;
///歌手翻译名
@property (nonatomic,nullable) NSString *transName;
///歌手地区
@property (nonatomic) NSString *area;
@property (nonatomic,nullable) NSString *title;
@property (nonatomic,nullable) NSURL *pic120xURL;
@property (nonatomic,nullable) NSURL *pic150xURL;
@property (nonatomic,nullable) NSURL *pic300xURL;
@property (nonatomic,nullable) NSURL *pic500xURL;
///歌曲总数
@property (nonatomic) NSInteger totalSongs;
///mv总数
@property (nonatomic) NSInteger totalMVs;
///专辑总数
@property (nonatomic) NSInteger totalAlbums;
@property (nonatomic,readonly,nullable) NSURL *smallCoverURL;
@property (nonatomic,readonly,nullable) NSURL *bigCoverURL;
- (instancetype)initWithJSON:(NSDictionary *)json;
- (instancetype)initWithId:(NSString *)identifier;
@end

NS_ASSUME_NONNULL_END
