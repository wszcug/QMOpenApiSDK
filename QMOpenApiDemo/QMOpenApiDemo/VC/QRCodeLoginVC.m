//
//  QRCodeLoginVC.m
//  QMOpenApiDemo
//
//  Created by wsz on 2022/1/6.
//

#import "QRCodeLoginVC.h"
#import "Masonry.h"
#import "SVProgressHUD.h"
#import <QMOpenApiSDK/QMOpenApiSDK.h>

@interface QRCodeLoginVC ()

@end

@implementation QRCodeLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 250));
        make.center.mas_equalTo(self.view);
    }];
    
    [SVProgressHUD showWithStatus:@"正在获取二维码"];
    [[QPAccountManager sharedInstance] startQRCodeAuthenticationWithImage:^(UIImage * _Nonnull qrimage) {
        imageView.image = qrimage;
        [SVProgressHUD dismiss];
    } Completion:^(BOOL success, NSString * _Nonnull msg) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:msg];
            [self dismissViewControllerAnimated:YES completion:NULL];
        } else {
            [SVProgressHUD showErrorWithStatus:msg];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

@end
