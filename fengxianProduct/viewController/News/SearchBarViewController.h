//
//  SearchBarViewController.h
//  TMHolterChildProject
//
//  Created by Wangyongxin on 16/6/14.
//  Copyright © 2016年 dk. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SearchResultDelegate <NSObject>

-(void)searchResult:(NSString *)keyStr;

@end

@interface SearchBarViewController : BaseViewController

@end
