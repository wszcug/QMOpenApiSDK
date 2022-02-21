//
//  QPlayerManager+Rank.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/15.
//

#import <QMOpenApiSDK/QMOpenApiSDK.h>
#import "QPRank.h"
#import "QPCategory.h"
NS_ASSUME_NONNULL_BEGIN

@interface QPOpenAPIManager (Rank)


///获取音乐馆排行榜分类
- (void)fetchCategoryOfRankWithCompletion:(void (^)(NSArray<QPCategory *> *_Nullable categories, NSError * _Nullable error))completion;


/// 根据分类id获取音乐馆排行榜列表
/// @param categoryId 分类id
- (void)fetchRankListByCategoryWithId:(NSString *)categoryId completion:(void (^)(NSArray<QPRank *> *_Nullable ranks, NSError * _Nullable error))completion;



/// 获取音乐馆排行榜歌曲
/// @param rankId 排行榜id
/// @param pageNumber 第几页 取值从0开始
/// @param pageSize 每页大小  默认为20 最大值为50
/// @note 突破边界条件返回： 获取排行榜歌曲数为0
- (void)fetchSongOfRankWithId:(NSString *)rankId pageNumber:(NSNumber *_Nullable)pageNumber pageSize:(NSNumber *_Nullable)pageSize completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
