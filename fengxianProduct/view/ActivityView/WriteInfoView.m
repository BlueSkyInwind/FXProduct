//
//  WriteInfoView.m
//  fengxianProduct
//
//  Created by admin on 2017/6/15.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "WriteInfoView.h"

@implementation WriteInfoView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
    
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [Tool setCorner:self.contentTextView borderColor:kUIColorFromRGB(0x5e5e5e)];
    [Tool setCorner:self.submitBtn borderColor:UI_MAIN_COLOR];
    [Tool setCorner:self.titleTextField borderColor:UI_MAIN_COLOR];

    self.seletTypeView.layer.cornerRadius = 3;
    self.seletTypeView.layer.masksToBounds = YES;
    self.seletTypeView.layer.borderWidth = 1;
    self.seletTypeView.layer.borderColor = kUIColorFromRGB(0x5e5e5e).CGColor;
    
}
- (IBAction)submitBtnClick:(id)sender {
    
    
}

- (IBAction)selectUploadImageClick:(id)sender {
    
    
    
}
- (IBAction)selectUploadVedioClick:(id)sender {
    
    
    
}

-(void)configureView{
    
    
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
