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


@interface NearbyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) MapViewController *mapViewCtr;
@property(nonatomic,strong) UITableView *tableView;
@end

@implementation NearbyViewController
- (id)init{
    if([super init]){
        self.tabBarItem.title =@"附近";
        self.tabBarItem.image =[UIImage imageNamed:@"ic_search@2x.png"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self initTableView];
    
    UIButton *mapButton = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width/8*3, Screen_Height/22*10, Screen_Width/4, Screen_Height/11)];
    mapButton.backgroundColor = [UIColor blueColor];
    [mapButton setTitle:@"进入地图" forState:UIControlStateNormal];
    [mapButton setTintColor:[UIColor whiteColor]];
    mapButton.titleLabel.font = kFont(15);
    [mapButton.layer setCornerRadius:5];
    [mapButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [mapButton.layer setBorderWidth:1.0];
    [mapButton addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:mapButton];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"附近服务";
}

#pragma mark - 创建UITableView
- (void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
    self.tableView.contentInset = UIEdgeInsetsMake(Screen_Width/16*9 + Screen_Width/5*2 - 10, 0, 0, 0);
    self.tableView.backgroundColor = UIColorWithRGB(240, 240, 240, 1);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    

    [self.view addSubview:_tableView];
}


- (void)button:(UIButton *)button{
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
