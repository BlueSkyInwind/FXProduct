//
//  MyIntegralHeaderCollectionViewCell.m
//  fengxianProduct
//
//  Created by admin on 2017/6/16.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "MyIntegralHeaderCollectionViewCell.h"

@implementation MyIntegralHeaderCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     [Tool setCorner:self.integralDetailView borderColor:UI_MAIN_COLOR cornerRadius:2];
     [Tool setCorner:self.integralConvertView borderColor:UI_MAIN_COLOR cornerRadius:2];
    
    UITapGestureRecognizer * detailTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(integralDetailTap)];
    [self.integralDetailView addGestureRecognizer:detailTap];
    
    UITapGestureRecognizer * convertTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(convertDetailTap)];
    [self.integralConvertView addGestureRecognizer:convertTap];

}

-(void)integralDetailTap{
    
    
    
    
}
-(void)convertDetailTap{
    
    
    
    
}





@end
