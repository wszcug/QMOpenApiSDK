//
//  QProgressV.h
//  QPlayClassic
//
//  Created by mageewang on 2021/8/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QProgressV : UIView

@property (nonatomic, copy) void(^didChange)(CGFloat rate);
@property (nonatomic, copy) void(^didBlock)(BOOL block);

- (void)setProgressWithDuration:(CGFloat)duration progress:(CGFloat)progress;
@end

NS_ASSUME_NONNULL_END
