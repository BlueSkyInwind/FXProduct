//
//  CommentDetailViewController.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/20.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "CommentDetailViewController.h"
#import "CommentTableViewCell.h"
#import "CommentInputView.h"
#import "NewsViewModel.h"

@interface CommentDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>{
    NSInteger commentCellHieight;

    NSMutableArray * dataArr;
    float commentInputViewHeight;
    int  pages;
    CommentModel * commentModel;
}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)CommentInputView * commentInputView;
@property (nonatomic,strong)UIView * maskView;
@end

@implementation CommentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"评论列表";
    [self addBackItem];
    pages = 1;
    commentInputViewHeight = 100;
    if (UI_IS_IPHONE6P) {
        commentInputViewHeight = 150;
    }
    dataArr = [_detailModel.rows mutableCopy];
    [self configureView];
    [self setupMJRefreshTableView];
}
-(void)configureView{
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommentTableViewCell"];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailCommentModel * detailCommentM = dataArr[indexPath.row];
    //小编回复
    commentCellHieight = 90;
    if (detailCommentM.Reply) {
        commentCellHieight  += 60;
    }
    //二级评论
    DetailCommentModel * detailCommentM2 = [[DetailCommentModel alloc]initWithDictionary:detailCommentM.lower error:nil];
    if ([detailCommentM2.success integerValue] == 1) {
        commentCellHieight  += 90;
    }
    return commentCellHieight;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CommentTableViewCell"];
    }
    __block DetailCommentModel *detailCommentModel = dataArr[indexPath.row];
    cell.detailCommentModel = dataArr[indexPath.row];
    cell.commentEventClick = ^(UITapGestureRecognizer *tap) {
        [self showCommentView:detailCommentModel.ID];
    };
    cell.spotEventClick = ^(UITapGestureRecognizer *tap) {
        [self requestSpot:detailCommentModel.ID];
    };
    return cell;
}

-(void)requestSpot:(NSString *)commentId{
    NewsViewModel * newViewM = [[NewsViewModel alloc]init];
    [newViewM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            NSString * number = (NSString *)returnMsg.msg;
            if ([number isEqualToString:@"1"]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"点赞成功"];
                
            }else if ([number isEqualToString:@"2"]){
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"取消点赞"];
            }
        }
    } WithFaileBlock:^{
        
    }];
    [newViewM fatchCommentSpotStatus:commentId];
}

#pragma Mark - 输入框视图
-(void)showCommentView:(NSString *)commentId{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = 0.7;
    [[UIApplication sharedApplication].keyWindow addSubview:_maskView];
    
    _commentInputView =  [[NSBundle mainBundle]loadNibNamed:@"CommentInputView" owner:self options:nil].lastObject;
    _commentInputView.frame = CGRectMake(0, _k_h - commentInputViewHeight, _k_w, commentInputViewHeight);
    _commentInputView.contentTextView.delegate =self;
    __weak typeof (self) weakSelf = self;
    _commentInputView.cancelButtonClick = ^(UIButton *button) {
        
        [weakSelf removeCommentView];
    };
    _commentInputView.sureButtonClick = ^(UIButton *button) {

        [weakSelf uploadAccountComment:commentId isFinish:^(BOOL isSuccess) {
            [weakSelf removeCommentView];
        }];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:_commentInputView];
    [_commentInputView.contentTextView  becomeFirstResponder];
}
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 键盘显示\隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 动画
    [UIView animateWithDuration:duration animations:^{
        _commentInputView.frame = CGRectMake(0, frame.origin.y - commentInputViewHeight, _k_w, commentInputViewHeight);
        //        [self.view layoutIfNeeded]; // 自动布局的view改变约束后,需要强制布局
    }];
}
-(void)removeCommentView{
    
    [self.commentInputView endEditing:YES];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        self.commentInputView.frame = CGRectMake(0, _k_h+100, _k_w, 100);
    } completion:^(BOOL finished) {
        [self.commentInputView removeFromSuperview];
        [self.maskView  removeFromSuperview];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    //    NSString * str = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    float height = [Tool heightForText:text width:_k_w - 30 font:14];
    if (height > 60) {
        commentInputViewHeight  = 40 + height;
        _commentInputView.frame = CGRectMake(0, _k_h - commentInputViewHeight, _k_w, commentInputViewHeight);
    }
    return YES;
}

-(void)uploadAccountComment:(NSString *)commentId isFinish:(void(^)(BOOL isSuccess))finish{
    if (self.commentInputView.contentTextView.text.length < 10) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"评论内容最少十个字"];
        return;
    }
    NewsViewModel * newViewM = [[NewsViewModel alloc]init];
    [newViewM setBlockWithReturnBlock:^(id returnValue) {
        ReturnMsgBaseClass * returnMsg = returnValue;
        if ([returnMsg.returnCode intValue] == 1) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"添加评论成功，等待审核"];
            finish(YES);
        }
    } WithFaileBlock:^{
        
    }];
    [newViewM uploadComment:commentId NewID:[NSString stringWithFormat:@"%@",self.detailID] content:self.commentInputView.contentTextView.text commentType:@"8"];
}

#pragma mark ----------设置列表的可刷新性----------
-(void)setupMJRefreshTableView
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    //    header.automaticallyChangeAlpha = YES;
    //    [header beginRefreshing];
    self.tableView.mj_header = header;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    //    header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = footer;
}
-(void)headerRereshing
{
    //以下两种方法
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
    pages = 1;
    [self requestCommentListInfo];
    
}
-(void)footerRereshing
{
    if ([commentModel.Next intValue] == 1) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"以显示全部内容"];
        [self.tableView.mj_footer endRefreshing];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
    });
    pages += 1;
    [self requestCommentListInfo];
}
-(void)requestCommentListInfo{
    NewsViewModel * newsVM = [[NewsViewModel alloc]init];
    [newsVM setBlockWithReturnBlock:^(id returnValue) {
        commentModel  = returnValue;
        if (pages == 1) {
            [dataArr removeAllObjects];
        }
        NSMutableArray * tempArr = [commentModel.rows mutableCopy];
        [dataArr addObjectsFromArray:tempArr];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } WithFaileBlock:^{
        
    }];
    [newsVM fatchCommentListNewsID:[NSString stringWithFormat:@"%@",self.detailID] type:@"8" pageSize:pages numberOfPage:10];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
