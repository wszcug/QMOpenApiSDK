//
//  QPLyricInfo.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/10/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPLyricInfo : NSObject
///歌曲专辑id
@property (nonatomic) NSString *albumIdentifier;
///歌曲专辑名
@property (nonatomic) NSString *albumName;
///歌曲id
@property (nonatomic) NSString *songIdentifier;
///歌曲mid
@property (nonatomic) NSString *songMid;
///歌曲名
@property (nonatomic) NSString *songName;
///歌词内容
@property (nonatomic) NSString *content;
- (instancetype)initWithJSON:(NSDictionary *)json;
@end

NS_ASSUME_NONNULL_END
