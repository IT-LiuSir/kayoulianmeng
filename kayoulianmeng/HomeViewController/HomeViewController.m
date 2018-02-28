//
//  HomeViewController.m
//  kayoulianmeng
//
// ***************
//
//      首页板块
//
// ***************
//  Created by 刘岩-MAC on 2018/1/5.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#import "HomeViewController.h"
#import "LY_AFNetworking.h"
#import "SDCycleScrollView.h"
#import "MJRefresh.h"
#import "MJDIYGifHeader.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"
#import "LY_TableViewCell.h"
#import "DetailsViewController.h"

@interface HomeViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSArray *localImages;   //本地图片
@property(nonatomic,strong) NSArray *netImages;     //网络图片
@property(nonatomic,strong) NSMutableDictionary *scroollDictionary; //存放Scroll的json数据
@property(nonatomic,strong) NSMutableDictionary *tableDictionary;   //存放table的json数据
@property(nonatomic,strong) SDCycleScrollView *cycleScrollView; //轮播器
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIView *subView;
@property(nonatomic,strong) UIView *topView;
@property(nonatomic,strong) UIImageView *topImage;
@property(nonatomic,strong) CAGradientLayer *gradientLayer;
@property(nonatomic,strong) DetailsViewController *detailsViewCtr;//跳转的详情界面
@end

@implementation HomeViewController

- (id)init{
    if([super init]){
        self.tabBarItem.title =@"首页";
        self.tabBarItem.image =[UIImage imageNamed:@"tab_home_icon@2x.png"];
        self.subView = [[UIView alloc] initWithFrame:CGRectMake(0, -Screen_Width/16*9 - Screen_Width/5*2 - 10, Screen_Width, Screen_Width/16*9 + Screen_Width/5*2)];
        self.subView.backgroundColor = [UIColor whiteColor];
//        _subView.backgroundColor = [UIColor greenColor];
        
        self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 64)];
        self.topView.backgroundColor = [UIColor clearColor];
        
        CGRect rect = CGRectMake(0,0, Screen_Width, Screen_Width/16*9);
        self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:rect imageNamesGroup:nil];

    }
    return self;
}
// 设置状态栏的颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self ButtonWithTitle:@"新闻" image:@"news@3x.png" row:1 column:1];
    [self ButtonWithTitle:@"视频" image:@"video@3x.png" row:1 column:2];
    [self ButtonWithTitle:@"求助" image:@"sos@3x.png" row:1 column:3];
    [self ButtonWithTitle:@"附近商家" image:@"shop@3x.png" row:1 column:4];
    [self ButtonWithTitle:@"导购" image:@"daogou@3x.png" row:1 column:5];
    [self ButtonWithTitle:@"配件商城" image:@"peijian@3x.png" row:2 column:1];
    [self ButtonWithTitle:@"买挂车" image:@"guache@3x.png" row:2 column:2];
    [self ButtonWithTitle:@"快运贷" image:@"kuaiyundai@3x.png" row:2 column:3];
    [self ButtonWithTitle:@"二手车" image:@"car@3x.png" row:2 column:4];
    [self ButtonWithTitle:@"全部" image:@"all@3x.png" row:2 column:5];
    
    [self initTableView];

    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.backgroundColor = [[UIColor clearColor] CGColor];
    self.gradientLayer.frame = CGRectMake(0, 0, Screen_Width, 64);
    self.gradientLayer.colors = @[(id)UIColorWithRGB(0, 0, 0, 0.7).CGColor,(id)UIColorWithRGB(0, 0, 0, 0).CGColor];
    
    self.topImage = [[UIImageView alloc] initWithFrame:CGRectMake((Screen_Width-105)/2, 25, 105, 30)];
    self.topImage.image = [UIImage imageNamed:@"nav@2x.png"];
    
    [self.topView addSubview:_topImage];
    
    [self.topView.layer addSublayer:_gradientLayer];
    [self.view addSubview:_topView];
    
    [self getData];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - 获取数据
