//
//  AddIamgeView.h
//  fengxianProduct
//
//  Created by admin on 2017/6/23.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddIamgeViewDelegate  <NSObject>

-(void)addContentImageClick;
-(void)DeleteContentImageClick:(NSInteger)index;

@end


@interface AddIamgeView : UIView
@property (weak, nonatomic) IBOutlet UIButton *contentBtn;


@property (weak, nonatomic) IBOutlet UIImageView *deleteImageIcon;
@property (assign, nonatomic)id<AddIamgeViewDelegate>  delegate;

@property (assign, nonatomic)BOOL isDelete;
@property (assign,nonatomic)NSInteger aIndex;

@end
