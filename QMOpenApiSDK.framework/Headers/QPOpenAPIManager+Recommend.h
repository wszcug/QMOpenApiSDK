//
//  QPlayerManager+Recommend.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/16.
//

#import <QMOpenApiSDK/QMOpenApiSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPOpenAPIManager (Recommend)


///获取每日30首推荐
- (void)fetchDailyRecommandSongWithCompletion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;

///个性化推荐歌曲
- (void)fetchPersonalRecommandSongWithCompletion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;

///相似单曲推荐(mid)
/// @param songMid song mid
/// @note 根据输入的歌曲id，推荐相似的歌曲。注意，曲库中，存在无相似单曲情况。
- (void)fetchSimilarSongMid:(NSString *) songMid completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;
    
@end

NS_ASSUME_NONNULL_END
