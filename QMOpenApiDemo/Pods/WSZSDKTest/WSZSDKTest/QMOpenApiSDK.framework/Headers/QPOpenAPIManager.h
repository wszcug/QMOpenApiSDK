//
//  QPOpenAPIManager.h
//  QPOpenAPIManager
//
//  Created by wsz on 2021/9/7.
//

#import <Foundation/Foundation.h>
#import "QPSongInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface QPOpenAPIManager : NSObject

+ (instancetype)sharedInstance;

//- (BOOL)fileExistsByMid:(NSString *)songMid;
//- (void)downloadWithSongInfo:(QPSongInfo *)songInfo;

@end

NS_ASSUME_NONNULL_END

