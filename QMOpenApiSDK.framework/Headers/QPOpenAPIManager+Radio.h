//
//  QPlayerManager+Radio.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/14.
//

#import <QMOpenApiSDK/QMOpenApiSDK.h>
#import "QPCategory.h"
#import "QPRadio.h"

NS_ASSUME_NONNULL_BEGIN

@interface QPOpenAPIManager (Radio)


///获取公共电台分类(针对免费用户，返回免费用户可听的电台列表。)
- (void)fetchCateoryOfPublicRadioWithCompletion:(void (^)(NSArray<QPCategory *> *_Nullable categories, NSError * _Nullable error))completion;


/// 通过公共电台分类id获取电台列表
/// @param categoryId 公共电台分类id
- (void)fetchPublicRadioListByCatetoryId:(NSString *)categoryId completion:(void (^)(NSArray<QPRadio *> *_Nullable radios, NSError * _Nullable error))completion;

/// 获取公共电台歌曲
/// @param radioId 公共电台id
/// @param pageSize 限制最大个数 范围0-20
- (void)fetchSongOfPublicRadioWithId:(NSString *) radioId pageSize:(NSNumber *_Nullable) pageSize completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;


/// 获取随便听听电台列表
- (void)fetchRadioOfJustListenWithCompletion:(void (^)(NSArray<QPRadio *> *_Nullable radios, NSError * _Nullable error))completion;


/// 获取随便听听电台歌曲
/// @param radioId 随便听听电台id
- (void)fetchSongOfJustListenRaidoWithId:(NSString *) radioId completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
