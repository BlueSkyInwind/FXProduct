//
//  PickerSelectView.m
//  BraHolter
//
//  Created by Wangyongxin on 15/8/10.
//  Copyright (c) 2015年 Wangyongxin. All rights reserved.
//
@import UIKit;
#import "PickerSelectView.h"

@implementation PickerSelectView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];

}

- (IBAction)clickCancelButton:(id)sender {
    
    [self.delegate clickCancelButton];
    
}
- (IBAction)clickButton:(id)sender {
  
    if (self.context == nil) {
            return;
        }else{
            [self.delegate clicksureButton:self.context];
        }
}
-(void)configureView:(UIView *)superView pickerViewType:(PickerViewType)pickerViewType delegate:(id<PickerselectViewDelegate>)delegate{
    self.delegate = delegate;
    self.pickerVT = pickerViewType;
    self.pickerSeletV.delegate = self;
    self.pickerSeletV.dataSource = self;
    
    self.pickerSeletV.hidden = NO;
    [self.datePicker removeFromSuperview];

    if (pickerViewType == 0) {
        
        [_pickerSeletV selectRow:2 inComponent:0 animated:NO];
        self.context = @"保密";
        
    } else if(pickerViewType == 1){
        
        [self changeToDatePicker];
        //默認
        NSDate * date = [NSDate date];
        NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];
        [pickerFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [pickerFormatter stringFromDate:date];
        self.context = dateString;
        
    }else if (pickerViewType == 2){
        
        [_pickerSeletV selectRow:30 inComponent:0 animated:NO];
        self.context = @"70cm";
    }else if (pickerViewType == 3){
        
        [_pickerSeletV selectRow:38 inComponent:0 animated:NO];
        self.context = @"40kg";
    }
}
-(void)changeToDatePicker{
    
    self.pickerSeletV.hidden = YES;
    self.datePicker = [[UIDatePicker alloc]init];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.maximumDate = [NSDate date];
    [self.datePicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.datePicker];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[datePicker]-0-|"
                                                                options:0
                                                                metrics:nil
                                                                  views:@{@"datePicker":self.datePicker}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[ButtonView]-0-[datePicker]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"ButtonView":self.ButtonView,@"datePicker":self.datePicker}]];
  
    [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
}
-(void)dateChanged:(id)sender{
    
    UIDatePicker *control = (UIDatePicker*)sender;
    NSDate * date = control.date;
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];
    [pickerFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [pickerFormatter stringFromDate:date];
    
    //打印显示日期时间
    NSLog(@"格式化显示时间：%@",dateString);
    self.context = dateString;
    
}
-(void)reloadPickerView{
    
    [self.pickerSeletV reloadAllComponents];
    
}

#pragma mark --------PickerView delegate------
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    switch (_pickerVT) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        default:
            break;
    }

    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger num = 0;
    switch (_pickerVT) {
        case 1:
            num =  87;
            break;
        case 0:
            num =  3;
            break;
        case 2:
            num =  161;
            break;
        case 3:
            num =  99;
            break;
        default:
            break;
    }
    return num;
}
#pragma mark --------PickerView dataSource------
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString * resultStr;
    switch (_pickerVT) {
        case 1:{
            NSString * str =  [NSString stringWithFormat:@"%ld",(long)row + 13];
            resultStr = str;
        }
            break;
        case 0:{
            switch (row) {
                case 0:
                    resultStr = @"女";
                    break;
                case 1:
                    resultStr = @"男";
                    break;
                case 2:
                    resultStr = @"保密";
                    break;
                default:
                    return @"未知";
                    break;
            }
        }
            break;
        case 2:{
            
            NSString * str =  [NSString stringWithFormat:@"%ldcm",(long)row + 40];
            resultStr = str;
        }
            break;
        case 3:{
            
            NSString * str = [NSString stringWithFormat:@"%ldkg",(long)row + 2];
            if ([str isEqualToString:@"100kg"]) {
                str = [NSString stringWithFormat:@"100kg以上"];
            }
            self.context = str;
            resultStr = str;
        }

        default:
            break;
    }
    return resultStr;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    switch (self.pickerVT) {
        case 0:{
            switch (row) {
                case 0:
                    self.context = @"女";
                    break;
                case 1:
                    self.context =@"男";
                    break;
                case 2:
                    self.context = @"保密";
                    break;
                default:
                    break;
            }
        }            
            break;
        case 1:{
            
            self.context = [NSString stringWithFormat:@"%ld",(long)row + 13];
        }
            break;
        case 2:{
            
            self.context = [NSString stringWithFormat:@"%ldcm",(long)row + 40];
        }
            break;
        case 3:{
            
            NSString * str = [NSString stringWithFormat:@"%ldkg",(long)row + 2];
            if ([str isEqualToString:@"100kg"]) {
                str = [NSString stringWithFormat:@"100kg%@以上"];
            }
            self.context = str;
            
        }
            break;
        default:
            break;
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
