//
//  QPlayerManager+Album.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/15.
//

#import <QMOpenApiSDK/QMOpenApiSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPOpenAPIManager (Album)

/// 获取专辑详情(通过mid)
/// @param albumMid 专辑mid
- (void)fetchAlbumDetailWithMid:(NSString  *)albumMid completion:(void (^)(QPAlbum *_Nullable album, NSError * _Nullable error))completion;

/// 获取专辑详情(通过id)
/// @param albumId 专辑id
- (void)fetchAlbumDetailWithId:(NSString  *)albumId completion:(void (^)(QPAlbum *_Nullable album, NSError * _Nullable error))completion;

/// 获取专辑歌曲(通过mid)
/// @param albumMid 专辑mid
/// @param pageNumber 请求第几页，取值从0开始
/// @param pageSize 每页的歌曲数
- (void)fetchSongOfAlbumWithMid:(NSString  *)albumMid pageNumber:(NSNumber *)pageNumber pageSize:(NSNumber *)pageSize completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;

/// 获取专辑歌曲(通过id)
/// @param albumId 专辑id
/// @param pageNumber 请求第几页，取值从0开始
/// @param pageSize 每页的歌曲数
- (void)fetchSongOfAlbumWithId:(NSString  *)albumId pageNumber:(NSNumber *)pageNumber pageSize:(NSNumber *)pageSize completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
