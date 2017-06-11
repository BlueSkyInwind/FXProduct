//
//  NewsListModel.h
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/11.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol NewsListInfo

@end

@interface NewsListInfo : JSONModel

//{"ID":3969,"Seat":2,"Source":"经济日报","Auther":"吴凯、李治国","Title":"上海奉贤“锁定”重点行业和领域，引领传统产业升级","Introduce":"","Species":1,"Image1":"http://infx2.echaokj.cn/Download/sompany/cut/test636325979368202982.jpg","Type":0,"PLNum":0,"Num":258,"Column":"","Time":"2017-06-09 09:00:00"}

@property (nonatomic,strong)NSNumber<Optional> * ID;
@property (nonatomic,strong)NSNumber<Optional> * Seat;
@property (nonatomic,strong)NSString<Optional> * Source;
@property (nonatomic,strong)NSString<Optional> * Auther;
@property (nonatomic,strong)NSString<Optional> * Title;
@property (nonatomic,strong)NSString<Optional> * Introduce;
@property (nonatomic,strong)NSNumber<Optional> * Species;
@property (nonatomic,strong)NSString<Optional> * Image1;
@property (nonatomic,strong)NSString<Optional> * Image2;
@property (nonatomic,strong)NSString<Optional> * Image3;
@property (nonatomic,strong)NSNumber<Optional> * Type;
@property (nonatomic,strong)NSNumber<Optional> * PLNum;
@property (nonatomic,strong)NSNumber<Optional> * Num;
@property (nonatomic,strong)NSString<Optional> * Column;
@property (nonatomic,strong)NSString<Optional> * Time;

@end

@interface NewsListModel : JSONModel

@property (nonatomic,strong)NSNumber * Next;
@property (nonatomic,strong)NSArray<NewsListInfo> * rows;
//@property (nonatomic,strong)NSArray * rows;


@end

