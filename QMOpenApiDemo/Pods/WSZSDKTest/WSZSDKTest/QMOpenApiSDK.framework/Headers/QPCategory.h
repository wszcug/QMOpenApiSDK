//
//  QPCategory.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPCategory : NSObject
///分类id
@property (nonatomic) NSString *identifier;
///分类名
@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger type;
@property (nonatomic) NSString *typeName;
///子分类
@property (nonatomic, nullable) NSArray<QPCategory *> *subCategories;
- (instancetype)initWithJSON:(NSDictionary *)json;
@end

NS_ASSUME_NONNULL_END
