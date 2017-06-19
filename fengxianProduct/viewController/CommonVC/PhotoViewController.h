//
//  PhotoViewController.h
//  TMHolterChildProject
//
//  Created by Wangyongxin on 16/7/4.
//  Copyright © 2016年 dk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol deleteDelegate <NSObject>

-(void)delegatePhotoArray:(NSMutableArray *)array;

@end

@interface PhotoViewController : BaseViewController


@property (nonatomic,strong)NSNumber * Species;
@property (nonatomic,strong)NSNumber * detailID;



@property (nonatomic,assign)id<deleteDelegate> delegate;

@end
