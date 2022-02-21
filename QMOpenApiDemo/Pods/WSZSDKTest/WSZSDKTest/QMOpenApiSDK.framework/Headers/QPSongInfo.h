//
//  QPSongInfo.h
//  QQMusicID
//
//  Created by Xiang Cao on 4/14/20.
//  Copyright © 2020 TME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QPAlbum.h"
#import "QPSinger.h"
NS_ASSUME_NONNULL_BEGIN
@interface QPSongInfo : NSObject
///歌曲名称
@property (nonatomic) NSString *name;
///歌曲标题
@property (nonatomic) NSString *title;
///歌曲id
@property (nonatomic) NSString *identifier;
///歌曲mid
@property (nonatomic) NSString *mid;
///所属专辑
@property (nonatomic) QPAlbum *album;
///所属歌手
@property (nonatomic) QPSinger *singer;
///歌曲mv id
@property (nonatomic) NSString *mv_id;
///歌曲mv vid
@property (nonatomic) NSString *mv_vid;
///歌曲version
@property (nonatomic) NSInteger songVersion;
///是否能试听
@property (nonatomic) BOOL canTryPlay;
///是否能够播放该歌曲
@property (nonatomic) BOOL canPlay;
///是否QQ音乐曲库歌曲
@property (nonatomic) BOOL isQQMusic;
///是否收藏
@property (nonatomic) BOOL isCollected;
///是否数字专辑
@property (nonatomic) BOOL isDigitalAlbum;
///是否是长音频
@property (nonatomic,readonly) BOOL isLongAudio;
///是否是长音频类别(包含长音频和播客)
@property (nonatomic,readonly) BOOL isKindOfLongAudio;
///是否独家
@property (nonatomic) BOOL isOnly;
///是否原唱
@property (nonatomic) BOOL isOriginalSing;
///试听开始位置，单位秒。
@property (nonatomic) NSTimeInterval tryBegin;
///试听结束位置，单位秒。
@property (nonatomic) NSTimeInterval tryEnd;
///试听流媒体大小，单位byte。
@property (nonatomic) NSInteger tryFileSize;
///流畅品质流媒体大小，单位字节
@property (nonatomic) NSInteger songSize;
///高品质流媒体大小，单位字节
@property (nonatomic) NSInteger songHQSize;
///无损品质流媒体大小，单位字节
@property (nonatomic) NSInteger songSQSize;
///标准品质流媒体大小，单位字节
@property (nonatomic) NSInteger songStandardSize;
///歌曲播放时长
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) NSInteger type;
///用户拥有接口的权限。0：只浏览；1：可播放
@property (nonatomic) NSInteger user_own_rule;
///1:vip歌曲；0:普通歌曲
@property (nonatomic) NSInteger vip;
///曲作者
@property (nonatomic) NSString *author;
///流派
@property (nonatomic) NSString *genre;
///K歌id
@property (nonatomic) NSString *kSongId;
///K歌mid。
@property (nonatomic,nullable) NSString *kSongMid;
///语言
@property (nonatomic) NSString *language;
///单曲搜索时，如果歌词召回的，返回匹配到的歌词
@property (nonatomic,nullable) NSString *matchLyric;
/**
 该字段标识不能播放的原因代码:
 0，无提示；
 1，版权原因阻断；
 2，未购买绿钻阻断；
 3，未购买数字专辑阻断；
 4，非法区域阻断；
 5，其他阻断
 7，受版权方要求无法在当前设备播放，请到手机QQ音乐上播放
 8，当前接口仅有浏览歌曲信息权限
 9，您不是QQ音乐硬件会员，无法播放
 10，该音频需要付费，请在手机端购买或播放
 11，应版权方要求购买后才能收听，请到手机QQ音乐购买
 **/
@property (nonatomic) NSInteger unplayableCode;
///不能播放原因描述语
@property (nonatomic,nullable) NSString *unplayableMessage;
///歌词
@property (nonatomic,nullable) NSString *lyric;
///长音频听更新时间
@property (nonatomic,nullable) NSString *longAudioUpdateInfo;
///播放次数
@property (nonatomic) NSInteger listenCount;
///优先专辑图120x的 如果没有用150x；如果没有专辑图，再用歌手图
@property (nonatomic,readonly,nullable) NSURL *smallCoverURL;
///优先专辑图500x的 如果没有用300x；如果没有专辑图，再用歌手图
@property (nonatomic,readonly,nullable) NSURL *bigCoverURL;

///以下属性请忽略 内部使用不对外暴露
@property (nonatomic,readonly) BOOL  hasPlayURL;
@property (nonatomic,nullable) NSURL *songPlayURL;
@property (nonatomic,nullable) NSURL *songHQPlayURL;
@property (nonatomic,nullable) NSURL *songSQPlayURL;
@property (nonatomic,nullable) NSURL *songStandardPlayURL;
@property (nonatomic,nullable) NSURL *songH5URL;
@property (nonatomic,nullable) NSURL *try30sURL;

- (instancetype)initWithJSON:(NSDictionary *)json;
- (instancetype)initWithMid:(NSString *)mid;

@end

NS_ASSUME_NONNULL_END