-(void)getData{
    __weak UITableView *tableView = self.tableView;
    NSNumber *num = [NSNumber numberWithInt:1];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:num,@"type", nil];
    [LY_AFNetworking LY_NetworkingForPOST:[NSString stringWithFormat:@"http://www.kayoulianmeng.cn"] parameters:dic success:^(id  _Nonnull json) {
        //将json赋值给_scroollDictionary
        _scroollDictionary = json;

        //清楚缓存
        [SDCycleScrollView clearImagesCache];
        
        //获取数据成功,执行Scroll
        [self ScrollAddInformation:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //获取数据失败
        [self ScrollAddInformation:NO];
    }];
    NSNumber *tablenum = [NSNumber numberWithInt:2];
    NSDictionary *tableDic = [NSDictionary dictionaryWithObjectsAndKeys:tablenum,@"type", nil];
    [LY_AFNetworking LY_NetworkingForPOST:[NSString stringWithFormat:@"http://www.kayoulianmeng.cn"] parameters:tableDic success:^(id  _Nonnull json) {
//        _tableDictionary = json;
        if (json != _tableDictionary) {
            _tableDictionary = json;
            // 刷新表格
            [tableView reloadData];
        }
            // 拿到当前的下拉刷新控件，结束刷新状态
//            [tableView.mj_header endRefreshing];
        
//        NSLog(@"tableView = %@",_tableDictionary);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//加载本地图片数据
- (NSArray *)localImages{
    if (!_localImages) {
        _localImages = @[@"1.png",@"2.png",@"3.png",@"4.png",@"5.png",@"6.png"];
    }
    return _localImages;
}
//加载网络图片数据
- (NSArray *)netImages{
    
    // 获取字典中所有的key值
//    NSLog(@"2222%@",[_scroollDictionary objectForKey:@"data"]);
    _netImages = [_scroollDictionary objectForKey:@"data"];
    
    return _netImages;
}
static const CGFloat MJDuration = 2.0;  //测试刷新用的等待时间，测试后要删除
#pragma mark - 创建UITableView
- (void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
    self.tableView.contentInset = UIEdgeInsetsMake(Screen_Width/16*9 + Screen_Width/5*2 - 10, 0, 0, 0);
    self.tableView.backgroundColor = UIColorWithRGB(240, 240, 240, 1);

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.mj_header = [MJDIYGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    
    [self.tableView addSubview:_subView];
    [self.tableView.mj_header beginRefreshing];
    [self.view addSubview:_tableView];
}
//设置分组个数
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray * arr = [_tableDictionary objectForKey:@"data"];
    if (arr !=nil) {
        return arr.count;
    }else{
        return 5;
    }
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger rowHeight;
    
    NSArray * arr = [_tableDictionary objectForKey:@"data"];
    NSArray *imageurl = [arr[indexPath.row] objectForKey:@"imageurl"];
    
    if ([[arr[indexPath.row] objectForKey:@"type"] isEqualToString:@"article"] && imageurl.count == 3) {
        UILabel *title = [[UILabel alloc] init];
        title.font = [UIFont fontWithName:@"PingFang SC" size:kFontSize(10.6)];
        title.text = [arr[indexPath.row] objectForKey:@"maintitle"];
        title.numberOfLines = 0;
        CGRect frameNew = [title.text boundingRectWithSize:CGSizeMake(Screen_Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:title.font} context:nil];  // 指定为width，通常都是控件的width都是固定调整height
        rowHeight = frameNew.size.height + (Screen_Width-34)/9*2 + Screen_Width*0.0249 + 40;
    }else if([[arr[indexPath.row] objectForKey:@"type"] isEqualToString:@"video"]){
        UILabel *title = [[UILabel alloc] init];
        title.font = [UIFont fontWithName:@"PingFang SC" size:kFontSize(10.6)];
        title.text = [arr[indexPath.row] objectForKey:@"maintitle"];
        CGRect frameNew = [title.text boundingRectWithSize:CGSizeMake(Screen_Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:title.font} context:nil];  // 指定为width，通常都是控件的width都是固定调整height
        rowHeight = frameNew.size.height + (Screen_Width-24)/3*2 + Screen_Width*0.0249 + 40;
    }else{
        rowHeight = Screen_Width*0.147+20;
    }
    NSLog(@"这里是行高");
    
    return rowHeight;
}

//选中cell时触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"table被选中%zd",indexPath.row);
    self.detailsViewCtr = [[DetailsViewController alloc] init];
    self.detailsViewCtr.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:_detailsViewCtr animated:YES];
}

////设置tableViewCell的编辑样式(插入/删除)
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//}
//
////设置当点击编辑按钮时上面显示的文字,如显示删除
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) {
//    return @"删除";
//}

////设置cell移动的位置
//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
//
//}

//设置cell的偏移量
- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
    
    if([tableView respondsToSelector:@selector(setSeparatorInset:)]) {

        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 5,0,0)];

    }

    if([tableView respondsToSelector:@selector(setLayoutMargins:)]) {

        [tableView setLayoutMargins:UIEdgeInsetsMake(0, 0,0,0)];

    }
    
    if([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0,0,0)];
        
    }
}

//创建cell(使用重用机制）
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LY_TableViewCell *cell = [[LY_TableViewCell alloc] init];
    
