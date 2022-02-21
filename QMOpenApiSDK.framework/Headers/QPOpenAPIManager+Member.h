//
//  QPlayerManager+Member.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/16.
//

#import <QMOpenApiSDK/QMOpenApiSDK.h>
#import "QPVipInfo.h"
#import "QPOrderInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface QPOpenAPIManager (Member)

///查询QQ音乐绿钻会员
- (void)fetchGreenMemberInformationWithCompletion:(void (^)(QPVipInfo *_Nullable vipInfo, NSError * _Nullable error))completion;

/*
特别声明
一笔订单（前台流水号相同），无论是否收到返回结果，或是收到结果无论成功与否，可以重复提交（音乐接口做了根据订单的防重处理）。
音乐也提供接口查看订单状态，确认是否已经支付成功，具体请参考“订单查询协议”。如果查看订单状态，订单没有成功，可以使用原订单号进行重试；
商家需要保证每天的前台流水号tran_seq同一天之内的不能重复，即tran_date+tran_seq是一个唯一的订单编号；
商家需要自己保存一份发货明细帐，以便出错时进行对帐。
*/
///
/// 绿钻订单
/// @param mchId 腾讯音乐会分配一个唯一id
/// @param numberOfMonth 开通服务的时长（按月计算）
- (void)createGreenOrderWithMchId:(NSString *)mchId numberOfMonth:(NSInteger)numberOfMonth completion:(void (^)(NSString *_Nullable orderId, NSError * _Nullable error))completion;


/// 查询绿钻订单状态
/// @param mchId 腾讯音乐会分配一个唯一id
/// @param orderId 订单id
- (void)queryGreenOrderWithMchId:(NSString *)mchId orderId:(NSString *)orderId completion:(void (^)(QPOrderInfo *_Nullable orderInfo, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
