//
//  DetailButtomView.h
//  fengxianProduct
//
//  Created by admin on 2017/6/19.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

@protocol DetailButtomViewDelegate <NSObject>
- (void)DetailSpotButtonClick;

@end

@interface DetailButtomView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *browseNumView;
@property (weak, nonatomic) IBOutlet UIView *spotNumView;
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;
@property (weak, nonatomic) IBOutlet UILabel *browerNum;

@property (weak, nonatomic) IBOutlet UILabel *spotNum;

@property (nonatomic,strong)NSNumber * detailID;
@property (nonatomic,strong) DetailCommentModel * detailCommentModel;
@property (nonatomic,assign) id<DetailButtomViewDelegate> delegate;

@end