//    NSLog(@"tableView-----%zd",indexPath.row);
    
    if (_tableDictionary != nil) {
        NSArray *arr= [_tableDictionary objectForKey:@"data"];
        NSArray *imageArray = [arr[indexPath.row]  objectForKey:@"imageurl"];
        NSMutableArray *urlArray = [[NSMutableArray alloc] init];
        NSURL *url;
        
        //用来判断imageurl是否是多个数据，单个保存NSURL，多个保存NSMutableArray
        if (imageArray.count == 1) {
            NSString *str = [NSString stringWithFormat:@"%@", imageArray[0]];
            url = [NSURL URLWithString:str];
        }else{
            for (NSInteger i=0; i<imageArray.count; i++) {
                [urlArray addObject:[NSString stringWithFormat:@"%@",imageArray[i]]];
                NSLog(@"%zd",i);
            }
        }
        
        
        if (indexPath.row == 0) {
            //设置第一个数据为头条
            [cell initCellWithImage:url withTitle:[arr[indexPath.row] objectForKey:@"maintitle"] withClassify:[arr[indexPath.row] objectForKey:@"classify"] withCommentNum:[[arr[indexPath.row] objectForKey:@"comment"] integerValue] isHeadLine:YES];
        }else if([[arr[indexPath.row] objectForKey:@"type"] isEqualToString:@"article"]){
            
            if (imageArray.count == 1) {
                [cell initCellWithImage:url withTitle:[arr[indexPath.row] objectForKey:@"maintitle"] withClassify:[arr[indexPath.row] objectForKey:@"classify"] withCommentNum:[[arr[indexPath.row] objectForKey:@"comment"] integerValue] isHeadLine:NO];
            }else{
                NSLog(@"三个图%zd",indexPath.row);
                [cell initCellWithImageGroup:[urlArray copy] withTitle:[arr[indexPath.row] objectForKey:@"maintitle"] withClassify:[arr[indexPath.row] objectForKey:@"classify"] withCommentNum:[[arr[indexPath.row] objectForKey:@"comment"] integerValue] isHeadLine:NO];
                NSLog(@"array==%@",urlArray);
            }
        }else{
            [cell initCellVideoWithImage:url withTitle:[arr[indexPath.row] objectForKey:@"maintitle"] withClassify:nil withPlayNum:10 withCommentNum:[[arr[indexPath.row] objectForKey:@"comment"] integerValue] isBigView:YES];
            
        }
    }else{
        [cell initCellWithNoData];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//无数据不可点击
    }
    return cell;
}
#pragma mark - 设置顶部导航栏的效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat moveOffset = scrollView.contentOffset.y + Screen_Width/16*9 + Screen_Width/5*2 +10;
//    NSLog(@"scrollView.y = %d",(int)moveOffset);
    
    if ((int)moveOffset < 0) {
        self.topView.backgroundColor = [UIColor clearColor];
        self.gradientLayer.hidden = NO;
        self.topImage.alpha = 0;
        self.topView.alpha = (20+moveOffset)/20;
    }else if((int)moveOffset > 0){

        if ((int)moveOffset <20) {
            self.gradientLayer.colors = @[(id)UIColorWithRGB(0, 0, 0, (20-moveOffset)/28).CGColor,(id)UIColorWithRGB(0, 0, 0, 0).CGColor];
            
        }else{
            self.gradientLayer.colors = @[(id)UIColorWithRGB(0, 0, 0, 0).CGColor,(id)UIColorWithRGB(0, 0, 0, 0).CGColor];
            self.topImage.alpha = 1;
        }
        
        if ((int)moveOffset <64) {
            self.topView.backgroundColor = UIColorWithRGB(0, 100, 255, moveOffset/75);
            self.topImage.alpha = moveOffset/64;
        }else{
            self.topView.backgroundColor = UIColorWithRGB(0, 100, 255, 0.85);
            self.topImage.alpha = 1;
        }
    }else if((int)moveOffset == 0){
        self.gradientLayer.colors = @[(id)UIColorWithRGB(0, 0, 0, 0.7).CGColor,(id)UIColorWithRGB(0, 0, 0, 0).CGColor];
        self.topView.backgroundColor = [UIColor clearColor];
        self.topView.alpha = 1;
        self.gradientLayer.hidden = NO;
        
    }
}

#pragma mark - 下拉刷新数据
- (void)loadNewData{
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SDCycleScrollView clearImagesCache];
        [self getData];
    });
    

    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.tableView.mj_header endRefreshing];
    
}

