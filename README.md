

##                                                         OpenApiSDK产品能力说明

通过该SDK，第三方可以方便快速的获取QQ音乐媒资数据，播放音乐以及授权登录等功能。

## 1. 注册平台信息

### **1.1 QQ音乐平台注册（必需）**

SDK使用前，需要申请AppId和AppKey，按如下格式发送邮件。

```
OpenApi开放平台业务开发者申请请按照以下格式发邮件
title：QPlay开发者账号申请-XXXXX公司
send：shuozhao@tencent.com
cc：tangotang@tencent.com;

公司信息：
1、组织名称：XX公司
2、应用名称：XX应用
3、联系人名：（接口人即可，多人请用英文;分隔，后续资料注意保持顺序）
4、联系电话：（接口人即可，多人请用英文;分隔）
5、联系邮件：（接受账号开通信息，多人请用英文;分隔）
6、用户体验：音乐相关的完整UI/HMI/可遍历用户路径的截图/视觉效果图，提供其一
7、规模预估：未来1年的预估的用户规模


技术信息：
1、日访问总量预估：
2、接口并发量：XX次请求/秒（不作为正式配置依据仅作为资源占用参考）
3、使用应用/场景：例-iOS/Android 平台 XX地图 导航中播放音乐
4、应用包名：（如果有多个包名就用;分割） 
5、应用图标：（ 文件:1K-1M，jpg|jpeg|png）
```

**为了保证安全，请妥善保管好AppId和AppKey，任何时候都不要将AppKey泄露。**

### 1.2 微信平台注册（可选，无需支持微信登录可跳过）

微信平台需要注册开发者账号获取相关信息，详情请参考官方文档：

https://open.weixin.qq.com/cgi-bin/frame?t=home/app_tmpl&lang=zh_CN

合作方将获得以下信息：

- 微信平台AppID。
- 微信平台UniversalLink （必需）。

**请注意：微信平台AppID和UniversalLink必须对应，否则将会导致认证失败**



### 1.3 SDK接入

#### 1.3.1 QQ音乐SDK接入

##### 1.3.1.1 CocoaPod方式接入(推荐)

