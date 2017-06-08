//
//  lhScanQCodeViewController.h
//  lhScanQCodeTest
//
//  Created by bosheng on 15/10/20.
//  Copyright © 2015年 bosheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScanQRCodeResult)(NSString * resultStr);

@interface lhScanQCodeViewController : BaseViewController


@property (nonatomic,copy)ScanQRCodeResult scanQRCodeResult;

@end
