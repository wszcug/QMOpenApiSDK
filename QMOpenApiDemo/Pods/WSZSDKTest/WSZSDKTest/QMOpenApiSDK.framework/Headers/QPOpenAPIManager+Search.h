//
//  QPlayerManager+Search.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/14.
//

#import <QMOpenApiSDK/QMOpenApiSDK.h>
#import "QPFolder.h"
#import "QPSearchResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface QPOpenAPIManager (Search)
/// 歌曲、专辑、MV搜索
/// @param keyword 关键字
/// @param typeNumber 搜索类型 0：单曲搜索 3:歌单搜索 8：专辑搜索  15：电台 100:歌词 //(默认为0)
/// @param pageSize 每页数 最大50，默认20个 （注意：歌词是1-10,默认10）
/// @param pageNumber 搜索页码最大4页，默认1页 （注意：歌词是1-10，默认第一页）
/// @note 对于user_own_rule=0，即免费用户，且只浏览权限，只返回只读数据，并且下表中部分字段会被置0或置空。
- (void)searchWithKeyword:(NSString *)keyword typeNumber:(NSNumber * _Nullable)typeNumber pageSize:(NSNumber * _Nullable)pageSize pageNumber:(NSNumber * _Nullable)pageNumber completion:(void (^)(QPSearchResult *_Nullable result, NSError * _Nullable error))completion;


/// 搜索提示smartbox
/// @param keyword 搜索词
- (void)searchSmartWithKeyword:(NSString *)keyword completion:(void (^)(NSArray<NSString *> *_Nullable results, NSError * _Nullable error))completion;


@end

NS_ASSUME_NONNULL_END
