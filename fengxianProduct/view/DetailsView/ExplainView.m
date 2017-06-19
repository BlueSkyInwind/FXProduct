//
//  ExplainView.m
//  fengxianProduct
//
//  Created by admin on 2017/6/19.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "ExplainView.h"

@implementation ExplainView

-(void)setPhotoDetailModel:(PhotoDetailModel *)photoDetailModel{
    _photoDetailModel = photoDetailModel;
    self.contentLabel.text = _photoDetailModel.Cont;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
