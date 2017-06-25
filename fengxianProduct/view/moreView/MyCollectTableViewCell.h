//
//  MyCollectTableViewCell.h
//  fengxianProduct
//
//  Created by admin on 2017/6/22.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectModel.h"
typedef void (^SelectedBtn)(NSInteger num ,BOOL isCan);

@interface MyCollectTableViewCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>{
    
    BOOL isCanDelete;
}

@property (weak, nonatomic) IBOutlet UIImageView *titileImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

@property (weak, nonatomic) IBOutlet UIButton *selectedDeleteBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeLabelLeftCons;

@property (nonatomic,strong) NewsListInfo * newsListInfo;
@property (assign,nonatomic)BOOL isDelete;

@property (copy,nonatomic)SelectedBtn selectedBtn;

@end
