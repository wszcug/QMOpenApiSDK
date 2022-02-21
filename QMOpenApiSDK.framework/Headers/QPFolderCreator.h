//
//  QPFolderCreator.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPFolderCreator : NSObject
///歌单创建者名字
@property (nonatomic) NSString *name;
///歌单创建者身份(2达人 6机构)
@property (nonatomic) NSInteger isVip;
///歌单创建者账号
@property (nonatomic) NSString *identifier;
///歌单创建者头像
@property (nonatomic,nullable) NSURL *avatar;

- (instancetype)initWithJSON:(NSDictionary *)json;
@end

NS_ASSUME_NONNULL_END
