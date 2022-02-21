//
//  UIViewController+Extension.h
//  QQMusicID
//
//  Created by macrzhou(周荣) on 2020/3/11.
//  Copyright © 2020 TME. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Extension)
+ (UIViewController *)topViewController;
+ (UIViewController *)recursiveTopViewController:(UIViewController *)vc;
@end

NS_ASSUME_NONNULL_END
