//
//  QPRadio.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPRadio : NSObject
///电台名
@property (nonatomic) NSString *name;
///电台id
@property (nonatomic) NSString *identifier;
///电台封面
@property (nonatomic,nullable) NSURL *picURL;
///电台收听次数
@property (nonatomic) uint64_t listenCount;
- (instancetype)initWithJSON:(NSDictionary *)json;
@end

NS_ASSUME_NONNULL_END
