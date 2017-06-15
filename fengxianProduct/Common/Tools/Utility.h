//
//  Utility.h
//  fxdProduct
//
//  Created by dd on 15/9/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoObj.h"
#import "ColumnModel.h"
#import "NewsListModel.h"
@interface Utility : NSObject


@property (nonatomic,strong) UserInfoObj *userInfo;
@property (nonatomic,assign) BOOL loginFlage;
@property (nonatomic,assign) BOOL networkState;
@property (nonatomic,assign) BOOL isSign;
@property (nonatomic,assign) BOOL isLoadImage;
@property (nonatomic,strong) ColumnModel *columnModel;
@property (nonatomic,strong) ColumnModel *livesColumnModel;
@property (nonatomic,strong) ColumnModel *acticityColumnModel;

//生活页面缓存
@property (nonatomic,strong) NewsListModel *liveListModel;
@property (nonatomic,strong) NewsListModel *cultureListModel;
@property (nonatomic,strong) NewsListModel *shootListModel;
@property (nonatomic,strong) NewsListModel *travelListModel;

//活动页面缓存
@property (nonatomic,strong) NewsListModel *voteListModel;
@property (nonatomic,strong) NewsListModel *answerListModel;
@property (nonatomic,strong) NewsListModel *welfareListModel;


+ (Utility *)sharedUtility;

@end
