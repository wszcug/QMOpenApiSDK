//
//  QPlayerManager+Folder.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/22.
//

#import <QMOpenApiSDK/QMOpenApiSDK.h>
#import "QPFolder.h"
#import "QPCategory.h"
#import "QPSearchResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface QPOpenAPIManager (Folder)
/// 创建、删除歌单
/// @param name 歌单名称
- (void)createFolderWithName:(NSString *)name completion:(void (^)(NSString *_Nullable folderId, NSError * _Nullable error))completion;

/// 创建、删除歌单
/// @param folderId 歌单id
- (void)deleteFolderWithId:(NSString *)folderId completion:(void (^)(NSError * _Nullable error))completion;


/// 获取歌单中歌曲列表
/// @param folderId 歌单id
/// @param pageNumber 页码，取值从0开始
/// @param pageSize 每页的数量，最大50;默认10
- (void)fetchSongOfFolderWithId:(NSString *)folderId pageNumber:(NSNumber *_Nullable)pageNumber pageSize:(NSNumber *_Nullable)pageSize completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;


/// 获取歌单详情
/// @param folderId 歌单id
- (void)fetchFolderDetailWithId:(NSString *)folderId completion:(void (^)(QPFolder *_Nullable folder, NSError * _Nullable error))completion;

///获取个人歌单目录
- (void)fetchPersonalFolderWithCompletion:(void (^)(NSArray<QPFolder *> *_Nullable folders, NSError * _Nullable error))completion;


/// 收藏歌单广场的歌单
/// @param folderId 歌单Id
- (void)collectFolderWithId:(NSString *)folderId completion:(void (^)(NSError * _Nullable error))completion;


/// 取消收藏歌单广场的歌单
/// @param folderId 歌单id
- (void)uncollectFolderWithId:(NSString *)folderId completion:(void (^)(NSError * _Nullable error))completion;


/// 获取歌单广场的歌单
- (void)fetchCollectedFolderWithCompletion:(void (^)(NSArray<QPFolder *> *_Nullable folders, NSError * _Nullable error))completion;


/// 个人歌单中增加歌曲(通过mid)
/// @param songs 有mid的songInfo
/// @param folderId 歌单id
- (void)addSongWithMid:(NSArray<QPSongInfo *> *)songs to:(NSString *)folderId completion:(void (^)(NSError * _Nullable error))completion;


/// 个人歌单中增加歌曲(通过id)
/// @param songs 有id的songInfo
/// @param folderId 歌单id
- (void)addSongWithId:(NSArray<QPSongInfo *> *)songs to:(NSString *)folderId completion:(void (^)(NSError * _Nullable error))completion;


/// 个人歌单中删除歌曲(通过mid)
/// @param songs 有mid的songInfo
/// @param folderId 歌单id
- (void)deleteSongWithMid:(NSArray<QPSongInfo *> *)songs from:(NSString *)folderId completion:(void (^)(NSError * _Nullable error))completion;


/// 个人歌单中删除歌曲(通过id)
/// @param songs 有id的songInfo
/// @param folderId 歌单id
- (void)deleteSongWithId:(NSArray<QPSongInfo *> *)songs from:(NSString *)folderId completion:(void (^)(NSError * _Nullable error))completion;

///获取音乐馆下的分类歌单的分类
/// @note 首页-音乐馆-分类歌单
- (void)fetchCategoryOfFolderWithCompletion:(void (^)(NSArray<QPCategory *> *_Nullable categories, NSError * _Nullable error))completion;

/// 获取音乐馆分类歌单下的歌单详情
/// @param categoryId 分类Id
/// @param pageNumber 请求类下歌单列表开始页。默认0
/// @param pageSize 请求类下歌单列表页大小。默认20
- (void)fetchFolderListByCategoryWithId:(NSString *) categoryId pageNumber:(NSNumber *_Nullable)pageNumber pageSize:(NSNumber *_Nullable) pageSize completion:(void (^)(NSArray<QPFolder *> *_Nullable folders, NSError * _Nullable error))completion;
@end

NS_ASSUME_NONNULL_END
