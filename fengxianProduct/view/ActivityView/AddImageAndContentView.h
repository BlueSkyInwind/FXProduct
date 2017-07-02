//
//  AddImageAndContentView.h
//  fengxianProduct
//
//  Created by admin on 2017/6/23.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddImageAndContentViewDelegate  <NSObject>

-(void)addContentImageAndContentClick;
-(void)DeleteContentImageAndContentClick:(NSInteger)index;

@end


@interface AddImageAndContentView : UIView<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *contentBtn;
@property (weak, nonatomic) IBOutlet UITextField *imageExplainTextField;
@property (weak, nonatomic) IBOutlet UIImageView *deleteImageIcon;
@property (assign, nonatomic)id<AddImageAndContentViewDelegate>  delegate;


@property (assign, nonatomic)BOOL isDelete;
@property (assign,nonatomic)NSInteger aIndex;

@end
