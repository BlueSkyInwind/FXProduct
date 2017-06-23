//
//  AddImageAndContentView.m
//  fengxianProduct
//
//  Created by admin on 2017/6/23.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "AddImageAndContentView.h"

@implementation AddImageAndContentView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.deleteImageIcon.hidden = YES;
}
-(void)setAIndex:(NSInteger)aIndex{
    _aIndex = aIndex;
    NSMutableArray * array = [[NSArray arrayWithContentsOfFile:saveIamgePath] mutableCopy];
    if (array && array.count != 0) {
        [self.contentBtn setBackgroundImage:[self obtainImage:array.count - 1] forState:UIControlStateNormal];
    }
}

-(UIImage *)obtainImage:(NSInteger)num{
    NSMutableArray * array = [[NSArray arrayWithContentsOfFile:saveIamgePath] mutableCopy];
    NSData *imageData = array[num];
    UIImage * saveImage = [[UIImage alloc]initWithData:imageData];
    return saveImage;
}


- (IBAction)contentBtnClick:(id)sender {
    if (_isDelete) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(DeleteContentImageAndContentClick:)]) {
            [self.delegate DeleteContentImageAndContentClick:_aIndex];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(addContentImageAndContentClick)]) {
            [self.delegate addContentImageAndContentClick];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
