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
    
    [self.titleTextField setValue:kUIColorFromRGB(0xe5e5e5) forKeyPath:@"_placeholderLabel.textColor"];

    self.seletTypeView.layer.cornerRadius = 3;
    self.seletTypeView.layer.masksToBounds = YES;
    self.seletTypeView.layer.borderWidth = 0.5;
    self.seletTypeView.layer.borderColor = kUIColorFromRGB(0x5e5e5e).CGColor;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seletTypeCilck)];
    [self.seletTypeView addGestureRecognizer:tap];
    _contributeType =1;
    [self initAddImageView];
    
}
-(void)seletTypeCilck{
    isDeletePop = NO;
    [self showActivityPopView:@[@"新闻",@"行摄"]];
}
-(void)initArray{
    
    photosArr = [NSMutableArray arrayWithCapacity:6];
    imageArray = [NSMutableArray arrayWithCapacity:6];
    NSMutableArray * array = [[NSArray arrayWithContentsOfFile:saveIamgePath] mutableCopy];
    if (array && array.count != 0) {
        imageArray = [array mutableCopy];
    }
}

-(void)addUploadImageView:(NSData *)imageData{
    if (_contributeType == 1) {
        [self Addbutton:imageData];
    }else if (_contributeType == 2){
        [self AddbuttonAndContent:imageData];
    }
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
#pragma mark - ImageView

-(void)initAddImageView{
    
    [self initArray];
    
    self.imageDisplayHeight.constant = _k_w * 0.18 ;
    if (self.writeInfoViewHeight) {
        self.writeInfoViewHeight(0);
    }
    
//    if (self.Type) {
//        self.Type(0);
//    }
    
    [self initSelectedAddImageView];
    
    self.addImageView = [[NSBundle mainBundle]loadNibNamed:@"AddIamgeView" owner:self options:nil].lastObject;
    CGRect frame = CGRectMake(5, 5, _k_w * 0.18, _k_w * 0.18);
    frame.origin.x = frame.origin.x + frame.size.width * imageArray.count + 2 * imageArray.count;
    [self.addImageView setFrame:frame];
    CGPoint point = self.addImageView.center;
    point.y = self.imageDispalyView.bounds.size.height / 2;
    self.addImageView.center = point;
    
    [self.addImageView.contentBtn setBackgroundImage:[UIImage imageNamed:@"feedback_image_Icon"] forState:UIControlStateNormal];
    self.addImageView.isDelete = NO;
    self.addImageView.delegate = self;
    [self.imageDispalyView addSubview:self.addImageView];
    
}
-(void)initSelectedAddImageView{
    
    for (int i = 0; i< imageArray.count; i++) {
        AddIamgeView * imageItem = [[NSBundle mainBundle]loadNibNamed:@"AddIamgeView" owner:self options:nil].lastObject;
        CGRect frame = CGRectMake(5, 5, _k_w * 0.18, _k_w * 0.18);
        frame.origin.x = frame.origin.x + frame.size.width * i + 2 * i;
        [imageItem setFrame:frame];
        CGPoint point = imageItem.center;
        point.y = self.imageDispalyView.bounds.size.height / 2;
        imageItem.center = point;
        
        imageItem.isDelete = YES;
        imageItem.deleteImageIcon.hidden = NO;
        imageItem.aIndex = i;
        imageItem.delegate = self;

        [self.imageDispalyView addSubview:imageItem];
        [photosArr insertObject:imageItem atIndex:i];
    }
}

- (void)Addbutton:(NSData *)imageData{
    
    [imageArray addObject:imageData];
    [imageArray writeToFile:saveIamgePath atomically:YES];
    if (photosArr.count == imageArray.count) {
        return;
    }
    CGRect frame = CGRectMake(5, 5, _k_w * 0.18, _k_w * 0.18);
    int n = (int) [imageArray count];
    int row = (n-1) / 5;
    int col = (n-1) % 5;
    
    frame.origin.x = frame.origin.x + frame.size.width * col + 2 * col;
    frame.origin.y = frame.origin.y + (frame.size.height + 2) * row  + 20 * row;
    
     AddIamgeView * imageItem  = [[NSBundle mainBundle]loadNibNamed:@"AddIamgeView" owner:self options:nil].lastObject;  imageItem.isDelete = YES;
    imageItem.deleteImageIcon.hidden = NO;
    [imageItem setAIndex:n-1];
    
    [imageItem setFrame:frame];
    CGPoint point = imageItem.center;
    point.y = self.imageDispalyView.bounds.size.height / 2;
    imageItem.center = point;

    [imageItem setAlpha:1];
    imageItem.delegate = self;
    
    [photosArr insertObject:imageItem atIndex:n-1];
    
    [self.imageDispalyView addSubview:imageItem];
    imageItem = nil;
    
    //move the add button
    row = n / 5;
    col = n % 5;
    frame = CGRectMake(5, 5, _k_w * 0.18, _k_w * 0.18);
    frame.origin.x = frame.origin.x + frame.size.width * col + 2 * col ;
    frame.origin.y = frame.origin.y + (frame.size.height + 2) * row   + 20 * row;
    NSLog(@"add button col:%d,row:%d",col,row);
    
    if (row == 2 && col == 0) {
        
        self.addImageView.hidden = YES;
    }
    [UIView animateWithDuration:0.2f animations:^{
        [self.addImageView setFrame:frame];
        CGPoint point = self.addImageView.center;
        point.y = self.imageDispalyView.bounds.size.height / 2;
        self.addImageView.center = point;
    }];
//    self.addImageView.aIndex += 1;
}
#pragma mark - AddIamgeViewDelegate
-(void)DeleteContentImageClick:(NSInteger)index{
    deleteRow = index;
    isDeletePop = YES;
    [self showActivityPopView:@[@"确定删除",@"取消删除"]];
}
-(void)deleteImageView{
    AddIamgeView * item = [photosArr objectAtIndex:deleteRow];
    [photosArr removeObjectAtIndex:deleteRow];
    [imageArray removeObjectAtIndex:deleteRow];
    NSMutableArray * arr = [[NSArray arrayWithContentsOfFile:saveIamgePath]mutableCopy];
    [arr removeObjectAtIndex:deleteRow];
    [arr writeToFile:saveIamgePath atomically:YES];
    
    NSMutableArray * arr1 = [[NSArray arrayWithContentsOfFile:saveIamgeUrlPath]mutableCopy];
    if (arr1 && arr1.count != 0) {
        [arr1 removeObjectAtIndex:deleteRow];
        [arr1 writeToFile:saveIamgeUrlPath atomically:YES];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect lastFrame = item.frame;
        CGRect curFrame;
        for (int i = (int)deleteRow; i < [photosArr count]; i++) {
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

#pragma mark - ImageAndContentView


-(void)initAddImageAndContentView{
    
    [self initArray];
    
    NSInteger num = imageArray.count < 6 ? imageArray.count : 5;
    self.imageDisplayHeight.constant = (_k_w * 0.18 + 5) * (num +1);
    if (self.writeInfoViewHeight) {
        self.writeInfoViewHeight((_k_w * 0.18 + 5) * num);
    }
    
//    if (self.Type) {
//        self.Type(1);
//    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [self initSelectedAddImageAndContentView];
        
        self.addImageAndContentView = [[NSBundle mainBundle]loadNibNamed:@"AddImageAndContentView" owner:self options:nil].lastObject;
        CGRect frame = CGRectMake(5, 5, CGRectGetWidth(self.imageDispalyView.frame) - 10, _k_w * 0.18);
        self.addImageAndContentView.frame = frame;
        CGPoint point = self.addImageAndContentView.center;
        point.y = (frame.origin.y + frame.size.height) * imageArray.count + (5 + frame.size.height / 2);
        self.addImageAndContentView.center = point;
        
        [self.addImageAndContentView.contentBtn setBackgroundImage:[UIImage imageNamed:@"feedback_image_Icon"] forState:UIControlStateNormal];
        self.addImageAndContentView.isDelete = NO;
        self.addImageAndContentView.delegate = self;
        self.addImageAndContentView.imageExplainTextField.hidden = YES;
        [self.imageDispalyView addSubview:self.addImageAndContentView];
        if (imageArray.count >4) {
            self.addImageAndContentView.hidden = YES;
        }
    }];
        
}
-(void)initSelectedAddImageAndContentView{
    
    for (int i = 0; i< imageArray.count; i++) {
        
        AddImageAndContentView * imageItem = [[NSBundle mainBundle]loadNibNamed:@"AddImageAndContentView" owner:self options:nil].lastObject;
        CGRect frame = CGRectMake(5, 5, CGRectGetWidth(self.imageDispalyView.frame) - 10, _k_w * 0.18);
        imageItem.isDelete = YES;
        imageItem.deleteImageIcon.hidden = NO;
        [imageItem setFrame:frame];

        CGPoint point = imageItem.center;
        point.y = (frame.origin.y + frame.size.height) * i + (5 + frame.size.height / 2);
        imageItem.center = point;
        imageItem.aIndex = i;
        imageItem.delegate = self;

        [self.imageDispalyView addSubview:imageItem];
        [photosArr insertObject:imageItem atIndex:i];
    }
}

- (void)AddbuttonAndContent:(NSData *)imageData{
    
    [imageArray addObject:imageData];
    [imageArray writeToFile:saveIamgePath atomically:YES];
    if (photosArr.count == imageArray.count) {
        return;
    }
    CGRect frame = CGRectMake(5, 5, CGRectGetWidth(self.imageDispalyView.frame) - 10, _k_w * 0.18);
    
    int n = (int) [imageArray count];
    int row = (n-1);
    

    AddImageAndContentView * imageItem  = [[NSBundle mainBundle]loadNibNamed:@"AddImageAndContentView" owner:self options:nil].lastObject;
    imageItem.isDelete = YES;
    imageItem.deleteImageIcon.hidden = NO;
    [imageItem setAIndex:n-1];
    
    [imageItem setFrame:frame];
    
    CGPoint point = imageItem.center;
    point.y = (frame.origin.y + frame.size.height) * row + (5 + frame.size.height / 2);
    imageItem.center = point;
    
    [imageItem setAlpha:1];
    imageItem.delegate = self;
    
    [photosArr insertObject:imageItem atIndex:n-1];
    
    [self.imageDispalyView addSubview:imageItem];
    imageItem = nil;
    
    //move the add button
    row = n ;
    
    NSLog(@"add button row:%d",row);

    [UIView animateWithDuration:0.2f animations:^{
//        [self.addImageAndContentView setFrame:frame];
        self.imageDisplayHeight.constant += _k_w * 0.18 + 8;
        if (self.writeInfoViewHeight) {
            self.writeInfoViewHeight(self.imageDisplayHeight.constant - 60);
        }
        CGPoint point = self.addImageAndContentView.center;
        point.y = (frame.origin.y + frame.size.height) * row + (5 + frame.size.height / 2);
        self.addImageAndContentView.center = point;
    }];
    //    self.addImageView.aIndex += 1;
    if (imageArray.count >4) {
        self.addImageAndContentView.hidden = YES;
    }
}


#pragma mark - AddImageAndContentViewDelegate

-(void)addContentImageAndContentClick{
    
    if ([imageArray count] <= 5) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(submitImageClick)]) {
            [self.delegate submitImageClick];
        }
    }
}