#pragma mark - 轮播图片
- (void)ScrollAddInformation:(BOOL)isSuccess{
    //设置ScrollView占位图
    [self.cycleScrollView setPlaceholderImage:[UIImage imageNamed:@"PlaceholderImage.png"]];
    
//    NSLog(@"%@",_scroollDictionary);/
    if (isSuccess) {
        NSArray *arr= [_scroollDictionary objectForKey:@"data"];
        NSMutableArray *imageArr = [[NSMutableArray alloc] init];
        NSMutableArray *mainTitleArr = [[NSMutableArray alloc] init];
        NSMutableArray *subTitleArr = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i<arr.count; i++) {
            [imageArr addObject:[NSString stringWithFormat:@"%@", [arr[i] objectForKey:@"imageurl"]]];
            [mainTitleArr addObject:[NSString stringWithFormat:@"%@", [arr[i] objectForKey:@"maintitle"]]];
            [subTitleArr addObject:[NSString stringWithFormat:@"%@", [arr[i] objectForKey:@"subtitle"]]];
            
        }

        
        [self.cycleScrollView setImageURLStringsGroup:[imageArr copy]];
        
        //设置图片视图显示类型
        self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        
        //设置图片轮播时间间隔
        self.cycleScrollView.autoScrollTimeInterval = 5;
        
        //设置轮播视图的分页控件的显示
        self.cycleScrollView.showPageControl = YES;
        
        //设置轮播视图分页控件的位置
        self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        
        //解决ScrollView上不留白问题，automaticallyAdjustsScrollViewInsets，当设置为YES时（默认YES），如果视图里面存在唯一一个UIScrollView或其子类View，那么它会自动设置相应的内边距，这样可以让scroll占据整个视图，又不会让导航栏遮盖。
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        //当前分页控件小圆标颜色
        self.cycleScrollView.currentPageDotColor = [UIColor whiteColor];
        
        //其他分页控件小圆标颜色
        self.cycleScrollView.pageDotColor = [UIColor grayColor];
        
        //监听回调代理
        self.cycleScrollView.delegate = self;
        
        //图片对应的标题
        self.cycleScrollView.mainTitlesGroup = [mainTitleArr copy];
        self.cycleScrollView.subTitlesGroup = [subTitleArr copy];
        
    }else{
        //获取失败加载本地数据，并切提示网络状态不佳
//        NSLog(@"fail");
    }
    
    
    
    [_subView addSubview:self.cycleScrollView];
}

//点击图片回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    NSLog(@"点击图片%zd",index);
    
    self.detailsViewCtr = [[DetailsViewController alloc] init];
    self.detailsViewCtr.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:_detailsViewCtr animated:YES];
    self.detailsViewCtr.navigationItem.title = @"详情";
}

//图片滚动回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
    NSLog(@"图片滚动回调%zd",index);
    
}

