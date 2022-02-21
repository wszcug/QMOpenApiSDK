//
//  QPlayerManager+Song.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/22.
//

#import <QMOpenApiSDK/QMOpenApiSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPOpenAPIManager (Song)
/// 批量获取歌曲信息(通过Mid)
/// @param songs 有mid的songInfo,上限50
- (void)fetchSongInfoBatchWithMid:(NSArray<QPSongInfo *> *)songs completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;

/// 批量获取歌曲信息(通过id)
/// @param songs 有id的songInfo,上限50
- (void)fetchSongInfoBatchWithId:(NSArray<QPSongInfo *> *)songs completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;


/// 获取新歌推荐
/// @param tag 12：内地；9：韩国；13：港台；3：欧美；8：日本
- (void)fetchNewSongRecommendWithTag:(NSInteger)tag completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;


/// 获取歌曲的歌词(mid)
/// @param songMid  songInfo的Mid
- (void)fetchLyricWithSongMid:(NSString *)songMid completion:(void (^)(NSString *_Nullable lyric, NSError * _Nullable error))completion;

/// 获取歌曲的歌词(id)
/// @param songId  songInfo的id
- (void)fetchLyricWithSongId:(NSString *)songId completion:(void (^)(NSString *_Nullable lyric, NSError * _Nullable error))completion;
@end

NS_ASSUME_NONNULL_END
