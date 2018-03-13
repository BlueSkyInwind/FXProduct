//
//  GlobalConfig.h
//  fxdProduct
//
//  Created by dd on 15/8/4.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#ifndef fxdProduct_GlobalConfig_h
#define fxdProduct_GlobalConfig_h


#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif


typedef void(^ReturnValueBlock)(id returnValue);
typedef void(^FaileBlock)();

//十六进制色值
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 设置三原色
#define RGBColor(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#define saveIamgePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"saveIamge.txt"]

#define saveIamgeUrlPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"saveIamgeUrl.txt"]

#define saveIamgeExplainPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"saveIamgeExplain.txt"]


#define _view_width    self.view.frame.size.width
#define _view_height   self.view.frame.size.height
#define _k_w           [UIScreen mainScreen].bounds.size.width
#define _k_h           [UIScreen mainScreen].bounds.size.height
#define _k_WSwitch     [UIScreen mainScreen].bounds.size.width/375.0f

#define UI_IS_IPHONE            ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define UI_IS_IPHONE5           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define UI_IS_IPHONE6           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define UI_IS_IPHONE6P            (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define UI_IS_IPHONE4           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0)
#define UI_IS_IPHONEX           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0)


#define UI_MAIN_COLOR [UIColor colorWithRed:1/255.0 green:122/255.0 blue:179/255.0 alpha:1]

#define BarHeightNew [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height


#define KCharacterNumber @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@."

#define CSM ((CameraHelper *)[CameraHelper shareManager])


UIKIT_EXTERN NSString * const _main_url;

UIKIT_EXTERN NSString * const _AppDownload_url;

UIKIT_EXTERN NSString * const PLATFORM;                 //平台
UIKIT_EXTERN NSString * const Devcode;      //开发码

UIKIT_EXTERN NSString * const FaceIDAppKey; //FaceID
UIKIT_EXTERN NSString * const FaceIDAppSecret;


UIKIT_EXTERN NSString * const GeTuiAppId;
UIKIT_EXTERN NSString * const GeTuiAppKey;
UIKIT_EXTERN NSString * const GeTuiAppSecret;


UIKIT_EXTERN NSString * const UmengKey;


UIKIT_EXTERN NSString * const kUserID;
UIKIT_EXTERN NSString * const kUserPass;

//juid
UIKIT_EXTERN NSString * const FX_AccountID;

//登陆标识
UIKIT_EXTERN NSString * const kLoginFlag;
UIKIT_EXTERN NSString * const FX_CommentTimeInfo;


//用户栏目信息
UIKIT_EXTERN NSString * const FX_ColumnInfo;
UIKIT_EXTERN NSString * const FX_LivesColumnInfo;
UIKIT_EXTERN NSString * const FX_LiveCellHeight;

UIKIT_EXTERN NSString * const FX_ActivtyColumnInfo;

//用户搜索历史
UIKIT_EXTERN NSString * const FX_SearchHistory;
//上传图片数组
UIKIT_EXTERN NSString * const FX_UploadImageArr;

UIKIT_EXTERN NSString * const FX_GuideImageArr;



//邀请码
UIKIT_EXTERN NSString * const kInvitationCode;

UIKIT_EXTERN NSString * const kTopView;

//用户
UIKIT_EXTERN NSString * const UserName;

// 表名
#define userTableName   [Utility sharedUtility].userInfo.userName

//通知
UIKIT_EXTERN NSString * const  kAddMaterailNotification;


UIKIT_EXTERN NSString * const isLoginFlag;

UIKIT_EXTERN NSString * const SERVERNAME;

UIKIT_EXTERN NSString * const UserInfomation;

UIKIT_EXTERN NSString * const FirstLunch;


UIKIT_EXTERN NSString * const theMoxieApiKey;            //魔蝎key

#define MAS_SHORTHAND_GLOBALS

#endif