-(void)DeleteContentImageAndContentClick:(NSInteger)index{
    deleteRow = index;
    isDeletePop = YES;
    [self showActivityPopView:@[@"确定删除",@"取消删除"]];
}
-(void)deleteContentImageAndContentView{
    AddImageAndContentView * item = [photosArr objectAtIndex:deleteRow];
    [photosArr removeObjectAtIndex:deleteRow];
    [imageArray removeObjectAtIndex:deleteRow];
    NSMutableArray * arr = [[NSArray arrayWithContentsOfFile:saveIamgePath]mutableCopy];
    [arr removeObjectAtIndex:deleteRow];
    [arr writeToFile:saveIamgePath atomically:YES];
    
    NSMutableArray * arr1 = [[NSArray arrayWithContentsOfFile:saveIamgeUrlPath]mutableCopy];
    [arr1 removeObjectAtIndex:deleteRow];
    [arr1 writeToFile:saveIamgeUrlPath atomically:YES];
    
    NSMutableArray * arr2 = [[NSArray arrayWithContentsOfFile:saveIamgeExplainPath]mutableCopy];
    if (arr2) {
        arr1 = [NSMutableArray arrayWithObjects:@" ",@" ",@" ",@" ",@" ", nil];
    }
    [arr2 replaceObjectAtIndex:deleteRow withObject:@" "];
    [arr2 writeToFile:saveIamgeExplainPath atomically:YES];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.imageDisplayHeight.constant -= _k_w * 0.18;
        if (self.writeInfoViewHeight) {
            self.writeInfoViewHeight(self.imageDisplayHeight.constant - 60);
        }
        CGRect lastFrame = item.frame;
        CGRect curFrame;
        for (int i = (int)deleteRow; i < [photosArr count]; i++) {
            AddImageAndContentView * temp = [photosArr objectAtIndex:i];
            curFrame = temp.frame;
            [temp setFrame:lastFrame];
            lastFrame = curFrame;
            [temp setAIndex:i];
        }
        [self.addImageAndContentView setFrame:lastFrame];
        self.addImageAndContentView.hidden = NO;
    }];
    [item removeFromSuperview];
    item = nil;
}