#pragma mark - 创建UIButton功能栏
//创建button的方法
- (void)ButtonWithTitle:(NSString*)title image:(NSString*)imageName row:(int)row column:(int)column{
    CGFloat buttonH = Screen_Width/5;
    CGFloat buttonW = Screen_Width/5;
    
    CGFloat imageH = buttonW/2;
    CGFloat imageW = buttonW/2;
    
    CGFloat labelH = buttonH/3;
    CGFloat labelW = Screen_Width/5;
    
    CGFloat buttonX = (column - 1) * buttonW;
    CGFloat buttonY = Screen_Width/16*9 + (row - 1) * buttonW;
    
    
    CGFloat imgaeX ;
    CGFloat imageY ;
    
    CGFloat labelX ;
    CGFloat labelY ;
    
    if (row == 1) {
        imgaeX = (buttonW - imageW)/2;
        imageY = buttonH - imageH - labelH;
        
        labelX = 0;
        labelY = buttonH - labelH;
    }else{
        imgaeX = (buttonW - imageW)/2;
        imageY = buttonH - imageH - labelH-(buttonH - imageH - labelH)/2;
        
        labelX = 0;
        labelY = buttonH - labelH-(buttonH - imageH - labelH)/2;
    }
    
    
    UIButton *button = [[UIButton alloc] init];
    UIImageView *buttonImageView = [[UIImageView alloc] init];
    UILabel *buttonLaber = [[UILabel alloc] init];
//    buttonLaber.textColor = [UIColor blackColor];
    button.backgroundColor = [UIColor whiteColor];
//    buttonLaber.backgroundColor = [UIColor redColor];
    
    button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    //        button.layer.cornerRadius = (buttonHight-50)/2;
    buttonImageView.frame = CGRectMake(imgaeX, imageY, imageW, imageH);
    [buttonImageView setImage:[UIImage imageNamed:imageName]];
    buttonImageView.layer.cornerRadius = buttonImageView.frame.size.width/4;
    buttonImageView.layer.masksToBounds = YES;
    buttonLaber.frame = CGRectMake(labelX, labelY, labelW, labelH);
    buttonLaber.text = title;
    buttonLaber.textAlignment=NSTextAlignmentCenter;
    buttonLaber.font = [UIFont fontWithName:@"PingFang SC" size:kFontSize(8)];
    
    [button addSubview:buttonImageView];
    [button addSubview:buttonLaber];
    [_subView addSubview:button];
    
    button.tag = 10*row+column;
    [button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)button:(UIButton *)button{
//    BuyViewController *buyController = [[BuyViewController alloc]init];

    switch (button.tag) {
        case 11:{
            NSLog(@"11");
            self.detailsViewCtr = [[DetailsViewController alloc] init];
            self.detailsViewCtr.view.backgroundColor = [UIColor whiteColor];
            self.detailsViewCtr.navigationItem.title = @"新闻";
            [self.navigationController pushViewController:_detailsViewCtr animated:YES];
            break;
        }
        case 12:{
            NSLog(@"12");
            self.detailsViewCtr = [[DetailsViewController alloc] init];
            self.detailsViewCtr.view.backgroundColor = [UIColor whiteColor];
            self.detailsViewCtr.navigationItem.title = @"视频";
            [self.navigationController pushViewController:_detailsViewCtr animated:YES];
            break;
        }
        case 13:{
            NSLog(@"13");
            self.detailsViewCtr = [[DetailsViewController alloc] init];
            self.detailsViewCtr.view.backgroundColor = [UIColor whiteColor];
            self.detailsViewCtr.navigationItem.title = @"求助";
            [self.navigationController pushViewController:_detailsViewCtr animated:YES];
            break;
        }
        case 14:{
            NSLog(@"14");
            self.detailsViewCtr = [[DetailsViewController alloc] init];
            self.detailsViewCtr.view.backgroundColor = [UIColor whiteColor];
            self.detailsViewCtr.navigationItem.title = @"附近商家";
            self.detailsViewCtr.urlString =@"https://nearby-api.360che.com";
            [self.navigationController pushViewController:_detailsViewCtr animated:YES];
            break;
        }
        case 15:{
            NSLog(@"15");
            self.detailsViewCtr = [[DetailsViewController alloc] init];
            self.detailsViewCtr.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:_detailsViewCtr animated:YES];
            self.detailsViewCtr.navigationItem.title = @"导购";
            break;
        }
        case 21:{
            NSLog(@"21");
            self.detailsViewCtr = [[DetailsViewController alloc] init];
            self.detailsViewCtr.view.backgroundColor = [UIColor whiteColor];
            self.detailsViewCtr.navigationItem.title = @"配件商城";
            self.detailsViewCtr.urlString = @"https://s.360che.com/Wapshop";
            [self.navigationController pushViewController:_detailsViewCtr animated:YES];

            break;
        }
        case 22:{
            NSLog(@"22");
            self.detailsViewCtr = [[DetailsViewController alloc] init];
            self.detailsViewCtr.view.backgroundColor = [UIColor whiteColor];
            self.detailsViewCtr.navigationItem.title = @"买挂车";
            self.detailsViewCtr.urlString = @"https://gche.360che.com/market/sale/list.aspx";
            [self.navigationController pushViewController:_detailsViewCtr animated:YES];

            break;
        }
        case 23:{
            NSLog(@"23");
            self.detailsViewCtr = [[DetailsViewController alloc] init];
            self.detailsViewCtr.view.backgroundColor = [UIColor whiteColor];
            self.detailsViewCtr.navigationItem.title = @"快运贷";
            self.detailsViewCtr.urlString = @"";
            [self.navigationController pushViewController:_detailsViewCtr animated:YES];
            break;
        }
        case 24:{
            NSLog(@"24");
            self.detailsViewCtr = [[DetailsViewController alloc] init];
            self.detailsViewCtr.view.backgroundColor = [UIColor whiteColor];
            self.detailsViewCtr.navigationItem.title = @"二手车";
            self.detailsViewCtr.urlString = @"https://tao.m.360che.com";
            [self.navigationController pushViewController:_detailsViewCtr animated:YES];
            break;
        }
        case 25:{
            NSLog(@"25");
            self.detailsViewCtr = [[DetailsViewController alloc] init];
            self.detailsViewCtr.view.backgroundColor = [UIColor whiteColor];
            self.detailsViewCtr.navigationItem.title = @"全部";
            [self.navigationController pushViewController:_detailsViewCtr animated:YES];
            break;
        }
    }
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
