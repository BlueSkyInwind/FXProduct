//
//  CommentMessageViewController.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/25.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreBottomDeleteView.h"

@interface CommentMessageViewController : UIViewController

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)MoreBottomDeleteView * moreBottomDeleteV;
@property (nonatomic,assign) BOOL isEdit;


-(void)showBottomDeleteView;
-(void)removeBottomDeleteView;
@end
