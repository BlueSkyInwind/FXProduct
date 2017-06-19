//
//  CommentDetailViewController.m
//  fengxianProduct
//
//  Created by Wangyongxin on 2017/6/20.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "CommentDetailViewController.h"
#import "CommentTableViewCell.h"

@interface CommentDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger commentCellHieight;

    NSMutableArray * dataArr;
}
@property (nonatomic,strong)UITableView * tableView;

@end

@implementation CommentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"新闻详情";
    [self addBackItem];
    commentCellHieight = 90;
    
    dataArr = [_detailModel.rows mutableCopy];
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
    cell.detailCommentModel = dataArr[indexPath.row];
    return cell;
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
