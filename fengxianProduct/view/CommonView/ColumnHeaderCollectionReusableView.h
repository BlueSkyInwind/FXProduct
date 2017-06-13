//
//  ColumnHeaderCollectionReusableView.h
//  fengxianProduct
//
//  Created by admin on 2017/6/13.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColumnHeaderCollectionReusableViewDelegate <NSObject>

-(void)saveEditStatus;
-(void)startEditStatus;
-(void)closeEditStatus;


@end


@interface ColumnHeaderCollectionReusableView : UICollectionReusableView{
    
    BOOL isEditing;

}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeEditBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusBtnRightConstraint;
@property (assign , nonatomic)id<ColumnHeaderCollectionReusableViewDelegate> delegate;


@end
