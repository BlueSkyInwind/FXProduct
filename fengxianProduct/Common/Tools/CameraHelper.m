//
//  CameraHelper.m
//  BraHolter
//
//  Created by Wangyongxin on 15/8/13.
//  Copyright (c) 2015年 Wangyongxin. All rights reserved.
//

#import "CameraHelper.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "MoreViewModel.h"
#define IOS8 ([[UIDevice currentDevice].systemVersion intValue] >= 8 ? YES : NO)

#define kCurrentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"currentUser.data"]


@implementation CameraHelper
@synthesize controller;


#pragma mark - 懒加载
- (NSMutableArray *)photos
{
    if (!_photos) {
        self.photos = [NSMutableArray array];
    }
    return _photos;
}

static CameraHelper * cameraHlp;

+(CameraHelper *)shareManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cameraHlp = [[CameraHelper alloc] init];
        
    });
    return cameraHlp;
}

-(void)obtainController:(UIViewController *)control userSeletedImage:(void(^)(UIImage *userImage, NSData *userImageData))userSeletedImage{
    
    controller = control;
    [self showActionSheet:control];
    self.seletedImage = ^(UIImage *image, NSData *imageData) {
        
        userSeletedImage(image,imageData);
        
    };

}
#pragma mark ------- 弹出UIActionSheet------------
-(void)showActionSheet:(UIViewController *)vc{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"头像选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self openCamera];

    }];
    UIAlertAction * libraryAction = [UIAlertAction actionWithTitle:@"相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self openPhotoAblum];

    }];

    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];

    [alertVC addAction:cameraAction];
    [alertVC addAction:libraryAction];
    [alertVC addAction:cancelAction];
    [vc presentViewController:alertVC animated:YES completion:nil];
    
}

#pragma mark ---打开相机与相册
-(void)openCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        if (IOS8) {
            [self alertViewtitle:@"提示" message:@"未开启访问相机权限，现在去开启！" ];
        }
        else{
            [self alertViewtitle:@"提示" message:@"设备不支持访问相机，请在设置->隐私->照片中进行设置！"];
        }

        return;
    }
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
    //        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //    }
    //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
    //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
    //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [controller presentViewController:picker animated:YES completion:nil];//进入照相界面
}
-(void)openPhotoAblum
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) { //判断设备是否支持相册
        
        if (IOS8) {
            [self alertViewtitle:@"提示" message:@"未开启访问相册权限，现在去开启！" ];
        }
        else{
            [self alertViewtitle:@"提示" message:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！"];
        }
        return;
    }
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = YES;
    [controller presentViewController:pickerImage animated:YES completion:nil];
    
}
//点击cancel 调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - image picker delegte
//点击相册中的图片 货照相机照完后点击use  后触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //获取选中图片的名称
    __block NSString * imageFileName;
    
    NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *representation = [myasset defaultRepresentation];
        imageFileName = [representation filename];
        
        if (imageFileName == nil) {
            imageFileName = @"userimage.png";
        }else{
            
            NSRange range = [imageFileName rangeOfString:@"." options:NSBackwardsSearch];
            imageFileName = [imageFileName substringFromIndex:range.location+1];
        }
        self.imageName = imageFileName;
    };
    self.imageName = [self obtainTodayDate];
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:imageURL
     
                   resultBlock:resultblock
     
                  failureBlock:nil];
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self saveImage:image withName:@"avatar.png"];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
//    UIImage * saveImage = [[PathTools shareManager]imageByScalingAndCroppingForSizeOldImage:currentImage];
    NSData * imageData = UIImageJPEGRepresentation(currentImage, 0.2);
    if (self.seletedImage) {
        self.seletedImage(currentImage, imageData);
    }
//    CGFloat num = [[PathTools shareManager]compressionQuality:imageData];
//    
//    if (num != 1) {
//        
//        imageData = UIImageJPEGRepresentation(saveImage, num);
//        
//    }
    [imageData writeToFile:kCurrentPath atomically:YES];
    
}
-(void)alertViewtitle:(NSString *)title message:(NSString *)message{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    [alertVC addAction:cameraAction];
    [alertVC addAction:cancelAction];
    [controller presentViewController:alertVC animated:YES completion:nil];

}
- (NSString *)obtainTodayDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *timeString= [formatter stringFromDate:date];
    return timeString;
}




@end
