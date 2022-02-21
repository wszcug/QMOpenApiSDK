//
//  QPSearchResult.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/14.
//

#import <Foundation/Foundation.h>
#import "QPSongInfo.h"
#import "QPFolder.h"
#import "QPLyricInfo.h"
#import "QPAlbum.h"

NS_ASSUME_NONNULL_BEGIN
@class QPSearchZhiDa;
@interface QPSearchResult : NSObject
///当前返回个数
@property (nonatomic) NSInteger currentNumber;
///当前页码
@property (nonatomic) NSInteger currentPage;
///该搜索词可以搜到的总结果数
@property (nonatomic) NSInteger totoalNumber;
///搜索词
@property (nonatomic) NSString *keyword;
///专辑结果
@property (nonatomic, nullable) NSArray<QPAlbum *>  *albums;
///歌曲结果
@property (nonatomic, nullable) NSArray<QPSongInfo *>  *songs;
///歌单结果
@property (nonatomic, nullable) NSArray<QPFolder *>  *folders;
///歌词结果
@property (nonatomic, nullable) NSArray<QPLyricInfo *>  *lyrics;

@property (nonatomic, strong) QPSearchZhiDa *zhida;

- (instancetype)initWithJSON:(NSDictionary *)json type:(NSInteger)type;
@end

@interface QPSearchZhiDa : NSObject
@property (nonatomic) NSInteger reusableID;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *sub_title;
@property (nonatomic, assign) NSInteger type;

- (id)initWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
