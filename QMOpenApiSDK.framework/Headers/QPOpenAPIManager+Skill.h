//
//  QPlayerManager+Skill.h
//  QMOpenApiSDK
//
//  Created by maczhou on 2021/9/27.
//

#import <QMOpenApiSDK/QMOpenApiSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPOpenAPIManager (Skill)

- (void)musicSkillWithIntent:(NSString *)intent slots:(NSDictionary<NSString*,NSString *> *)slots question:(NSString *)question currentSongId:(NSString *_Nullable)currentSongId itemCount:(NSInteger)itemCount completion:(void (^)(NSDictionary *_Nullable data, NSError * _Nullable error))completion;
@end

NS_ASSUME_NONNULL_END
