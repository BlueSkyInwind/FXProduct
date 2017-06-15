//
//  LivesContentTableViewCell.h
//  fengxianProduct
//
//  Created by admin on 2017/6/14.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MoreButtonClick)(UIButton * button);
@interface ActivityContentTableViewCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *updateListNumLabel;

@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,strong)NSMutableArray * dataArr;

@property (nonatomic,strong)ColumnInfoModel * columnInfoM;

@property (copy,nonatomic)MoreButtonClick moreButtonCilck;
-(void)requestNewsListInfo;

@end
