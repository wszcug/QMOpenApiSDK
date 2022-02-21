//
//  PlayerViewManager.m
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/10/14.
//

#import "PlayerViewManager.h"
#import "PlayerViewController.h"
#import "UIViewController+Extension.h"
#import "AppDelegate.h"

@interface PlayerViewManager()
@property (nonatomic,readonly) BOOL isShowing;
@property (nonatomic) PlayerViewController *playVC;
@property (nonatomic) NSArray<QPSongInfo *> *songList;
@property (nonatomic,readonly) AppDelegate *appDelegate;
@end

@implementation PlayerViewManager
+ (instancetype)sharedInstance {
    static PlayerViewManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PlayerViewManager alloc] init];
    });
    return instance;
}

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)isShowing {
    return [[UIViewController topViewController] isKindOfClass:[PlayerViewController class]];
}

- (void)show {
    if (!self.isShowing) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.playVC];
        nav.modalPresentationCapturesStatusBarAppearance = YES;
        nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self.appDelegate.tabController presentViewController:nav animated:YES completion:nil];
    }
}

- (void)showWithSongList:(NSArray<QPSongInfo *> *)songList index:(NSInteger)index autoPlay:(BOOL)autoPlay {
    if (self.playVC) {
        [self show];
        [self.playVC reloadWithData:songList index:index autoPlay:autoPlay];
    } else {
        self.playVC = [[PlayerViewController alloc] initWithSongList:songList index:index autoPlay:autoPlay];
        self.playVC.modalPresentationCapturesStatusBarAppearance = YES;
        self.playVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.playVC];
        nav.modalPresentationCapturesStatusBarAppearance = YES;
        nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self.appDelegate.tabController presentViewController:nav animated:YES completion:nil];
    }
}

@end
