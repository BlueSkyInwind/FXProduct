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
#import "ActivityPopView.h"

@protocol  WriteInfoViewDelegate <NSObject>

-(void)submitButtonClick;
-(void)submitImageClick;
-(void)submitVedioClick;


@end

typedef void(^WriteInfoViewHeight)(float height);
typedef void(^ContributeType)(NSInteger type);

@interface WriteInfoView : UIView<AddPhotoImageItemDelegate,AddIamgeViewDelegate,AddImageAndContentViewDelegate,ActivityPopViewDelegate>{
    
    NSMutableArray *  photosArr;
    NSMutableArray *  imageArray;
    
    UIView * maskView;    //背景view
    BOOL isDeletePop;     //是否是删除的弹窗
    NSInteger deleteRow;  // 标识删除的哪一个。
}

@property (weak, nonatomic) IBOutlet UIView *contributeView;

@property (weak, nonatomic) IBOutlet UIView *seletTypeView;

@property (weak, nonatomic) IBOutlet UILabel *typeTitleLabel;


@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@property (weak, nonatomic) IBOutlet XXTextView *contentTextView;

@property (weak, nonatomic) IBOutlet UIView *imageDispalyView;

@property (weak, nonatomic) IBOutlet UIButton *vedioClickBtn;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageDisplayHeight;


@property (assign, nonatomic)NSInteger contributeType;   // 1. 新闻 ,2 , 行摄


@property (assign, nonatomic)id<WriteInfoViewDelegate> delegate;

@property (copy ,nonatomic)WriteInfoViewHeight writeInfoViewHeight;
@property (copy ,nonatomic)ContributeType Type;

@property (nonatomic,strong) AddIamgeView * addImageView;
@property (nonatomic,strong) AddImageAndContentView * addImageAndContentView;
@property (nonatomic,strong) ActivityPopView * activityPopView;

-(void)addUploadImageView:(NSData *)imageData;

-(void)Addbutton:(NSData *)image;

-(void)AddbuttonAndContent:(NSData *)imageData;
-(void)initAddImageView;
-(void)initAddImageAndContentView;
-(void)removeImageDisplaySubView;


@end
