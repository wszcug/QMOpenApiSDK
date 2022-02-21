//
//  QPVipInfo.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPVipInfo : NSObject
///绿钻标识，1:是 0:否
@property (nonatomic) BOOL isGreenVIP;
///绿钻开通的时间
@property (nonatomic) NSDate *greenvipStartTime;
///绿钻结束时间
@property (nonatomic) NSDate *greenvipEndTime;
///年费绿钻标识，1:是 0:否
@property (nonatomic) BOOL isGreenYearVIP;
///豪华绿钻 1:是 0:否
@property (nonatomic) BOOL isSuperGreenVIP;
///豪华绿钻开通的时间
@property (nonatomic) NSDate *superGreenvipStartTime;
///豪华绿钻过期时间
@property (nonatomic) NSDate *superGreenvipEndTime;
///8元付费包标志 1:是 0:否
@property (nonatomic) BOOL isEightPaid;
///8元付费包开通的时间
@property (nonatomic) NSDate *eightPaidStartTime;
///8元付费包过期时间
@property (nonatomic) NSDate *eightPaidEndTime;
///12元豪华付费包标志 1:是 0:否
@property (nonatomic) BOOL isTwelvePaid;
///12元付费包开通的时间
@property (nonatomic) NSDate *twelvePaidStartTime;
///12元付费包过期时间
@property (nonatomic) NSDate *twelvePaidEndTime;

- (instancetype)initWithJSON:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
