//
//  AppDelegate.m
//  QMOpenApiDemo
//
//  Created by wsz on 2021/8/30.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "SearchViewController.h"
#import "MineViewController.h"
#import "RadioViewController.h"
#import "RankViewController.h"
#import <QMOpenApiSDK/QMOpenApiSDK.h>
#import "SVProgressHUD.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[QPAccountManager sharedInstance] configureWithQMAppID:@"12345668" appKey:@"qoJvLUGMKmSExFJdXD" callBackUrl:@"qmopenapidemo://auth"];
    [[QPAccountManager sharedInstance] configureWithWXAppID:@"wx85d9b008252f26b5" universalLink:@"https://music.qq.com/tango/"];
    [[QPAccountManager sharedInstance] configureWithQQAppID:@"100446242" universalLink:@"www.qq.com"];

    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setBackgroundColor:UIColor.lightGrayColor];
    
    self.tabController = [[UITabBarController alloc] init];
    self.tabController.view.backgroundColor = UIColor.whiteColor;
    HomeViewController *home = [[HomeViewController alloc] init];
    home.title = @"首页";
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:home];
    homeNav.tabBarItem.image = [[UIImage imageNamed:@"home"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"home"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeNav.tabBarItem.imageInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    
    RankViewController *rank = [[RankViewController alloc] init];
    rank.title = @"排行";
    UINavigationController *rankNav = [[UINavigationController alloc] initWithRootViewController:rank];
    rankNav.tabBarItem.image = [[UIImage imageNamed:@"list"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    rankNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"list"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    rankNav.tabBarItem.imageInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    
    RadioViewController *radio = [[RadioViewController alloc] init];
    radio.title = @"电台";
    UINavigationController *radioNav = [[UINavigationController alloc] initWithRootViewController:radio];
    radioNav.tabBarItem.image = [[UIImage imageNamed:@"radio"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    radioNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"radio"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    radioNav.tabBarItem.imageInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    
    
    SearchViewController *search = [[SearchViewController alloc] init];
    search.title = @"搜索";
    UINavigationController *searchNav = [[UINavigationController alloc] initWithRootViewController:search];
    searchNav.tabBarItem.image = [[UIImage imageNamed:@"search"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    searchNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"search"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    searchNav.tabBarItem.imageInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    
    MineViewController *mine = [[MineViewController alloc] init];
    mine.title = @"我的";
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mine];
    mineNav.tabBarItem.image = [[UIImage imageNamed:@"mine"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"mine"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineNav.tabBarItem.imageInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    
    [self.tabController setViewControllers:@[homeNav,rankNav,radioNav,searchNav,mineNav]];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.tabController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [[QPAccountManager sharedInstance] handleURL:url];
}

@end
