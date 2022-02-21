//
//  TestViewController.m
//  QMOpenApiDemo
//
//  Created by maczhou on 2021/11/4.
//

#import "TestViewController.h"
#import "Masonry.h"
#import "TestTableCell.h"
#import <QMOpenApiSDK/QMOpenApiSDK.h>
#import "SVProgressHUD.h"
@interface TestModel:NSObject
@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger state;
- (instancetype)initWithName:(NSString *)name;
@end
@implementation TestModel
- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}
@end

@interface TestViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray<TestModel *> *data;
@property (nonatomic) NSMutableArray *errors;
@property (nonatomic) BOOL shouldShow;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    [self serviceInit];
    self.errors = [NSMutableArray array];
    self.navigationItem.title = [NSString stringWithFormat:@"接口测试(%ld)",self.data.count];
    UIImage *image = [UIImage imageNamed:@"play_circle"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(testButtonPressed)];
    item.imageInsets = UIEdgeInsetsMake(5, 5, -5, -5);
    self.navigationItem.rightBarButtonItem = item;

    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.rowHeight = 60;
    [self.tableView registerClass:[TestTableCell class] forCellReuseIdentifier:@"TestTableCell"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)serviceInit {
    self.data = [NSArray arrayWithObjects:
                 [[TestModel alloc] initWithName:@"searchWithKeyword"],
                 [[TestModel alloc] initWithName:@"searchSmartWithKeyword"],
                 [[TestModel alloc] initWithName:@"fetchCateoryOfPublicRadioWithCompletion"],
                 [[TestModel alloc] initWithName:@"fetchPublicRadioListByCatetoryId"],
                 [[TestModel alloc] initWithName:@"fetchSongOfPublicRadioWithId"],
                 [[TestModel alloc] initWithName:@"fetchRadioOfJustListenWithCompletion"],
                 [[TestModel alloc] initWithName:@"fetchSongOfJustListenRaidoWithId"],
                 [[TestModel alloc] initWithName:@"fetchCategoryOfRankWithCompletion"],
                 [[TestModel alloc] initWithName:@"fetchRankListByCategoryWithId"],
                 [[TestModel alloc] initWithName:@"fetchSongOfRankWithId"],
                 [[TestModel alloc] initWithName:@"fetchAlbumDetailWithMid"],
                 [[TestModel alloc] initWithName:@"fetchAlbumDetailWithId"],
                 [[TestModel alloc] initWithName:@"fetchSongOfAlbumWithMid"],
                 [[TestModel alloc] initWithName:@"fetchSongOfAlbumWithId"],
                 [[TestModel alloc] initWithName:@"fetchSongOfSingerWithId"],
                 [[TestModel alloc] initWithName:@"fetchHotSingerListWithArea"],
                 [[TestModel alloc] initWithName:@"fetchAlbumOfSingerWithId"],
                 [[TestModel alloc] initWithName:@"searchSingerWithKeyword"],
                 [[TestModel alloc] initWithName:@"fetchDailyRecommandSongWithCompletion"],
                 [[TestModel alloc] initWithName:@"fetchPersonalRecommandSongWithCompletion"],
                 [[TestModel alloc] initWithName:@"fetchSimilarSongMid"],
                 [[TestModel alloc] initWithName:@"fetchGreenMemberInformationWithCompletion"],
                 [[TestModel alloc] initWithName:@"fetchCategoryOfRecommandLongAuidoWithCompletion"],
                 [[TestModel alloc] initWithName:@"fetchAlbumListOfRecommandLongAuidoByCategoryWithId"],
                 [[TestModel alloc] initWithName:@"fetchGuessLikeLongAudioWithCompletion"],
                 [[TestModel alloc] initWithName:@"fetchCategoryOfRankLongAudioWithCompletion"],
                 [[TestModel alloc] initWithName:@"fetchAlbumListOfRankLongAudioByCategoryWithId"],
                 [[TestModel alloc] initWithName:@"fetchCategoryOfLongAudioWithCompletion"],
                 [[TestModel alloc] initWithName:@"fetchCategoryFilterOfLongAudioWithId"],
                 [[TestModel alloc] initWithName:@"fetchAlbumListOfLongAuidoByCategoryWithId"],
                 [[TestModel alloc] initWithName:@"fetchRecentUpdateLongAudioWithCompletion"],
                 [[TestModel alloc] initWithName:@"fetchLikeListLongAudioWithCompletion"],
                 [[TestModel alloc] initWithName:@"fetchRecentPlayLongAudioWithCompletion"],
                 [[TestModel alloc] initWithName:@"fetchFolderDetailWithId"],
                 [[TestModel alloc] initWithName:@"fetchPersonalFolderWithCompletion"],
                 [[TestModel alloc] initWithName:@"collectFolderWithId"],
                 [[TestModel alloc] initWithName:@"uncollectFolderWithId"],
                 [[TestModel alloc] initWithName:@"fetchCollectedFolderWithCompletion"],
                 [[TestModel alloc] initWithName:@"fetchCategoryOfFolderWithCompletion"],
                 [[TestModel alloc] initWithName:@"fetchFolderListByCategoryWithId"],
                 [[TestModel alloc] initWithName:@"fetchSongInfoBatchWithMid"],
                 [[TestModel alloc] initWithName:@"fetchSongInfoBatchWithId"],
                 [[TestModel alloc] initWithName:@"fetchNewSongRecommendWithTag"],
                 [[TestModel alloc] initWithName:@"fetchLyricWithSongMid"],
                 [[TestModel alloc] initWithName:@"fetchLyricWithSongId"],
                 [[TestModel alloc] initWithName:@"fetchRecentPlaySongWithUpdateTime"],
                 [[TestModel alloc] initWithName:@"fetchRecentPlayAlbumWithUpdateTime"],
                 [[TestModel alloc] initWithName:@"fetchRecentPlayFolderWithUpdateTime"],
                 [[TestModel alloc] initWithName:@"musicSkillWithIntent"],
                 nil];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestTableCell" forIndexPath:indexPath];
    TestModel *model =self.data[indexPath.row];
    cell.nameLabel.text = model.name;
    if (model.state == 0) {
        cell.nameLabel.textColor = UIColor.blackColor;

        [cell.stateImageView setHidden:YES];
    }else {
        [cell.stateImageView setHidden:NO];
        if (model.state == 1) {
            cell.nameLabel.textColor = UIColor.blackColor;
            cell.stateImageView.image = [UIImage imageNamed:@"checkmark"];
        }else {
            cell.nameLabel.textColor = UIColor.redColor;
            cell.stateImageView.image = [UIImage imageNamed:@"xmark"];
        }
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.data.count == self.errors.count) {
        TestModel *model = self.data[indexPath.row];
        id error = self.errors[indexPath.row];
        if ([error isKindOfClass:[NSString class]]) {
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:model.name message:error preferredStyle:UIAlertControllerStyleAlert];
            [vc addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:vc animated:YES completion:nil];
        }
        else if ([error isKindOfClass:[NSError class]]) {
            NSError *err = (NSError *)error;
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:model.name message:err.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [vc addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }
}


- (void)testButtonPressed {
    [self.errors removeAllObjects];
    dispatch_group_t group = dispatch_group_create();
    for (NSInteger index = 0; index < self.data.count;index++) {
        TestModel *model = self.data[index];
        dispatch_group_enter(group);
        __weak __typeof(self) weakSelf = self;
        if ([model.name isEqualToString:@"searchWithKeyword"]) {
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] searchWithKeyword:@"五月天" typeNumber:[NSNumber numberWithInt:100] pageSize:nil pageNumber:nil completion:^(QPSearchResult * _Nullable result, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"searchSmartWithKeyword"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] searchSmartWithKeyword:@"五月天" completion:^(NSArray<NSString *> * _Nullable results, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [self.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchCateoryOfPublicRadioWithCompletion"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchCateoryOfPublicRadioWithCompletion:^(NSArray<QPCategory *> * _Nullable categories, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchPublicRadioListByCatetoryId"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchPublicRadioListByCatetoryId:@"24" completion:^(NSArray<QPRadio *> * _Nullable radios, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchSongOfPublicRadioWithId"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchSongOfPublicRadioWithId:@"199" pageSize:nil completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchRadioOfJustListenWithCompletion"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchRadioOfJustListenWithCompletion:^(NSArray<QPRadio *> * _Nullable radios, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchSongOfJustListenRaidoWithId"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchSongOfJustListenRaidoWithId:@"595" completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchCategoryOfRankWithCompletion"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchCategoryOfRankWithCompletion:^(NSArray<QPCategory *> * _Nullable categories, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchRankListByCategoryWithId"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchRankListByCategoryWithId:@"0" completion:^(NSArray<QPRank *> * _Nullable ranks, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchSongOfRankWithId"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchSongOfRankWithId:@"62" pageNumber:nil pageSize:nil completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchAlbumDetailWithMid"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchAlbumDetailWithMid:@"002fRO0N4FftzY" completion:^(QPAlbum * _Nullable album, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchAlbumDetailWithId"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchAlbumDetailWithId:@"1393445" completion:^(QPAlbum * _Nullable album, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchSongOfAlbumWithMid"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchSongOfAlbumWithMid:@"002fRO0N4FftzY" pageNumber:[NSNumber numberWithInt:0] pageSize:[NSNumber numberWithInt:50] completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchSongOfAlbumWithId"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchSongOfAlbumWithId:@"1393445" pageNumber:[NSNumber numberWithInt:0] pageSize:[NSNumber numberWithInt:50] completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchSongOfSingerWithId"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchSongOfSingerWithId:@"74" pageNumber:[NSNumber numberWithInt:0] pageSize:[NSNumber numberWithInt:50] order:1 completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchHotSingerListWithArea"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchHotSingerListWithArea:[NSNumber numberWithInt:-100] typeNumber:[NSNumber numberWithInt:-100] genreNumber:[NSNumber numberWithInt:-100] completion:^(NSArray<QPSinger *> * _Nullable singers, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchAlbumOfSingerWithId"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchAlbumOfSingerWithId:@"74" pageNumber:[NSNumber numberWithInt:0] pageSize:[NSNumber numberWithInt:50] order:1 completion:^(NSArray<QPAlbum *> * _Nullable albums, NSInteger total, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"searchSingerWithKeyword"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] searchSingerWithKeyword:@"五月天" pageNumber:nil pageSize:nil completion:^(NSArray<QPSinger *> * _Nullable singers, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchDailyRecommandSongWithCompletion"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchDailyRecommandSongWithCompletion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchPersonalRecommandSongWithCompletion"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchPersonalRecommandSongWithCompletion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchSimilarSongMid"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchSimilarSongMid:@"0048J5cW2AdC2S" completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchGreenMemberInformationWithCompletion"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchGreenMemberInformationWithCompletion:^(QPVipInfo * _Nullable vipInfo, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchCategoryOfRecommandLongAuidoWithCompletion"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchCategoryOfRecommandLongAuidoWithCompletion:^(NSArray<QPCategory *> * _Nullable categories, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchAlbumListOfRecommandLongAuidoByCategoryWithId"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchAlbumListOfRecommandLongAuidoByCategoryWithId:@"0" completion:^(NSArray<QPAlbum *> * _Nullable albums, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchGuessLikeLongAudioWithCompletion"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchGuessLikeLongAudioWithCompletion:^(NSArray<QPAlbum *> * _Nullable albums, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchCategoryOfRankLongAudioWithCompletion"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchCategoryOfRankLongAudioWithCompletion:^(NSArray<QPCategory *> * _Nullable categories, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchAlbumListOfRankLongAudioByCategoryWithId"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchAlbumListOfRankLongAudioByCategoryWithId:@"4013" subCategoryId:@"0" completion:^(NSArray<QPAlbum *> * _Nullable albums, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchCategoryOfLongAudioWithCompletion"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchCategoryOfLongAudioWithCompletion:^(NSArray<QPCategory *> * _Nullable categories, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchCategoryFilterOfLongAudioWithId"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchCategoryFilterOfLongAudioWithId:@"1001" subCateoryId:@"1503" completion:^(NSDictionary<NSString *,NSArray<QPCategory *> *> * _Nullable categories, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchAlbumListOfLongAuidoByCategoryWithId"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchAlbumListOfLongAuidoByCategoryWithId:@"1001" subCategoryId:@"1503" sortType:1 pageSize:[NSNumber numberWithInt:60] pageNumber:[NSNumber numberWithInt:0] filterCategories:nil completion:^(NSArray<QPAlbum *> * _Nullable albums, NSInteger total, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchRecentUpdateLongAudioWithCompletion"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchRecentUpdateLongAudioWithCompletion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchLikeListLongAudioWithCompletion"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchLikeListLongAudioWithCompletion:^(NSArray<QPAlbum *> * _Nullable albums, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchRecentPlayLongAudioWithCompletion"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchRecentPlayLongAudioWithCompletion:^(NSArray<QPAlbum *> * _Nullable albums, NSTimeInterval updateTime, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchFolderDetailWithId"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchFolderDetailWithId:@"7913233767" completion:^(QPFolder * _Nullable folder, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchPersonalFolderWithCompletion"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchPersonalFolderWithCompletion:^(NSArray<QPFolder *> * _Nullable folders, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"collectFolderWithId"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] collectFolderWithId:@"7913233767" completion:^(NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"uncollectFolderWithId"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] uncollectFolderWithId:@"7913233767" completion:^(NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchCollectedFolderWithCompletion"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchCollectedFolderWithCompletion:^(NSArray<QPFolder *> * _Nullable folders, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchCategoryOfFolderWithCompletion"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchCategoryOfFolderWithCompletion:^(NSArray<QPCategory *> * _Nullable categories, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchFolderListByCategoryWithId"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchFolderListByCategoryWithId:@"100823" pageNumber:nil pageSize:nil completion:^(NSArray<QPFolder *> * _Nullable folders, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchSongInfoBatchWithMid"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            QPSongInfo *song = [[QPSongInfo alloc] initWithMid:@"0048J5cW2AdC2S"];
            [[QPOpenAPIManager sharedInstance] fetchSongInfoBatchWithMid:@[song] completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchSongInfoBatchWithId"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            QPSongInfo *song = [[QPSongInfo alloc] init];
            song.identifier = @"5131924";
            [[QPOpenAPIManager sharedInstance] fetchSongInfoBatchWithId:@[song] completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchNewSongRecommendWithTag"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchNewSongRecommendWithTag:12 completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchLyricWithSongMid"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchLyricWithSongMid:@"0048J5cW2AdC2S" completion:^(NSString * _Nullable lyric, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchLyricWithSongId"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchLyricWithSongId:@"5131924" completion:^(NSString * _Nullable lyric, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchRecentPlaySongWithUpdateTime"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchRecentPlaySongWithUpdateTime:0 completion:^(NSArray<QPSongInfo *> * _Nullable songs, NSTimeInterval updateTime, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchRecentPlayAlbumWithUpdateTime"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchRecentPlayAlbumWithUpdateTime:0 completion:^(NSArray<QPAlbum *> * _Nullable albums, NSTimeInterval updateTime, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"fetchRecentPlayFolderWithUpdateTime"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] fetchRecentPlayFolderWithUpdateTime:0 completion:^(NSArray<QPFolder *> * _Nullable folders, NSTimeInterval updateTime, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
        else if ([model.name isEqualToString:@"musicSkillWithIntent"]){
            NSLog(@"接口：%ld-%@",(long)index,model.name);
            [[QPOpenAPIManager sharedInstance] musicSkillWithIntent:@"SearchSong" slots:@{@"Singer":@"周杰伦"} question:@"播放感伤的歌曲" currentSongId:nil itemCount:50 completion:^(NSDictionary * _Nullable data, NSError * _Nullable error) {
                model.state = error == nil ? 1 : 2;
                [weakSelf.tableView reloadData];
                if (error) {
                    [weakSelf.errors addObject:error];
                }else {
                    [weakSelf.errors addObject:@"一切正常"];
                }
                dispatch_group_leave(group);
            }];
        }
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


@end
