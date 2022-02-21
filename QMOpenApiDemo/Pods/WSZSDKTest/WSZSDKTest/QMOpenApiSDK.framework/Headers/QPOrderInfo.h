//
//  QPOrderInfo.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/10/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPOrderInfo : NSObject

/// 订单创建时间
@property (nonatomic) NSTimeInterval createTime;
/// 订单号
@property (nonatomic) NSString *orderId;
///开通服务的月数
@property (nonatomic) NSInteger numberOfMonth;
///消耗账号金
@property (nonatomic) NSInteger money;
///订单状态（1:已发货，2:未发货）
@property (nonatomic) NSInteger status;
- (instancetype)initWithJSON:(NSDictionary *)json;
@end

NS_ASSUME_NONNULL_END
