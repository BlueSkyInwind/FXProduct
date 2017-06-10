//
//  CameraHelper.h
//  BraHolter
//
//  Created by Wangyongxin on 15/8/13.
//  Copyright (c) 2015年 Wangyongxin. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^UserSelectedImage)(UIImage * image,NSData * imageData);

@interface CameraHelper : NSObject<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (nonatomic,strong) NSMutableArray * photos;
@property (nonatomic,weak) UIViewController * controller;
@property (nonatomic,strong)NSString * imageName;
@property (nonatomic,copy)UserSelectedImage seletedImage;

+(CameraHelper *)shareManager;
-(void)obtainController:(UIViewController *)control userSeletedImage:(void(^)(UIImage *userImage, NSData *userImageData))userSeletedImage;
-(void)openCamera;
-(void)openPhotoAblum;
@end
