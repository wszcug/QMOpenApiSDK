//
//  QPlayerManager+Singer.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/15.
//

#import <QMOpenApiSDK/QMOpenApiSDK.h>
#import "QPSinger.h"
NS_ASSUME_NONNULL_BEGIN

@interface QPOpenAPIManager (Singer)

/// 获取歌手歌曲信息(通过歌手id)
/// @param singerId 歌手id
/// @param pageNumber 分页索引，从0开始
/// @param pageSize 每页歌曲数目，最大为50，需大于0
/// @param order 歌曲排序方式，0：表示按时间(默认)，1：表示按热度
- (void)fetchSongOfSingerWithId:(NSString *) singerId pageNumber:(NSNumber *)pageNumber pageSize:(NSNumber *)pageSize order:(NSInteger)order completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;


/// 获取热门歌手列表
/// @param areaNumber 歌手所在地区索引
/// @param typeNumber 歌手性别索引
/// @param genreNumber 歌手所属流派索引
/// @note 按照分类索引（支持地区，性别，流派），拉取相应分类下的热门歌手id列表
/**
area的取值如下：
-100：全部
200 ：内地
2：港台
3：韩国
4：日本
5：欧美
6：其它
 
type的取值如下：
-100：全部
0：男
1：女
2：组合
 
genre的取值如下：
-100：全部
1：流行
2：摇滚
3：民谣
4：电子
5：爵士
6：嘻哈
8：R&B
9：轻音乐
10：民歌
14：古典
20：蓝调
25：乡村
*/
- (void)fetchHotSingerListWithArea:(NSNumber *_Nullable)areaNumber typeNumber:(NSNumber *_Nullable) typeNumber genreNumber:(NSNumber *_Nullable) genreNumber completion:(void (^)(NSArray<QPSinger *> *_Nullable singers, NSError * _Nullable error))completion;

/// 获取歌手专辑列表信息
/// @param singerId 通过歌手id。
/// @param pageNumber 分页索引，从0开始
/// @param pageSize 每页歌曲数目，最大为50，需大于0
/// @param order 歌曲排序方式，0：表示按时间(默认)，1：表示按热度
- (void)fetchAlbumOfSingerWithId:(NSString *) singerId pageNumber:(NSNumber *)pageNumber pageSize:(NSNumber *)pageSize order:(NSInteger)order completion:(void (^)(NSArray<QPAlbum *> *_Nullable albums,NSInteger total, NSError * _Nullable error))completion;


/// 搜索歌手列表(通过搜索关键字，搜索歌手列表，可分页拉取。)
/// @param keyword 搜索关键字
/// @param pageNumber 分页索引，从1开始，最大2页
/// @param pageSize 每页歌手数目，默认10，最大为20
- (void)searchSingerWithKeyword:(NSString *)keyword pageNumber:(NSNumber *_Nullable)pageNumber pageSize:(NSNumber *_Nullable)pageSize completion:(void (^)(NSArray<QPSinger *> *_Nullable singers, NSError * _Nullable error))completion;


@end

NS_ASSUME_NONNULL_END
