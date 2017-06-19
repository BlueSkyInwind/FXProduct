//
//  DetailButtomView.h
//  fengxianProduct
//
//  Created by admin on 2017/6/19.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

@interface DetailButtomView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *browseNumView;
@property (weak, nonatomic) IBOutlet UIView *spotNumView;
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;
@property (weak, nonatomic) IBOutlet UILabel *browerNum;

@property (weak, nonatomic) IBOutlet UILabel *spotNum;

@property (nonatomic,strong) DetailCommentModel * detailCommentModel;

@end
