//
//  ShareConfig.h
//  fxdProduct
//
//  Created by dd on 2016/12/13.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareConfig : NSObject


+(ShareConfig *)share;
-(BOOL)isPresentLoginVC:(UIViewController *)vc;

-(void)updateUserData;

+ (void)configDefaultShare;

@end