#pragma mark - ActivityPopView

-(void)showActivityPopView:(NSArray *)array{
    
    maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.7;
    [[UIApplication sharedApplication].keyWindow addSubview:maskView];
    
    _activityPopView =  [[NSBundle mainBundle]loadNibNamed:@"ActivityPopView" owner:self options:nil].lastObject;
    _activityPopView.frame = CGRectMake(0, 0, 150, 100);
    _activityPopView.center = maskView.center;
    _activityPopView.delegate =self;
    _activityPopView.dataArr = [array mutableCopy];
    [[UIApplication sharedApplication].keyWindow addSubview:_activityPopView];
    
}
-(void)removeActivityPopView{
    [maskView removeFromSuperview];
    [_activityPopView removeFromSuperview];
    maskView = nil;
    _activityPopView = nil;
}
-(void)selectedClickCell:(NSInteger)row{
    
    if (isDeletePop) {
        if (row == 0) {
            if (_addImageAndContentView) {
                [self deleteContentImageAndContentView];
            }else if (_addImageView){
                [self deleteImageView];
            }
        }else{
            
        }
    }else{
      
        if (row == 0) {
            //新闻
            _contributeType = 1;
            if (self.addImageAndContentView) {
                [self removeImageDisplaySubView];
                [self initAddImageView];
                self.typeTitleLabel.text = @"新闻";
            }
        }else{
            //行摄
            _contributeType = 2;
            if (self.addImageView) {
                [self removeImageDisplaySubView];
                [self initAddImageAndContentView];
                self.typeTitleLabel.text = @"行摄";
            }
        }
        if (self.Type) {
            self.Type(_contributeType);
        }
    }
    [self removeActivityPopView];
}

-(void)removeImageDisplaySubView{
    for (UIView * view in [self.imageDispalyView  subviews]) {
        [view removeFromSuperview];
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
