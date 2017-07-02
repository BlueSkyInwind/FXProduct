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
    self.imageExplainTextField.delegate = self;
    self.imageExplainTextField.layer.borderWidth = 0.5;
    self.imageExplainTextField.layer.borderColor = kUIColorFromRGB(0x5e5e5e).CGColor;
    self.imageExplainTextField.layer.cornerRadius = 2;
    self.imageExplainTextField.clipsToBounds = YES;
    
}
-(void)setAIndex:(NSInteger)aIndex{
    _aIndex = aIndex;
    NSMutableArray * array = [[NSArray arrayWithContentsOfFile:saveIamgePath] mutableCopy];
    if (array && array.count != 0) {
        [self.contentBtn setBackgroundImage:[self obtainImage:aIndex] forState:UIControlStateNormal];
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
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.imageExplainTextField.layer.borderWidth = 2;
    textField.layer.borderColor = [UIColor orangeColor].CGColor;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.imageExplainTextField.layer.borderWidth = 0.5;
    textField.layer.borderColor = kUIColorFromRGB(0x5e5e5e).CGColor;
    
    NSMutableArray * arr1 = [[NSArray arrayWithContentsOfFile:saveIamgeExplainPath]mutableCopy];
    if (!arr1) {
        arr1 = [NSMutableArray arrayWithObjects:@" ",@" ",@" ",@" ",@" ", nil];
    }
    [arr1 replaceObjectAtIndex:_aIndex withObject:textField.text];
    [arr1 writeToFile:saveIamgeExplainPath atomically:YES];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
