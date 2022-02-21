//
//  FolderListViewController.h
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/27.
//

#import <UIKit/UIKit.h>
#import <QMOpenApiSDK/QMOpenApiSDK.h>
NS_ASSUME_NONNULL_BEGIN

@interface FolderListViewController : UIViewController
-(instancetype)initWithCategory:(QPCategory *)category;
@end

NS_ASSUME_NONNULL_END
