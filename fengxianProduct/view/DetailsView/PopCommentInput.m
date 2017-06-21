//
//  PopCommentInput.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/21.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "PopCommentInput.h"
#import "NewsViewModel.h"
#import "CommentInputView.h"

@interface PopCommentInput()<UITextViewDelegate>{
    
    float commentInputViewHeight;
    
}

@property (nonatomic,strong)UIView * maskView;
@property (nonatomic,strong)CommentInputView * commentInputView;

@end

@implementation PopCommentInput



static PopCommentInput * popCommentInput = nil;
+(PopCommentInput *)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        popCommentInput = [[PopCommentInput alloc]init];
    });
    return popCommentInput;
}
-(instancetype)init{
    self = [super init];
    if (self) {
       
    }
    return self;
}

-(void)showCommentView{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    commentInputViewHeight = 100;
    if (UI_IS_IPHONE6P) {
        commentInputViewHeight = 150;
    }
    
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
        
        [weakSelf uploadAccountComment:weakSelf.commentId isFinish:^(BOOL isSuccess) {
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



@end
