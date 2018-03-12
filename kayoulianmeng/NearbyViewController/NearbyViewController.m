//
//  NearbyViewController.m
//  kayoulianmeng
//
//  Created by 刘岩-MAC on 2018/1/7.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#import "NearbyViewController.h"
#import "MapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LY_TableViewCell.h"
#import "LY_CollectionViewCell.h"
#import "DetailsViewController.h"

@interface NearbyViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) DetailsViewController *detailsViewCtr;
@property(nonatomic,strong) MapViewController *mapViewCtr;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableDictionary *mutableDic;
@property(nonatomic,strong) UIView *subView;
@end

@implementation NearbyViewController
- (id)init{
    if([super init]){
        self.tabBarItem.title =@"附近";
        self.tabBarItem.image =[UIImage imageNamed:@"ic_search@2x.png"];
        
        //设置CollectionView数据源
        NSArray *oneImageNameArray = [[NSArray alloc] initWithObjects:@"peijian@3x.png",@"zhuanti@3x.png",@"reyi@3x.png",@"kuaiyundai.png", nil];
        NSArray *oneTitleArray = [[NSArray alloc] initWithObjects:@"超市",@"餐饮",@"洗浴",@"银行", nil];
        NSDictionary *oneSectionDic = [[NSDictionary alloc] initWithObjectsAndKeys:oneImageNameArray,@"imageName1",oneTitleArray,@"title1", nil];
        NSArray *twoImageNameArray = [[NSArray alloc] initWithObjects:@"car@3x.png",@"wuliu@3x.png",@"weixiu@3x.png",@"yangche@3x.png",@"guache@3x.png", nil];
        NSArray *twoTitleArray = [[NSArray alloc] initWithObjects:@"经销商",@"保养",@"维修",@"加油站",@"买挂车" ,nil];
        NSDictionary *twoSectionDic = [[NSDictionary alloc] initWithObjectsAndKeys:twoImageNameArray,@"imageName2",twoTitleArray,@"title2", nil];
        self.mutableDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:oneSectionDic,@"section1",twoSectionDic,@"section2", nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.title = @"附近";
    
//    self.subView  = [[UIView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height/2)];
//    self.subView.backgroundColor = [UIColor grayColor];
//

    [self initCollectionView];
    //在完成collectionView后，获取新的frame.height，并从新赋值，将y值设为-fream.height，使其固定在tableView上
    self.collectionView.frame =CGRectMake(0, -self.collectionView.collectionViewLayout.collectionViewContentSize.height, Screen_Width, self.collectionView.collectionViewLayout.collectionViewContentSize.height);
    
    
    [self initTableView];
    
    UIButton *mapButton = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width/8*3, Screen_Height/22*10, Screen_Width/4, Screen_Height/11)];
    mapButton.backgroundColor = [UIColor blueColor];
    [mapButton setTitle:@"进入地图" forState:UIControlStateNormal];
    [mapButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    mapButton.titleLabel.font = kFont(15);
    [mapButton.layer setCornerRadius:5];
    [mapButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [mapButton.layer setBorderWidth:1.0];
    [mapButton addTarget:self action:@selector(mapButtonDidChange:) forControlEvents:UIControlEventTouchUpInside];
     
//    [self.view addSubview:_subView];
//    [self.tableView addSubview:_subView];
//    [self.view addSubview:mapButton];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    
}

#pragma mark - 创建UITableView
- (void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-44) style:UITableViewStylePlain];
    self.tableView.contentInset = UIEdgeInsetsMake(self.collectionView.collectionViewLayout.collectionViewContentSize.height, 0, 0, 0);
    self.tableView.backgroundColor = UIColorWithRGB(240, 240, 240, 1);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView addSubview:_collectionView];
    [self.view addSubview:_tableView];
}
//设置分组个数
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    NSArray * arr = [_tableDictionary objectForKey:@"data"];
//    if (arr !=nil) {
//        return arr.count;
//    }else{
//        return 5;
//    }
    return 5;
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger rowHeight;
    
//    NSArray * arr = [_tableDictionary objectForKey:@"data"];
//    NSArray *imageurl = [arr[indexPath.row] objectForKey:@"imageurl"];
//
//    if ([[arr[indexPath.row] objectForKey:@"type"] isEqualToString:@"article"] && imageurl.count == 3) {
//        UILabel *title = [[UILabel alloc] init];
//        title.font = [UIFont fontWithName:@"PingFang SC" size:kFontSize(10.6)];
//        title.text = [arr[indexPath.row] objectForKey:@"maintitle"];
//        title.numberOfLines = 0;
//        CGRect frameNew = [title.text boundingRectWithSize:CGSizeMake(Screen_Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:title.font} context:nil];  // 指定为width，通常都是控件的width都是固定调整height
//        rowHeight = frameNew.size.height + (Screen_Width-34)/9*2 + Screen_Width*0.0249 + 40;
//    }else if([[arr[indexPath.row] objectForKey:@"type"] isEqualToString:@"video"]){
//        UILabel *title = [[UILabel alloc] init];
//        title.font = [UIFont fontWithName:@"PingFang SC" size:kFontSize(10.6)];
//        title.text = [arr[indexPath.row] objectForKey:@"maintitle"];
//        CGRect frameNew = [title.text boundingRectWithSize:CGSizeMake(Screen_Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:title.font} context:nil];  // 指定为width，通常都是控件的width都是固定调整height
//        rowHeight = frameNew.size.height + (Screen_Width-24)/3*2 + Screen_Width*0.0249 + 40;
//    }else{
//        rowHeight = Screen_Width*0.147+20;
//    }
//    //    NSLog(@"这里是行高");
    
    return 100;
}

