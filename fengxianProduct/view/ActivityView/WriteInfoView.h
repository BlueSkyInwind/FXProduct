//
//  WriteInfoView.h
//  fengxianProduct
//
//  Created by admin on 2017/6/15.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXTextView.h"
#import "AddPhotoImageItem.h"
#import "AddIamgeView.h"
#import "AddImageAndContentView.h"
@protocol  WriteInfoViewDelegate <NSObject>

-(void)submitButtonClick;
-(void)submitImageClick;
-(void)submitVedioClick;


@end



@interface WriteInfoView : UIView<AddPhotoImageItemDelegate,AddIamgeViewDelegate,AddImageAndContentViewDelegate>{
    
    NSMutableArray *  photosArr;
    NSMutableArray *  imageArray;

}

@property (weak, nonatomic) IBOutlet UIView *contributeView;

@property (weak, nonatomic) IBOutlet UIView *seletTypeView;

@property (weak, nonatomic) IBOutlet UILabel *typeTitleLabel;


@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@property (weak, nonatomic) IBOutlet XXTextView *contentTextView;

@property (weak, nonatomic) IBOutlet UIView *imageDispalyView;

@property (weak, nonatomic) IBOutlet UIButton *vedioClickBtn;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (assign, nonatomic)id<WriteInfoViewDelegate> delegate;
@property (nonatomic,strong) AddIamgeView * addImageView;


-(void)Addbutton:(NSData *)image;



@end
