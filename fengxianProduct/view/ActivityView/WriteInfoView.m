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
    [Tool setCorner:self.titleTextField borderColor:kUIColorFromRGB(0x5e5e5e)];

    self.seletTypeView.layer.cornerRadius = 3;
    self.seletTypeView.layer.masksToBounds = YES;
    self.seletTypeView.layer.borderWidth = 0.5;
    self.seletTypeView.layer.borderColor = kUIColorFromRGB(0x5e5e5e).CGColor;
    
    self.addImageView = [[NSBundle mainBundle]loadNibNamed:@"AddIamgeView" owner:self options:nil].lastObject;
    self.addImageView.frame = CGRectMake(10, 5, _k_w * 0.18, _k_w * 0.18);
    [self.addImageView.contentBtn setBackgroundImage:[UIImage imageNamed:@"feedback_image_Icon"] forState:UIControlStateNormal];
    self.addImageView.isDelete = NO;
    self.addImageView.delegate = self;
    photosArr = [NSMutableArray arrayWithCapacity:6];
    imageArray = [NSMutableArray arrayWithCapacity:6];
    [self.imageDispalyView addSubview:self.addImageView];
    
}

- (IBAction)submitBtnClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(submitButtonClick)]) {
        [self.delegate submitButtonClick];
    }
}

- (IBAction)selectUploadVedioClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(submitVedioClick)]) {
        [self.delegate submitVedioClick];
    }    
}

- (void)Addbutton:(NSData *)imageData{
    
    [imageArray addObject:imageData];
    [imageArray writeToFile:saveIamgePath atomically:YES];
    if (photosArr.count == imageArray.count) {
        return;
    }
    CGRect frame = CGRectMake(10, 5, _k_w * 0.18, _k_w * 0.18);
    int n = (int) [imageArray count];
    int row = (n-1) / 3;
    int col = (n-1) % 3;
    
    frame.origin.x = frame.origin.x + frame.size.width * col + 30 * col;
    frame.origin.y = frame.origin.y + (frame.size.height + 10) * row  + 20 * row;
     AddIamgeView * imageItem  = [[NSBundle mainBundle]loadNibNamed:@"AddIamgeView" owner:self options:nil].lastObject;  imageItem.isDelete = YES;
    imageItem.deleteImageIcon.hidden = NO;
    [imageItem setAIndex:n-1];
    
    [imageItem setFrame:frame];
    [imageItem setAlpha:1];
    imageItem.delegate = self;
    
    [photosArr insertObject:imageItem atIndex:n-1];
    
    [self.imageDispalyView addSubview:imageItem];
    imageItem = nil;
    
    //move the add button
    row = n / 3;
    col = n % 3;
    frame = CGRectMake(10, 5, _k_w * 0.18, _k_w * 0.18);
    frame.origin.x = frame.origin.x + frame.size.width * col + 30 * col ;
    frame.origin.y = frame.origin.y + (frame.size.height + 10) * row   + 20 * row;
    NSLog(@"add button col:%d,row:%d",col,row);
    
    if (row == 2 && col == 0) {
        
        self.addImageView.hidden = YES;
    }
    [UIView animateWithDuration:0.2f animations:^{
        [self.addImageView setFrame:frame];
    }];
//    self.addImageView.aIndex += 1;
}
#pragma mark - AddIamgeViewDelegate
-(void)DeleteContentImageClick:(NSInteger)index{
    
    AddIamgeView * item = [photosArr objectAtIndex:index];
    [photosArr removeObjectAtIndex:index];
    NSMutableArray * arr = [[NSArray arrayWithContentsOfFile:saveIamgePath]mutableCopy];
    [arr removeObjectAtIndex:index];
    [arr writeToFile:saveIamgePath atomically:YES];
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect lastFrame = item.frame;
        CGRect curFrame;
        for (int i = (int)index; i < [photosArr count]; i++) {
            AddIamgeView * temp = [photosArr objectAtIndex:i];
            curFrame = temp.frame;
            [temp setFrame:lastFrame];
            lastFrame = curFrame;
            [temp setAIndex:i];
        }
        [self.addImageView setFrame:lastFrame];
        self.addImageView.hidden = NO;
    }];
    [item removeFromSuperview];
    item = nil;
}
-(void)addContentImageClick{
    if ([imageArray count] <= 5) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(submitImageClick)]) {
            [self.delegate submitImageClick];
        }
    }
}
-(void)addContentImageAndContentClick{
    
    
    
    
    
}
-(void)DeleteContentImageAndContentClick:(NSInteger)index{
    
    
    
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