//选中cell时触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"table被选中%zd",indexPath.row);
//    self.detailsViewCtr = [[DetailsViewController alloc] init];
//    self.detailsViewCtr.view.backgroundColor = [UIColor whiteColor];
//    self.detailsViewCtr.type = [[_tableDictionary objectForKey:@"data"][indexPath.row] objectForKey:@"type"];
//    if ([self.detailsViewCtr.type isEqualToString:@"video"]) {
//        self.detailsViewCtr.videoURL = [[_tableDictionary objectForKey:@"data"][indexPath.row] objectForKey:@"videourl"];
//    }
//
//    [self.navigationController pushViewController:_detailsViewCtr animated:YES];
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
    return cell;
}

#pragma mark - 创建CollectionView
- (void)initCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置列间距
    layout.minimumInteritemSpacing = 10;
    //设置行间距
    if(Screen_Width == 414){
        layout.minimumLineSpacing = 0;
    }else{
        layout.minimumLineSpacing = 10;
    }
    //设置每个item的大小
    layout.itemSize =CGSizeMake((Screen_Width-50)/4, (Screen_Width-50)/4);
    //设置item的估计大小，用于动态设置item的大小，结合自动布局
//    layout.estimatedItemSize = CGSizeMake(320, 60);
    //设置布局方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置头视图尺寸大小
    layout.headerReferenceSize = CGSizeMake(Screen_Width, 40);
    //设置尾视图尺寸大小
    layout.footerReferenceSize = CGSizeMake(Screen_Width, 10);
    //设置分区（组）的EdgeInset（四边距）
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //设置分区的头视图和尾视图是否始终固定在上边和下边
    layout.sectionHeadersPinToVisibleBounds = YES;
    layout.sectionFootersPinToVisibleBounds = YES;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[LY_CollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headid"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footid"];
//    [self.view addSubview:self.collectionView];
}

//设置分区数（必须实现）
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 2;
}
//设置每个分区的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray *array1 = [[self.mutableDic valueForKey:@"section1"] valueForKey:@"imageName1"];
    NSArray *array2 = [[self.mutableDic valueForKey:@"section2"] valueForKey:@"imageName2"];
    if (section == 0) {
        return array1.count;
    }else{
        return array2.count;
    }
}

//设置返回每个item的属性必须实现）
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LY_CollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor orangeColor];
    NSLog(@"every Item.section = %ld",indexPath.section);
    NSLog(@"every Item.row = %ld",indexPath.row);
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:[[self.mutableDic valueForKey:@"section1"] valueForKey:@"imageName1"][indexPath.row]];
        cell.label.text = [[self.mutableDic valueForKey:@"section1"] valueForKey:@"title1"][indexPath.row];
    }else{
        cell.imageView.image = [UIImage imageNamed:[[self.mutableDic valueForKey:@"section2"] valueForKey:@"imageName2"][indexPath.row]];
        cell.label.text = [[self.mutableDic valueForKey:@"section2"] valueForKey:@"title2"][indexPath.row];
    }
    
    return cell;
    
}
//对头视图或者尾视图进行设置
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        identifier = @"headid";

    } else {
        identifier = @"footid";

    }
    UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    UIView *hedaview = [[UIView alloc] initWithFrame:CGRectMake(15, 10, 5, 20)];
    hedaview.backgroundColor = UIColorWithRGB(22, 98, 224, 1);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 5, 120, 30)];
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 40, Screen_Width, 0.3f);
    layer.backgroundColor = UIColorWithRGB(211, 211, 211, 1).CGColor;

    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 0) {
            label.text = @"卡友服务";
            label.font = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];

        }else {
            label.text = @"卡车服务";
            label.font = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
        }
        [reusableView addSubview:hedaview];
        [reusableView addSubview:label];
        [reusableView.layer addSublayer:layer];
    }
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) { reusableView.backgroundColor = [UIColor whiteColor];

    } else {
        reusableView.backgroundColor = UIColorWithRGB(240, 240, 240, 1);

    }
    return reusableView;

}
//取消选择点击事件
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
//选择点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.detailsViewCtr = [[DetailsViewController alloc] init];
    self.detailsViewCtr.view.backgroundColor = [UIColor orangeColor];
    LY_CollectionViewCell *cell = (LY_CollectionViewCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"navigation.title = %@",cell.label.text);
    self.detailsViewCtr.navigationItem.title = [NSString stringWithFormat:@"%@", cell.label.text];
    [self.navigationController pushViewController:_detailsViewCtr animated:YES];
    NSLog(@"collection %@ 被选中",indexPath);
}

//是否允许移动Item
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0){
    return YES;
}
//移动Item时触发的方法
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath NS_AVAILABLE_IOS(9_0); {
    
}

- (void)mapButtonDidChange:(UIButton *)button{
    self.mapViewCtr = [[MapViewController alloc] init];
    self.mapViewCtr.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:_mapViewCtr animated:YES];
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
