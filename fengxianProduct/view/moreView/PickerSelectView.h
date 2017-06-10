//
//  PickerSelectView.h
//  BraHolter
//
//  Created by Wangyongxin on 15/8/10.
//  Copyright (c) 2015年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
//不同类型的pickerView的枚举
typedef NS_ENUM(NSInteger, PickerViewType){
    
    genderPickerView = 0,
    birPickerView = 1,
    heightPickerView = 2,
    weightPickerView = 3,
    agePickerView = 4,
    

};

@protocol PickerselectViewDelegate <NSObject>

-(void)clickCancelButton;
-(void)clicksureButton:(NSString *)context;

@end

@interface PickerSelectView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerSeletV;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIView *ButtonView;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (nonatomic,assign)PickerViewType pickerVT;

@property (nonatomic,assign)id<PickerselectViewDelegate> delegate;

@property (nonatomic,strong)NSString * context;

@property (nonatomic,strong)UIDatePicker * datePicker;


-(void)reloadPickerView;


-(void)configureView:(UIView *)superView pickerViewType:(PickerViewType)pickerViewType delegate:(id<PickerselectViewDelegate>)delegate;

@end