SDK发布地址: [GitHub - QMOpenApiSDK](https://github.com/wszcug/QMOpenApiSDK) (内含Demo，运行Demo请首先在Demo工程目录执行 pod install)。

1、搜索

在终端输入 pod search QMOpenApiSDK

注：如搜不到请执行更新本地Pod命令：pod repo update 并删除本地pod搜索索引 rm ~/Library/Caches/CocoaPods/search_index.json 并再次执行搜索。

2、安装

pod 'QMOpenApiSDK'

注：CocoaPod方式已依赖微信SDK, 如合作方同样依赖微信SDK需要通过CocoaPod管理避免冲突。

3、支持跳转到QQ音乐

参考1.3.1.2中的2、3步。

4、支持跳转到微信

在工程info.plist的LSApplicationQueriesSchemes字段增加weixin和weixinULAPI

![avatar](https://y.qq.com/music/common/upload/t_opi_pic_save_location_temp/4211222.png)



##### 1.3.1.2 手动方式接入

1.将QMOpenApiSDK拖入宿主工程

![avatar](https://y.qq.com/music/common/upload/t_opi_pic_save_location_temp/4211224.png)

2、选中宿主工程文件->TARGETS->Info->URL Types-> 增加Scheme，其中，Identifier和URL Schemes 建议填写宿主工程名字,如图所示

![avatar](https://y.qq.com/music/common/upload/t_opi_pic_save_location_temp/4211197.png)

3.选中宿主工程文件->TARGETS->Info.plist -> 增加LSApplicationQueriesSchemes字段->增加qqmusic

![avatar](https://y.qq.com/music/common/upload/t_opi_pic_save_location_temp/4211199.png)

#### 1.3.1.3 微信SDK接入

请参考官网

https://developers.weixin.qq.com/doc/oplatform/Mobile_App/Access_Guide/iOS.html

**请注意微信SDK接入之后同样需要设置URLScheme 和** **LSApplicationQueriesSchemes，具体方式参考官网介绍。**

demo中的例子：

![avatar](https://y.qq.com/music/common/upload/t_opi_pic_save_location_temp/4211222.png)



## 2. 登录授权的配置

### 2.1 Q音授权配置

```objective-c
- (BOOL)configureWithQMAppID:(NSString *)qmAppID appKey:(NSString *)qmAppKey callBackUrl:(NSString *)callBackUrl;
```

| 参数        | 类型     | 说明                                                         |
| ----------- | -------- | ------------------------------------------------------------ |
| qmAppID     | NSString | QQ音乐分配的AppID                                            |
| qmAppKey    | NSString | QQ音乐分配的AppKey                                           |
| callBackUrl | NSString | 由shcemeURL和://auth组合而成，例如在info.plist中配置URL scheme为qmopenapidemo（工程名小写） |



### 2.2 微信小程序授权配置

```objc
- (BOOL)configureWithWXAppID:(NSString *)wxAppID universalLink:(NSString *)universalLink;
```

| 参数          | 类型     | 说明                    |
| ------------- | -------- | ----------------------- |
| wxAppID       | NSString | 微信分配的AppID         |
| universalLink | NSString | 微信分配的universalLink |



### 2.3 发起认证

#### 2.3.1 QQ音乐认证

```
- (void)startQQMusicAuthenticationWithCompletion:(void(^)(BOOL success, NSString *msg))completion;
```

#### 2.3.2 微信小程序认证

```
- (void)startWXMiniAppAuthenticationWithCompletion:(void(^)(BOOL success, NSString *msg))completion;
```

#### 2.3.3QQH5认证

```
- (void)startQQH5AuthenticationWithWebUrl:(void(^)(NSString *webUrl))webUrl Completion:(void(^)(BOOL success, NSString *msg))completion;
```

#### 2.3.4 二维码认证（包括QQ、微信、Q音）

```
- (void)startQQH5AuthenticationWithWebUrl:(void(^)(NSString *webUrl))webUrl Completion:(void(^)(BOOL success, NSString *msg))completion;
```

### 2.4 登录状态

#### 2.4.1 获取当前登录状态

```
- (BOOL)isLogin;
```

#### 2.4.2 登出

```
- (void)logout;
```



## 3. 内容获取

#### 3.1 搜索

3.1.1 歌曲、专辑、MV搜索

```
- (void)searchWithKeyword:(NSString *)keyword typeNumber:(NSNumber * _Nullable)typeNumber pageSize:(NSNumber * _Nullable)pageSize pageNumber:(NSNumber * _Nullable)pageNumber completion:(void (^)(QPSearchResult *_Nullable result, NSError * _Nullable error))completion;
```

| 入参       | 类型     | 说明                                                         |
| ---------- | -------- | ------------------------------------------------------------ |
| keyword    | NSString | 搜索关键字                                                   |
| typeNumber | NSNumber | 搜索类型 0：单曲搜索 3:歌单搜索 8：专辑搜索  15：电台 100:歌词 //(默认为0) |
| pageSize   | NSNumber | 每页数 最大50，默认20个 （注意：歌词是1-10,默认10）          |
| pageNumber | NSNumber | 搜索页码最大4页，默认1页 （注意：歌词是1-10，默认第一页）    |

| 返回值 | 类型           | 说明                                                         |
| ------ | -------------- | ------------------------------------------------------------ |
| result | QPSearchResult | 对象类型，包含以下字段：<br />1:currentNumber 当前返回个数<br />2:currentPage 当前页码<br />3:totoalNumber 该搜索词可以搜到的总结果数<br />4:keyword 搜索词<br />5:albums 专辑结果，数组类型<br />6:songs 歌曲结果，数组类型<br />7:folders 歌单结果，数组类型<br />8:lyrics 歌词结果，数组类型 |
| error  | NSError        | 错误信息                                                     |



3.1.2 搜索提示smartbox

```
- (void)searchSmartWithKeyword:(NSString *)keyword completion:(void (^)(NSArray<NSString *> *_Nullable results, NSError * _Nullable error))completion;
```

| 入参    | 类型     | 说明       |
| ------- | -------- | ---------- |
| keyword | NSString | 搜索关键字 |

| 返回值  | 类型    | 说明         |
| ------- | ------- | ------------ |
| results | NSArray | 存储返回结果 |
| error   | NSError | 错误信息     |



#### 3.2 电台

3.2.1 获取公共电台分类(针对免费用户，返回免费用户可听的电台列表。

```
- (void)fetchCateoryOfPublicRadioWithCompletion:(void (^)(NSArray<QPCategory *> *_Nullable categories, NSError * _Nullable error))completion;
```

| 返回值     | 类型    | 说明                                                         |
| ---------- | ------- | ------------------------------------------------------------ |
| categories | NSArray | 存储QPCategory类型的数组，包含成员为：<br />1:identifier 分类id<br />2:name 分类名<br />3:type 分类类型<br />4:typeName 类型名称<br />5:subCategories 子分类，数组类型，存储QPCategory |
| error      | NSError | 错误信息                                                     |



3.2.2 通过公共电台分类id获取电台列表

```
- (void)fetchPublicRadioListByCatetoryId:(NSString *)categoryId completion:(void (^)(NSArray<QPRadio *> *_Nullable radios, NSError * _Nullable error))completion;
```

| 入参       | 类型     | 说明           |
| ---------- | -------- | -------------- |
| categoryId | NSString | 公共电台分类id |

| 返回值 | 类型    | 说明                                                         |
| ------ | ------- | ------------------------------------------------------------ |
| radios | NSArray | 存储QPRadio类型的数组，包含成员为：<br />1:name 电台名<br />2:identifier 电台ID<br />3:picURL 电台封面<br />4:listenCount 电台收听次数<br /> |
| error  | NSError | 错误信息                                                     |



3.2.3 获取公共电台歌曲

```
- (void)fetchSongOfPublicRadioWithId:(NSString *) radioId pageSize:(NSNumber *_Nullable) pageSize completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;
```

| 入参     | 类型     | 说明                  |
| -------- | -------- | --------------------- |
| radioId  | NSString | 公共电台id            |
| pageSize | NSNumber | 限制最大个数 范围0-20 |

| 返回值 | 类型    | 说明                                                         |
| ------ | ------- | ------------------------------------------------------------ |
| songs  | NSArray | 存储QPSongInfo类型的数组，包含成员为：<br />1:name 歌曲名称<br />2:title 歌曲标题<br />3:identifier 歌曲id<br />4:mid 歌曲mid<br />5:album 所属专辑<br />6:singer 所属歌手<br />7:mv_id 歌曲mv id<br />8:mv_vid 歌曲mv vid<br />9:songVersion 歌曲version<br />10:canTryPlay 是否能试听<br />11:canPlay 是否能够播放该歌曲<br />12:isQQMusic 是否QQ音乐曲库歌曲<br />13:isCollected 是否收藏<br />14:isDigitalAlbum 是否数字专辑<br />15:isLongAudio 是否是长音频<br />16:isKindOfLongAudio 是否是长音频类别(包含长音频和播客)<br />17:isOnly 是否独家<br />18:isOriginalSing 是否原唱<br />19:tryBegin 试听开始位置，单位秒。<br />20:tryEnd 试听结束位置，单位秒。<br />21:tryFileSize 试听流媒体大小，单位byte。<br />22:songSize 流畅品质流媒体大小，单位字节<br />23:songHQSize 高品质流媒体大小，单位字节<br />24:songSQSize 无损品质流媒体大小，单位字节<br />25:songStandardSize 标准品质流媒体大小，单位字节<br />26:duration 歌曲播放时长<br />27:user_own_rule 用户拥有接口的权限。0：只浏览；1：可播放<br />28:vip 1:vip歌曲；0:普通歌曲<br />29:author 曲作者<br />30:genre 流派<br />31:kSongId K歌id<br />32:kSongMid K歌mid<br />33:language语言<br />34:matchLyric 单曲搜索时，如果歌词召回的，返回匹配到的歌词<br />35:unplayableCode 该字段标识不能播放的原因<br />     0 无提示<br />     1 版权原因阻断<br />     2 未购买绿钻阻断<br />     3 未购买数字专辑阻断<br />     4 非法区域阻断<br />     5 其他阻断<br />     7 无法在当前设备播放，请到手机QQ音乐上播放<br />     8 当前接口仅有浏览歌曲信息权限<br />     9 不是QQ音乐硬件会员，无法播放<br />     10 该音频需要付费，请在手机端购买或播放<br />     11 应版权方要求购买后才能收听，请到手机QQ音乐购买<br />36: unplayableMessage 不能播放原因描述语<br />37: lyric 歌词<br />38:longAudioUpdateInfo 长音频听更新时间<br />39:listenCount 播放次数<br />40:smallCoverURL 优先专辑图120x的 如果没有用150x；如果没有专辑图，再用歌手图<br />41:bigCoverURL 优先专辑图500x的 如果没有用300x；如果没有专辑图，再用歌手图 |
| error  | NSError | 错误信息                                                     |



3.2.4 获取随便听听电台列表

```
- (void)fetchRadioOfJustListenWithCompletion:(void (^)(NSArray<QPRadio *> *_Nullable radios, NSError * _Nullable error))completion;
```

| 返回值 | 类型    | 说明                                              |
| ------ | ------- | ------------------------------------------------- |
| radios | NSArray | 存储QPRadio类型的数组，QPRadio详细信息请参看3.2.2 |
| error  | NSError | 错误信息                                          |



3.2.5 获取随便听听电台歌曲

```
- (void)fetchSongOfJustListenRaidoWithId:(NSString *) radioId completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;
```

| 入参    | 类型     | 说明           |
| ------- | -------- | -------------- |
| radioId | NSString | 随便听听电台id |

| 返回值 | 类型    | 说明                                                  |
| ------ | ------- | ----------------------------------------------------- |
| songs  | NSArray | 存储QPSongInfo类型的数组，具体信息参看3.2.3返回值部分 |
| error  | NSError | 错误信息                                              |



#### 3.3 排行榜

3.3.1 获取音乐馆排行榜分类

```
- (void)fetchCategoryOfRankWithCompletion:(void (^)(NSArray<QPCategory *> *_Nullable categories, NSError * _Nullable error))completion;
```

| 返回值     | 类型    | 说明                                                  |
| ---------- | ------- | ----------------------------------------------------- |
| categories | NSArray | 存储QPCategory类型的数组，具体信息参看3.2.1返回值部分 |
| error      | NSError | 错误信息                                              |



3.3.2 根据分类id获取音乐馆排行榜列表

```
- (void)fetchRankListByCategoryWithId:(NSString *)categoryId completion:(void (^)(NSArray<QPRank *> *_Nullable ranks, NSError * _Nullable error))completion;
```

| 入参       | 类型     | 说明   |
| ---------- | -------- | ------ |
| categoryId | NSString | 分类id |

| 返回值 | 类型    | 说明                                                         |
| ------ | ------- | ------------------------------------------------------------ |
| ranks  | NSArray | 存储QPRank类型的数组，包含成员为<br />1:identifier 排行榜榜单id<br />2:name 排行榜榜单名<br />3:type 类别<br />4:listenCount 听的次数<br />5:date 时间<br />6:headerURL 排行榜头图url<br />7:bannerURL 排行榜横幅图url<br />8:total 榜单下歌曲数量<br />9:desc 榜单描述 |
| error  | NSError | 错误信息                                                     |



3.3.3  获取音乐馆排行榜歌曲

```
- (void)fetchSongOfRankWithId:(NSString *)rankId pageNumber:(NSNumber *_Nullable)pageNumber pageSize:(NSNumber *_Nullable)pageSize completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;
```

| 入参       | 类型     | 说明                          |
| ---------- | -------- | ----------------------------- |
| rankId     | NSString | 排行榜id                      |
| pageNumber | NSNumber | 第几页 取值从0开始            |
| pageSize   | NSNumber | 每页大小  默认为20 最大值为50 |

| 返回值 | 类型    | 说明                                                  |
| ------ | ------- | ----------------------------------------------------- |
| songs  | NSArray | 存储QPSongInfo类型的数组，具体信息参看3.2.3返回值部分 |
| error  | NSError | 错误信息                                              |



#### 3.4 专辑

3.4.1 获取专辑详情(通过mid)

```
- (void)fetchAlbumDetailWithMid:(NSString  *)albumMid completion:(void (^)(QPAlbum *_Nullable album, NSError * _Nullable error))completion;
```

| 入参     | 类型     | 说明    |
| -------- | -------- | ------- |
| albumMid | NSString | 专辑mid |

| 返回值 | 类型    | 说明                                                         |
| ------ | ------- | ------------------------------------------------------------ |
| album  | QPAlbum | QPAlbum成员如下：<br />1:identifier 专辑id<br />2:mid 专辑mid<br />3:companyId 公司id<br />4:companyName 公司名称<br />5:name 专辑名<br />6:subName 专辑副名<br />7:transName 翻译专辑名<br />8:pic120xURL 专辑120x120图片<br />9:pic150xURL 专辑150x150图片<br />10:pic300xURL 专辑300x300图片<br />11:pic500xURL 专辑500x500图片<br />12:vipPic 是否收费(是一个图片地址) 长音频返回<br />13:desc 专辑描述<br />14:singers 专辑歌手<br />15:releaseDate 发行时间<br />16:total 专辑歌曲总数<br />17:songIdList 专辑下歌曲id列表<br />18:lastPlayTime 长音频 最近播放时间(秒级时间戳)<br />19:smallCoverURL 专辑小图<br />20:bigCoverURL 专辑大图 |
| error  | NSError | 错误信息                                                     |



3.4.2 获取专辑详情(通过id)

```
- (void)fetchAlbumDetailWithId:(NSString  *)albumId completion:(void (^)(QPAlbum *_Nullable album, NSError * _Nullable error))completion;
```

| 入参    | 类型     | 说明   |
| ------- | -------- | ------ |
| albumId | NSString | 专辑id |

| 返回值 | 类型    | 说明                   |
| ------ | ------- | ---------------------- |
| album  | QPAlbum | QPAlbum信息请参看3.4.1 |
| error  | NSError | 错误信息               |



3.4.3 获取专辑歌曲(通过mid)

```
- (void)fetchSongOfAlbumWithMid:(NSString  *)albumMid pageNumber:(NSNumber *)pageNumber pageSize:(NSNumber *)pageSize completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;
```

| 入参       | 类型     | 说明                    |
| ---------- | -------- | ----------------------- |
| albumMid   | NSString | 专辑mid                 |
| pageNumber | NSNumber | 请求第几页，取值从0开始 |
| pageSize   | NSNumber | 每页的歌曲数            |

| 返回值 | 类型    | 说明                                                  |
| ------ | ------- | ----------------------------------------------------- |
| songs  | NSArray | 存储QPSongInfo类型的数组，具体信息参看3.2.3返回值部分 |
| error  | NSError | 错误信息                                              |



3.4.4 获取专辑歌曲(通过id)

```
- (void)fetchSongOfAlbumWithId:(NSString  *)albumId pageNumber:(NSNumber *)pageNumber pageSize:(NSNumber *)pageSize completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;
```

| 入参       | 类型     | 说明                    |
| ---------- | -------- | ----------------------- |
| albumId    | NSString | 专辑id                  |
| pageNumber | NSNumber | 请求第几页，取值从0开始 |
| pageSize   | NSNumber | 每页的歌曲数            |

| 返回值 | 类型    | 说明                                                  |
| ------ | ------- | ----------------------------------------------------- |
| songs  | NSArray | 存储QPSongInfo类型的数组，具体信息参看3.2.3返回值部分 |
| error  | NSError | 错误信息                                              |



#### 3.5 歌手

3.5.1  获取歌手歌曲信息(通过歌手id)

```
- (void)fetchSongOfSingerWithId:(NSString *) singerId pageNumber:(NSNumber *)pageNumber pageSize:(NSNumber *)pageSize order:(NSInteger)order completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;
```

| 入参       | 类型      | 说明                            |
| ---------- | --------- | ------------------------------- |
| singerId   | NSString  | 歌手id                          |
| pageNumber | NSNumber  | 分页索引，从0开始               |
| pageSize   | NSNumber  | 每页歌曲数目，最大为50，需大于0 |
| order      | NSInteger | 歌曲排序方式                    |

| 返回值 | 类型    | 说明                                                  |
| ------ | ------- | ----------------------------------------------------- |
| songs  | NSArray | 存储QPSongInfo类型的数组，具体信息参看3.2.3返回值部分 |
| error  | NSError | 错误信息                                              |



3.5.2 获取热门歌手列表

```
- (void)fetchHotSingerListWithArea:(NSNumber *_Nullable)areaNumber typeNumber:(NSNumber *_Nullable) typeNumber genreNumber:(NSNumber *_Nullable) genreNumber completion:(void (^)(NSArray<QPSinger *> *_Nullable singers, NSError * _Nullable error))completion
```

| 入参        | 类型      | 说明                                                         |
| ----------- | --------- | ------------------------------------------------------------ |
| areaNumber  | NSNumber  | 歌手所在地区索引,取值如下：<br />-100：全部<br />200 ：内地<br />2：港台<br />3：韩国<br />4：日本<br />5：欧美<br />6：其它 |
| typeNumber  | NSNumber  | 歌手性别索引，取值如下：<br />-100：全部<br />0：男<br />1：女<br />2：组合 |
| genreNumber | NSNumber  | 歌手所属流派索引，取值如下：<br />-100：全部<br />1：流行<br />2：摇滚<br />3：民谣<br />4：电子<br />5：爵士<br />6：嘻哈<br />8：R&B<br />9：轻音乐<br />10：民歌<br />14：古典<br />20：蓝调<br />25：乡村 |
| order       | NSInteger | 歌曲排序方式                                                 |

| 返回值 | 类型    | 说明                                                  |
| ------ | ------- | ----------------------------------------------------- |
| songs  | NSArray | 存储QPSongInfo类型的数组，具体信息参看3.2.3返回值部分 |
| error  | NSError | 错误信息                                              |



3.5.3 获取歌手专辑列表信息

```
- (void)fetchAlbumOfSingerWithId:(NSString *) singerId pageNumber:(NSNumber *)pageNumber pageSize:(NSNumber *)pageSize order:(NSInteger)order completion:(void (^)(NSArray<QPAlbum *> *_Nullable albums,NSInteger total, NSError * _Nullable error))completion;
```

| 入参       | 类型      | 说明                                             |
| ---------- | --------- | ------------------------------------------------ |
| singerId   | NSString  | 歌手id                                           |
| pageNumber | NSNumber  | 分页索引，从0开始                                |
| pageSize   | NSNumber  | 每页歌曲数目，最大为50，需大于0                  |
| order      | NSInteger | 歌曲排序方式，0：表示按时间(默认)，1：表示按热度 |

| 返回值 | 类型      | 说明                                     |
| ------ | --------- | ---------------------------------------- |
| albums | NSArray   | 存储QPAlbum类型的数组，具体信息参看3.4.1 |
| total  | NSInteger | 总数                                     |
| error  | NSError   | 错误信息                                 |



3.5.4 搜索歌手列表(通过搜索关键字，搜索歌手列表，可分页拉取。)

```
- (void)searchSingerWithKeyword:(NSString *)keyword pageNumber:(NSNumber *_Nullable)pageNumber pageSize:(NSNumber *_Nullable)pageSize completion:(void (^)(NSArray<QPSinger *> *_Nullable singers, NSError * _Nullable error))completion;
```

| 入参       | 类型     | 说明                           |
| ---------- | -------- | ------------------------------ |
| keyword    | NSString | 搜索关键字                     |
| pageNumber | NSNumber | 分页索引，从1开始，最大2页     |
| pageSize   | NSNumber | 每页歌手数目，默认10，最大为20 |

| 返回值  | 类型    | 说明                                                         |
| ------- | ------- | ------------------------------------------------------------ |
| singers | NSArray | 存储QPSinger类型的数组，QPSinger信息如下：<br />1:identifier 歌手id<br />2:mid 歌手mid<br />3:name 歌手名<br />4:transName 歌手翻译名<br />5:area 歌手地区 <br />6:title<br />7:pic120xURL 歌手120x120图<br />8:pic150xURL 歌手150x150图<br />9:pic300xURL 歌手300x300图<br />10:pic500xURL 歌手500x500图<br />11:totalSongs 歌曲总数<br />12:totalMVs MV总数<br />13:totalAlbums 专辑总数<br />14:smallCoverURL 小图<br />15:bigCoverURL 大图 |
| error   | NSError | 错误信息                                                     |



#### 3.6 推荐

3.6.1 获取每日30首推荐

```
- (void)fetchDailyRecommandSongWithCompletion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;
```

| 返回值 | 类型    | 说明                                                  |
| ------ | ------- | ----------------------------------------------------- |
| songs  | NSArray | 存储QPSongInfo类型的数组，具体信息参看3.2.3返回值部分 |
| error  | NSError | 错误信息                                              |



3.6.2 个性化推荐歌曲

```
- (void)fetchPersonalRecommandSongWithCompletion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;
```

| 返回值 | 类型    | 说明                                                  |
| ------ | ------- | ----------------------------------------------------- |
| songs  | NSArray | 存储QPSongInfo类型的数组，具体信息参看3.2.3返回值部分 |
| error  | NSError | 错误信息                                              |



3.6.3 相似单曲推荐(mid)

```
- (void)fetchSimilarSongMid:(NSString *) songMid completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;
```

| 入参    | 类型     | 说明     |
| ------- | -------- | -------- |
| songMid | NSString | song mid |

| 返回值 | 类型    | 说明                                                  |
| ------ | ------- | ----------------------------------------------------- |
| songs  | NSArray | 存储QPSongInfo类型的数组，具体信息参看3.2.3返回值部分 |
| error  | NSError | 错误信息                                              |



#### 3.7 长音频

3.7.1 获取长音频推荐模块列表的分类

```
- (void)fetchCategoryOfRecommandLongAuidoWithCompletion:(void (^)(NSArray<QPCategory *> *_Nullable categories, NSError * _Nullable error))completion;
```

| 返回值     | 类型    | 说明                                                |
| ---------- | ------- | --------------------------------------------------- |
| categories | NSArray | 存储QPCategory类型的数组，具体信息参看3.2.1返回部分 |
| error      | NSError | 错误信息                                            |



3.7.2 通过分类id获取长音频推荐模块的专辑列表

```
- (void)fetchAlbumListOfRecommandLongAuidoByCategoryWithId:(NSString *)categoryId completion:(void (^)(NSArray<QPAlbum *> *_Nullable albums, NSError * _Nullable error))completion
```

| 入参       | 类型     | 说明       |
| ---------- | -------- | ---------- |
| categoryId | NSString | 榜单分类Id |

| 返回值 | 类型    | 说明                                     |
| ------ | ------- | ---------------------------------------- |
| albums | NSArray | 存储QPAlbum类型的数组，具体信息参看3.4.1 |
| error  | NSError | 错误信息                                 |



3.7.3 猜你喜欢获取电台模块下的猜你喜欢模块(需要登录态)

```
- (void)fetchGuessLikeLongAudioWithCompletion:(void (^)(NSArray<QPAlbum *> *_Nullable albums, NSError * _Nullable error))completion;
```

| 返回值 | 类型    | 说明                                     |
| ------ | ------- | ---------------------------------------- |
| albums | NSArray | 存储QPAlbum类型的数组，具体信息参看3.4.1 |
| error  | NSError | 错误信息                                 |



3.7.4 获取电台模块排行榜分类

```
- (void)fetchCategoryOfRankLongAudioWithCompletion:(void (^)(NSArray<QPCategory *> *_Nullable categories, NSError * _Nullable error))completion;
```

| 返回值     | 类型    | 说明                                                |
| ---------- | ------- | --------------------------------------------------- |
| categories | NSArray | 存储QPCategory类型的数组，具体信息参看3.2.1返回部分 |
| error      | NSError | 错误信息                                            |



3.7.5 获取电台模块下排行榜榜单专辑列表

```
- (void)fetchAlbumListOfRankLongAudioByCategoryWithId:(NSString *)categoryId subCategoryId:(NSString *_Nullable)subCategoryId completion:(void (^)(NSArray<QPAlbum *> *_Nullable albums, NSError * _Nullable error))completion;
```

| 入参          | 类型     | 说明         |
| ------------- | -------- | ------------ |
| categoryId    | NSString | 榜单分类Id   |
| subCategoryId | NSString | 榜单子分类Id |

| 返回值 | 类型    | 说明                                     |
| ------ | ------- | ---------------------------------------- |
| albums | NSArray | 存储QPAlbum类型的数组，具体信息参看3.4.1 |
| error  | NSError | 错误信息                                 |



3.7.6  获取长音频分类信息

```
- (void)fetchCategoryOfLongAudioWithCompletion:(void (^)(NSArray<QPCategory *> *_Nullable categories, NSError * _Nullable error))completion;
```

| 返回值     | 类型    | 说明                                                |
| ---------- | ------- | --------------------------------------------------- |
| categories | NSArray | 存储QPCategory类型的数组，具体信息参看3.2.1返回部分 |
| error      | NSError | 错误信息                                            |



3.7.7 获取长音频过滤分类

```
- (void)fetchCategoryFilterOfLongAudioWithId:(NSString *)categoryId subCateoryId:(NSString *)subCateoryId completion:(void (^)(NSDictionary<NSString*,NSArray<QPCategory *>*> *_Nullable categories, NSError * _Nullable error))completion
```

| 入参          | 类型     | 说明         |
| ------------- | -------- | ------------ |
| categoryId    | NSString | 榜单分类Id   |
| subCategoryId | NSString | 榜单子分类Id |

| 返回值     | 类型         | 说明                                                         |
| ---------- | ------------ | ------------------------------------------------------------ |
| categories | NSDictionary | 存储QPCategory和对应key的字典类型，QPCategory具体信息参看3.2.1返回部分 |
| error      | NSError      | 错误信息                                                     |



3.7.8 获取分类专辑列表

```
- (void)fetchAlbumListOfLongAuidoByCategoryWithId:(NSString *)catetoryId subCategoryId:(NSString *)subCategoryId sortType:(NSInteger)sortType pageSize:(NSNumber * _Nullable)pageSize pageNumber:(NSNumber * _Nullable)pageNumber filterCategories:(NSArray<QPCategory *>*_Nullable)filterCategories completion:(void (^)(NSArray<QPAlbum *> *_Nullable albums,NSInteger total, NSError * _Nullable error))completion;
```

| 入参             | 类型      | 说明                                 |
| ---------------- | --------- | ------------------------------------ |
| catetoryId       | NSString  | 长音频一级分类id                     |
| subCategoryId    | NSString  | 长音频二级分类id                     |
| sortType         | NSInteger | 列表排序参数0最新，1：最热(默认)     |
| pageSize         | NSNumber  | 页面大小(默认10个，最大60)           |
| pageNumber       | NSNumber  | 第几页                               |
| filterCategories | NSArray   | 过滤分类（存储QPCategory类型的数组） |

| 返回值 | 类型      | 说明                                     |
| ------ | --------- | ---------------------------------------- |
| albums | NSArray   | 存储QPAlbum类型的数组，具体信息参看3.4.1 |
| total  | NSInteger | 总数                                     |
| error  | NSError   | 错误信息                                 |



3.7.9  获取个人资产电台模块中【听更新】数据(需要登录)

```
- (void)fetchRecentUpdateLongAudioWithCompletion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;
```

| 返回值 | 类型    | 说明                                                  |
| ------ | ------- | ----------------------------------------------------- |
| songs  | NSArray | 存储QPSongInfo类型的数组，具体信息参看3.2.3返回值部分 |
| error  | NSError | 错误信息                                              |



3.7.10 获取个人资产电台模块中【喜欢】数据(需要登录)

```
- (void)fetchLikeListLongAudioWithCompletion:(void (^)(NSArray<QPAlbum *> *_Nullable albums, NSError * _Nullable error))completion;
```

| 返回值 | 类型    | 说明                                     |
| ------ | ------- | ---------------------------------------- |
| albums | NSArray | 存储QPAlbum类型的数组，具体信息参看3.4.1 |
| error  | NSError | 错误信息                                 |



3.7.11 获取个人资产电台模块中【最近】数据(需要登录)

```
- (void)fetchRecentPlayLongAudioWithCompletion:(void (^)(NSArray<QPAlbum *> *_Nullable albums,NSTimeInterval updateTime, NSError * _Nullable error))completion;
```

| 返回值     | 类型           | 说明                                     |
| ---------- | -------------- | ---------------------------------------- |
| albums     | NSArray        | 存储QPAlbum类型的数组，具体信息参看3.4.1 |
| updateTime | NSTimeInterval | 更新时间                                 |
| error      | NSError        | 错误信息                                 |



#### 3.8 歌单

3.8.1 创建歌单

```
- (void)createFolderWithName:(NSString *)name completion:(void (^)(NSString *_Nullable folderId, NSError * _Nullable error))completion;
```

| 入参 | 类型     | 说明     |
| ---- | -------- | -------- |
| name | NSString | 歌单名称 |

| 返回值   | 类型     | 说明     |
| -------- | -------- | -------- |
| folderId | NSString | 歌单ID   |
| error    | NSError  | 错误信息 |



3.8.2 删除歌单

```
- (void)deleteFolderWithId:(NSString *)folderId completion:(void (^)(NSError * _Nullable error))completion;
```

| 入参     | 类型     | 说明   |
| -------- | -------- | ------ |
| folderId | NSString | 歌单ID |

| 返回值 | 类型    | 说明     |
| ------ | ------- | -------- |
| error  | NSError | 错误信息 |



3.8.3 获取歌单中歌曲列表

```
- (void)fetchSongOfFolderWithId:(NSString *)folderId pageNumber:(NSNumber *_Nullable)pageNumber pageSize:(NSNumber *_Nullable)pageSize completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;
```

| 入参       | 类型     | 说明                      |
| ---------- | -------- | ------------------------- |
| folderId   | NSString | 歌单ID                    |
| pageNumber | NSNumber | 页码，取值从0开始         |
| pageSize   | NSNumber | 每页的数量，最大50;默认10 |

| 返回值 | 类型    | 说明                                                  |
| ------ | ------- | ----------------------------------------------------- |
| songs  | NSArray | 存储QPSongInfo类型的数组，具体信息参看3.2.3返回值部分 |
| error  | NSError | 错误信息                                              |



3.8.4 获取歌单详情

```
- (void)fetchFolderDetailWithId:(NSString *)folderId completion:(void (^)(QPFolder *_Nullable folder, NSError * _Nullable error))completion;
```

| 入参     | 类型     | 说明   |
| -------- | -------- | ------ |
| folderId | NSString | 歌单ID |

| 返回值 | 类型     | 说明                                                         |
| ------ | -------- | ------------------------------------------------------------ |
| folder | QPFolder | 歌单详情信息如下：<br />1：createTime 歌单创建时间<br />2：updateTime 歌单修改时间<br />3: creator 歌单创建者<br />4: identifier 歌单id<br />5:name 歌单名<br />6:title 歌单显示名<br />7:picURL 歌单封面<br />8:totalNum 歌单歌曲数量 <br />9:favNum 歌单被收藏数量<br />10：introduction 歌单介绍<br />11:listenNum 歌单收听数量<br />12：isCollected 是否收藏，1：收藏，0：非收藏<br />13:isCreatedBySelf 是否自己创建的歌单 |
| error  | NSError  | 错误信息                                                     |



3.8.5 获取个人歌单目录

```
- (void)fetchPersonalFolderWithCompletion:(void (^)(NSArray<QPFolder *> *_Nullable folders, NSError * _Nullable error))completion;
```

| 返回值  | 类型    | 说明                                      |
| ------- | ------- | ----------------------------------------- |
| folders | NSArray | 存储QPFolder类型的数组，具体信息参看3.8.4 |
| error   | NSError | 错误信息                                  |



3.8.6 收藏歌单广场的歌单

```
- (void)collectFolderWithId:(NSString *)folderId completion:(void (^)(NSError * _Nullable error))completion;
```

| 入参     | 类型     | 说明   |
| -------- | -------- | ------ |
| folderId | NSString | 歌单ID |

| 返回值 | 类型    | 说明     |
| ------ | ------- | -------- |
| error  | NSError | 错误信息 |



3.8.7 取消收藏歌单广场的歌单

```
- (void)uncollectFolderWithId:(NSString *)folderId completion:(void (^)(NSError * _Nullable error))completion;
```

| 入参     | 类型     | 说明   |
| -------- | -------- | ------ |
| folderId | NSString | 歌单ID |

| 返回值 | 类型    | 说明     |
| ------ | ------- | -------- |
| error  | NSError | 错误信息 |



3.8.8 获取歌单广场的歌单

```
- (void)fetchCollectedFolderWithCompletion:(void (^)(NSArray<QPFolder *> *_Nullable folders, NSError * _Nullable error))completion;
```

| 返回值  | 类型    | 说明                                      |
| ------- | ------- | ----------------------------------------- |
| folders | NSArray | 存储QPFolder类型的数组，具体信息参看3.8.4 |
| error   | NSError | 错误信息                                  |



3.8.9 个人歌单中增加歌曲(通过mid)

```
- (void)addSongWithMid:(NSArray<QPSongInfo *> *)songs to:(NSString *)folderId completion:(void (^)(NSError * _Nullable error))completion;
```

| 入参     | 类型     | 说明                |
| -------- | -------- | ------------------- |
| songs    | NSArray  | 有mid的songInfo数组 |
| folderId | NSString | 歌单id              |

| 返回值 | 类型    | 说明     |
| ------ | ------- | -------- |
| error  | NSError | 错误信息 |



3.8.10 个人歌单中增加歌曲(通过id)

```
- (void)addSongWithId:(NSArray<QPSongInfo *> *)songs to:(NSString *)folderId completion:(void (^)(NSError * _Nullable error))completion;
```

| 入参     | 类型     | 说明               |
| -------- | -------- | ------------------ |
| songs    | NSArray  | 有id的songInfo数组 |
| folderId | NSString | 歌单id             |

| 返回值 | 类型    | 说明     |
| ------ | ------- | -------- |
| error  | NSError | 错误信息 |



3.8.11 个人歌单中删除歌曲(通过mid)

```
- (void)deleteSongWithMid:(NSArray<QPSongInfo *> *)songs from:(NSString *)folderId completion:(void (^)(NSError * _Nullable error))completion;
```

| 入参     | 类型     | 说明                |
| -------- | -------- | ------------------- |
| songs    | NSArray  | 有mid的songInfo数组 |
| folderId | NSString | 歌单id              |

| 返回值 | 类型    | 说明     |
| ------ | ------- | -------- |
| error  | NSError | 错误信息 |



3.8.12 个人歌单中删除歌曲(通过id)

```
- (void)deleteSongWithId:(NSArray<QPSongInfo *> *)songs from:(NSString *)folderId completion:(void (^)(NSError * _Nullable error))completion;
```

| 入参     | 类型     | 说明               |
| -------- | -------- | ------------------ |
| songs    | NSArray  | 有id的songInfo数组 |
| folderId | NSString | 歌单id             |

| 返回值 | 类型    | 说明     |
| ------ | ------- | -------- |
| error  | NSError | 错误信息 |



3.8.13  获取音乐馆下的分类歌单的分类

```
- (void)fetchCategoryOfFolderWithCompletion:(void (^)(NSArray<QPCategory *> *_Nullable categories, NSError * _Nullable error))completion;
```

| 返回值     | 类型    | 说明                                        |
| ---------- | ------- | ------------------------------------------- |
| categories | NSArray | 存储QPCategory类型的数组，具体信息参看3.2.1 |
| error      | NSError | 错误信息                                    |



3.8.14  获取音乐馆分类歌单下的歌单详情

```
- (void)fetchFolderListByCategoryWithId:(NSString *) categoryId pageNumber:(NSNumber *_Nullable)pageNumber pageSize:(NSNumber *_Nullable) pageSize completion:(void (^)(NSArray<QPFolder *> *_Nullable folders, NSError * _Nullable error))completion;
```

| 入参       | 类型     | 说明                           |
| ---------- | -------- | ------------------------------ |
| categoryId | NSString | 分类Id                         |
| pageNumber | NSNumber | 请求类下歌单列表开始页。默认0  |
| pageSize   | NSNumber | 请求类下歌单列表页大小。默认20 |

| 返回值  | 类型    | 说明                                      |
| ------- | ------- | ----------------------------------------- |
| folders | NSArray | 存储QPFolder类型的数组，具体信息参看3.8.4 |
| error   | NSError | 错误信息                                  |



#### 3.9 歌曲、歌词信息

3.9.1 批量获取歌曲信息(通过Mid)

```
- (void)fetchSongInfoBatchWithMid:(NSArray<QPSongInfo *> *)songs completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;
```

| 入参  | 类型    | 说明                     |
| ----- | ------- | ------------------------ |
| songs | NSArray | 存储QPSongInfo类型的数组 |

| 返回值 | 类型    | 说明                                                  |
| ------ | ------- | ----------------------------------------------------- |
| songs  | NSArray | 存储QPSongInfo类型的数组，具体信息参看3.2.3返回值部分 |
| error  | NSError | 错误信息                                              |



3.9.2 批量获取歌曲信息(通过id)

```
- (void)fetchSongInfoBatchWithId:(NSArray<QPSongInfo *> *)songs completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;
```

| 入参  | 类型    | 说明                    |
| ----- | ------- | ----------------------- |
| songs | NSArray | 有id的songInfo,上限50个 |

| 返回值 | 类型    | 说明                                                  |
| ------ | ------- | ----------------------------------------------------- |
| songs  | NSArray | 存储QPSongInfo类型的数组，具体信息参看3.2.3返回值部分 |
| error  | NSError | 错误信息                                              |



3.9.3 获取新歌推荐

```
- (void)fetchNewSongRecommendWithTag:(NSInteger)tag completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs, NSError * _Nullable error))completion;
```

| 入参 | 类型      | 说明                                          |
| ---- | --------- | --------------------------------------------- |
| tag  | NSInteger | 12：内地；9：韩国；13：港台；3：欧美；8：日本 |

| 返回值 | 类型    | 说明                                                  |
| ------ | ------- | ----------------------------------------------------- |
| songs  | NSArray | 存储QPSongInfo类型的数组，具体信息参看3.2.3返回值部分 |
| error  | NSError | 错误信息                                              |



3.9.4 获取歌曲的歌词(mid)

```
- (void)fetchLyricWithSongMid:(NSString *)songMid completion:(void (^)(NSString *_Nullable lyric, NSError * _Nullable error))completion;
```

| 入参    | 类型     | 说明          |
| ------- | -------- | ------------- |
| songMid | NSString | songInfo的Mid |

| 返回值 | 类型     | 说明     |
| ------ | -------- | -------- |
| lyric  | NSString | 歌词内容 |
| error  | NSError  | 错误信息 |



3.9.4 获取歌曲的歌词(id)

```
- (void)fetchLyricWithSongId:(NSString *)songId completion:(void (^)(NSString *_Nullable lyric, NSError * _Nullable error))completion;
```

| 入参   | 类型     | 说明         |
| ------ | -------- | ------------ |
| songId | NSString | songInfo的id |

| 返回值 | 类型     | 说明     |
| ------ | -------- | -------- |
| lyric  | NSString | 歌词内容 |
| error  | NSError  | 错误信息 |



#### 3.10 最近播放

3.10.1 拉取用户最近播放歌曲列表

```
- (void)fetchRecentPlaySongWithUpdateTime:(NSTimeInterval)updateTime completion:(void (^)(NSArray<QPSongInfo *> *_Nullable songs,NSTimeInterval updateTime, NSError * _Nullable error))completion;
```

| 入参       | 类型           | 说明                                                         |
| ---------- | -------------- | ------------------------------------------------------------ |
| updateTime | NSTimeInterval | 最近更新时间，由接口下发（见返回数据），客户端传入以减少返回数据量，初始可传0 |

| 返回值 | 类型    | 说明                                                  |
| ------ | ------- | ----------------------------------------------------- |
| songs  | NSArray | 存储QPSongInfo类型的数组，具体信息参看3.2.3返回值部分 |
| error  | NSError | 错误信息                                              |



3.10.2 拉取用户最近播放专辑列表

```
- (void)fetchRecentPlayAlbumWithUpdateTime:(NSTimeInterval)updateTime completion:(void (^)(NSArray<QPAlbum *> *_Nullable albums,NSTimeInterval updateTime, NSError * _Nullable error))completion;
```

| 入参       | 类型           | 说明                                                         |
| ---------- | -------------- | ------------------------------------------------------------ |
| updateTime | NSTimeInterval | 最近更新时间，由接口下发（见返回数据），客户端传入以减少返回数据量，初始可传0 |

| 返回值 | 类型    | 说明                                     |
| ------ | ------- | ---------------------------------------- |
| albums | NSArray | 存储QPAlbum类型的数组，具体信息参看3.4.1 |
| error  | NSError | 错误信息                                 |



3.10.3 拉取用户最近播放歌单列表

```
- (void)fetchRecentPlayFolderWithUpdateTime:(NSTimeInterval)updateTime completion:(void (^)(NSArray<QPFolder *> *_Nullable folders,NSTimeInterval updateTime, NSError * _Nullable error))completion;
```

| 入参       | 类型           | 说明                                                         |
| ---------- | -------------- | ------------------------------------------------------------ |
| updateTime | NSTimeInterval | 最近更新时间，由接口下发（见返回数据），客户端传入以减少返回数据量，初始可传0 |

| 返回值  | 类型    | 说明                                      |
| ------- | ------- | ----------------------------------------- |
| folders | NSArray | 存储QPFolder类型的数组，具体信息参看3.8.4 |
| error   | NSError | 错误信息                                  |



## 4. 会员身份

#### 4.1 会员

4.1.1 查询QQ音乐绿钻会员

```
- (void)fetchGreenMemberInformationWithCompletion:(void (^)(QPVipInfo *_Nullable vipInfo, NSError * _Nullable error))completion;
```

| 返回值  | 类型      | 说明                                                         |
| ------- | --------- | ------------------------------------------------------------ |
| vipInfo | QPVipInfo | QPVipInfo信息如下：<br />1:isGreenVIP 绿钻标识，1:是 0:否<br />2:greenvipStartTime 绿钻开通的时间<br />3:greenvipEndTime 绿钻结束时间<br />4:isGreenYearVIP 年费绿钻标识，1:是 0:否 <br />5:isSuperGreenVIP 豪华绿钻 1:是 0:否<br />6:superGreenvipStartTime 豪华绿钻开通的时间<br />7:superGreenvipEndTime 豪华绿钻过期时间<br />8:isEightPaid 8元付费包标志 1:是 0:否<br />9:eightPaidStartTime 8元付费包开通的时间<br />10:eightPaidEndTime 8元付费包过期时间<br />11:isTwelvePaid 12元豪华付费包标志 1:是 0:否<br />12:twelvePaidStartTime 12元付费包开通的时间<br />13:twelvePaidEndTime 12元付费包过期时间 |
| error   | NSError   | 错误信息                                                     |



4.1.2 绿钻订单

```
- (void)createGreenOrderWithMchId:(NSString *)mchId numberOfMonth:(NSInteger)numberOfMonth completion:(void (^)(NSString *_Nullable orderId, NSError * _Nullable error))completion;
```

| 入参          | 类型      | 说明                       |
| ------------- | --------- | -------------------------- |
| mchId         | NSString  | 腾讯音乐会分配一个唯一id   |
| numberOfMonth | NSInteger | 开通服务的时长（按月计算） |

| 返回值  | 类型     | 说明     |
| ------- | -------- | -------- |
| orderId | NSString | 订单ID   |
| error   | NSError  | 错误信息 |



4.1.3 查询绿钻订单状态

```
- (void)queryGreenOrderWithMchId:(NSString *)mchId orderId:(NSString *)orderId completion:(void (^)(QPOrderInfo *_Nullable orderInfo, NSError * _Nullable error))completion;
```

| 入参    | 类型     | 说明                     |
| ------- | -------- | ------------------------ |
| mchId   | NSString | 腾讯音乐会分配一个唯一id |
| orderId | NSString | 订单id                   |

| 返回值    | 类型        | 说明                                                         |
| --------- | ----------- | ------------------------------------------------------------ |
| orderInfo | QPOrderInfo | QPOrderInfo信息如下：<br />1:createTime 订单创建时间<br />2:orderId 订单号<br />3:numberOfMonth 开通服务的月数<br />4:money 消耗账号金<br />5:status 订单状态（1:已发货，2:未发货） |
| error     | NSError     | 错误信息                                                     |



## 5、Skill 音乐意图处理

5.1.1

```
- (void)musicSkillWithIntent:(NSString *)intent slots:(NSDictionary<NSString*,NSString *> *)slots question:(NSString *)question currentSongId:(NSString *_Nullable)currentSongId itemCount:(NSInteger)itemCount completion:(void (^)(NSDictionary *_Nullable data, NSError * _Nullable error))completion;
```

| 入参     | 类型         | 说明                                                         |
| -------- | ------------ | ------------------------------------------------------------ |
| intent   | NSString     | 当前支持四种意图：<br />SearchSong 点歌播放<br />RandomSong 随心听<br />MyFavorite 我的歌单<br />Dislike 不喜欢 |
| slots    | NSDictionary | 支持的key值（后续例子为value值）：<br />Singer 歌手名，比如‘刘德华’、‘周杰伦’<br />TrackType 歌曲类型，比如‘安静’、‘欢快’<br />Track 歌曲名，比如‘忘情水’、‘稻香’<br />Lang 歌曲语言，比如‘中文’、‘英文’<br />Album 专辑，比如‘范特西’、‘十一月的萧邦’<br />Movie 影视剧名，比如‘战狼2’、‘集结号’<br />Toplist 榜单，比如‘热歌榜’、‘billboard’<br />Tvshow 综艺名，比如‘超女’（目前解槽合并到影视剧名里）<br />Version 版本，比如‘live版’、‘演唱会版’<br /> Period 期数，比如‘第二十四期’、‘第一集’<br />Date 年代，比如‘1990’、‘2008’<br />Sort 排序，比如‘最新音乐’、‘播放量最大’、‘最新版’<br />Season 季度，比如‘第一季’、‘第二季’ |
| question | NSString     | 用户的原始请求语句，例如：播放感伤的歌曲                     |



| 返回值 | 类型         | 说明                                    |
| ------ | ------------ | --------------------------------------- |
| data   | NSDictionary | 返回数据，可以只关注其中的play_list字段 |
| error  | NSError      | 错误信息                                |



## 6. 播放器

对外提供以下信息：

1、当前播放列表

2、当前播放序号

3、当前播放歌曲

4、当前歌曲播放状态 （播放、暂停、停止、因为中断被暂停、播放中缓冲）

5、当前歌曲播放时间

6、当前歌曲总时长

7、播放模式 （列表循环、单曲循环、随机播放）

8、播放质量（流畅、标准、高品质、无损）



对外提供以下能力

1、播放

2、暂停

3、停止

4、下一曲

5、上一曲

6、从xx秒开始播放

7、从xx首开始播放

8、播放列表中的歌曲，可以指定从第xx首开始播放

9、清空播放缓存

10、设置当前播放模式 （列表循环、单曲循环、随机播放）

11、设置当前播放质量（流畅、标准、高品质、无损）

## 

