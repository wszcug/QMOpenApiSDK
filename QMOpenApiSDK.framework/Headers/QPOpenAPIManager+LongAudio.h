//
//  QPlayerManager+LongAudio.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/17.
//

#import <QMOpenApiSDK/QMOpenApiSDK.h>
#import "QPCategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface QPOpenAPIManager (LongAudio)


///获取长音频推荐模块列表的分类
- (void)fetchCategoryOfRecommandLongAuidoWithCompletion:(void (^)(NSArray<QPCategory *> *_Nullable categories, NSError * _Nullable error))completion;

///通过分类id获取长音频推荐模块的专辑列表
- (void)fetchAlbumListOfRecommandLongAuidoByCategoryWithId:(NSString *)categoryId completion:(void (^)(NSArray<QPAlbum *> *_Nullable albums, NSError * _Nullable error))completion;

/// 猜你喜欢获取电台模块下的猜你喜欢模块(需要登录态)
- (void)fetchGuessLikeLongAudioWithCompletion:(void (^)(NSArray<QPAlbum *> *_Nullable albums, NSError * _Nullable error))completion;

///获取电台模块排行榜分类
- (void)fetchCategoryOfRankLongAudioWithCompletion:(void (^)(NSArray<QPCategory *> *_Nullable categories, NSError * _Nullable error))completion;

/// 获取电台模块下排行榜榜单专辑列表
/// @param categoryId 榜单分类Id
/// @param subCategoryId 榜单子分类Id
- (void)fetchAlbumListOfRankLongAudioByCategoryWithId:(NSString *)categoryId subCategoryId:(NSString *_Nullable)subCategoryId completion:(void (^)(NSArray<QPAlbum *> *_Nullable albums, NSError * _Nullable error))completion;

///获取长音频分类信息
- (void)fetchCategoryOfLongAudioWithCompletion:(void (^)(NSArray<QPCategory *> *_Nullable categories, NSError * _Nullable error))completion;


/// 获取长音频过滤分类
/// @param categoryId 分类id
/// @param subCateoryId 子分类id
- (void)fetchCategoryFilterOfLongAudioWithId:(NSString *)categoryId subCateoryId:(NSString *)subCateoryId completion:(void (^)(NSDictionary<NSString*,NSArray<QPCategory *>*> *_Nullable categories, NSError * _Nullable error))completion;


/// 获取分类专辑列表
/// @param catetoryId 长音频一级分类id
/// @param subCategoryId 长音频二级分类id
/// @param sortType 列表排序参数0最新，1：最热(默认)
/// @param pageSize 页面大小(默认10个，最大60)
/// @param pageNumber 第几页
/// @param filterCategories 过滤分类
- (void)fetchAlbumListOfLongAuidoByCategoryWithId:(NSString *)catetoryId subCategoryId:(NSString *)subCategoryId sortType:(NSInteger)sortType pageSize:(NSNumber * _Nullable)pageSize pageNumber:(NSNumber * _Nullable)pageNumber filterCategories:(NSArray<QPCategory *>*_Nullable)filterCategories completion:(void (^)(NSArray<QPAlbum *> *_Nullable albums,NSInteger total, NSError * _Nullable error))completion;


/// 获取个人资产电台模块中【听更新】数据(需要登录)
- (void)fetchRecentUpdateLongAudioWithCompletion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;

///获取个人资产电台模块中【喜欢】数据(需要登录c)
- (void)fetchLikeListLongAudioWithCompletion:(void (^)(NSArray<QPAlbum *> *_Nullable albums, NSError * _Nullable error))completion;

///获取个人资产电台模块中【最近】数据(需要登录)
- (void)fetchRecentPlayLongAudioWithCompletion:(void (^)(NSArray<QPAlbum *> *_Nullable albums,NSTimeInterval updateTime, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
