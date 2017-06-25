//
//  ActivityPopView.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/25.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActivityPopViewDelegate <NSObject>

-(void)selectedClickCell:(NSInteger)row;

@end


@interface ActivityPopView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *contentTableView;


@property (nonatomic,strong)NSMutableArray * dataArr;

@property (nonatomic,assign)id<ActivityPopViewDelegate> delegate;


@end
