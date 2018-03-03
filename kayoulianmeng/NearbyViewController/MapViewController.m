//
//  MapViewController.m
//  kayoulianmeng
//
//  Created by 刘岩-MAC on 2018/3/3.
//  Copyright © 2018年 刘岩-MAC. All rights reserved.
//

#import "MapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController ()
@property(nonatomic,strong) MAMapView *mapView;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    // Do any additional setup after loading the view.
}

//自定义定位精度圈
- (void)customMAUserLocationRepresentation{
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    //精度圈是否显示，默认YES
    r.showsAccuracyRing = YES;
    //是否显示方向指示(MAUserTrackingModeFollowWithHeading模式开启)。默认为YES
    r.showsHeadingIndicator = YES;
    //精度圈 填充颜色, 默认 kAccuracyCircleDefaultColor
    r.fillColor = [UIColor greenColor];
    //精度圈 边线颜色, 默认 kAccuracyCircleDefaultColor
    r.strokeColor = [UIColor redColor];
    //精度圈 边线宽度，默认0
    r.lineWidth = 2;
    //内部蓝色圆点是否使用律动效果, 默认YES
    r.enablePulseAnnimation = YES;
    //定位点背景色，不设置默认白色
    r.locationDotBgColor = [UIColor orangeColor];
    //定位点蓝色圆点颜色，不设置默认蓝色
    r.locationDotFillColor = [UIColor grayColor];
    //定位图标, 与原有精度圈互斥
    //     r.image = [UIImage imageNamed:@"你的图片"];
    //执行自定义精度圈
    //    [self.mapView updateUserLocationRepresentation:r];
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
