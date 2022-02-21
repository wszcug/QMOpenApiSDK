//
//  QPSongList.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/6.
//

#import <Foundation/Foundation.h>
#import "QPFolderCreator.h"

NS_ASSUME_NONNULL_BEGIN

@interface QPFolder : NSObject
///歌单创建时间
@property (nonatomic) NSTimeInterval createTime;
///歌单修改时间
@property (nonatomic) NSTimeInterval updateTime;
///歌单创建者
@property (nonatomic) QPFolderCreator *creator;
///歌单id
@property (nonatomic) NSString *identifier;
///歌单名
@property (nonatomic,nullable) NSString *name;
///歌单显示名
@property (nonatomic,nullable) NSString *title;
///歌单封面
@property (nonatomic,nullable) NSURL *picURL;
///歌单歌曲数量
@property (nonatomic) NSInteger totalNum;
///歌单被收藏数量
@property (nonatomic) NSInteger favNum;
///歌单介绍
@property (nonatomic, nullable) NSString *introduction;
///歌单收听数量
@property (nonatomic) uint64_t listenNum;
/// 是否收藏，1：收藏，0：非收藏
@property (nonatomic) BOOL isCollected;
/// 是否自己创建的歌单
@property (nonatomic) BOOL isCreatedBySelf;

- (instancetype)initWithJSON:(NSDictionary *)json;
@end

NS_ASSUME_NONNULL_END
