//
//  ViewController.m
//  CustomCallout
//
//  Created by admin on 12/14/12.
//  Copyright (c) 2012 iboxpay. All rights reserved.
//

#import "ViewController.h"
#import "CMMutableCircle.h"
#import "CMMutableCircleView.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>

@interface ViewController ()<MKMapViewDelegate, CLLocationManagerDelegate, NSURLConnectionDataDelegate>
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) CMMutableCircle *userCircle;
@property (nonatomic, strong) CMMutableCircleView *userCircleView;

@property (nonatomic, strong) NSMutableData *reverseGeoData;
@end

#define USERCIRCLE_RADIUS 1000

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    
    // 定位到深圳
    CLLocationCoordinate2D shenZhenCoordinate = CLLocationCoordinate2DMake(22.545136, 113.962273);
    self.mapView.centerCoordinate = shenZhenCoordinate;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMake(shenZhenCoordinate, MKCoordinateSpanMake(0.03, 0.03));
    self.mapView.region = [self.mapView regionThatFits:viewRegion];
    
    // 添加几个点
    CLLocationCoordinate2D coordinates[] = {CLLocationCoordinate2DMake(22.548234, 113.939745),
                                            CLLocationCoordinate2DMake(22.544487, 113.945668),
                                            CLLocationCoordinate2DMake(22.524781, 113.94386)};
    NSMutableArray *annotations = [NSMutableArray array];
    for (int i = 0; i < sizeof(coordinates) / sizeof(coordinates[0]); i++) {
        MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
        pointAnnotation.coordinate = coordinates[i];
        [annotations addObject:pointAnnotation];
    }
    [self.mapView addAnnotations:annotations];
    
    self.mapView.showsUserLocation = YES;
    
    // 初始化 CoreLocationManager.
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"可以进行定位");
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        [self.locationManager startUpdatingLocation];
    }
}

#pragma mark -
#pragma mark MapViewDelegate
#pragma mark -
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[CMMutableCircle class]]) {
        if (self.userCircleView == nil) {
            self.userCircleView = [[CMMutableCircleView alloc] initWithOverlay:overlay];
            self.userCircleView.lineWidth = 2;
            self.userCircleView.strokeColor = [UIColor blueColor];
            self.userCircleView.fillColor = [UIColor orangeColor];
            self.userCircleView.alpha = 0.3;
        }
        return self.userCircleView;
    }
    return nil;
}

// 如果只使用用户位置的话,可以用这种方法解决偏移问题,但是 mapView 更新 userLocation 的速度比较慢.
// 如果要使用 LocationManager 精度要求较高,就得自己纠偏了.
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    // 用户位置更新时,更新Overlay
    CLLocation *latestLocation = userLocation.location;
    NSLog(@"用户移动到了 %@", [NSString stringFromCLCoordinate:latestLocation.coordinate]);
    
    // 如果是第一次更新位置,则创建一个overlay
    if (self.userCircle == nil) {
        self.userCircle = [[CMMutableCircle alloc] initWithCenterCoordinate:latestLocation.coordinate radius:USERCIRCLE_RADIUS];
        [self.mapView addOverlay:self.userCircle];
    }
    self.userCircle.coordinate = latestLocation.coordinate;
    [self.userCircleView invalidatePath];
}

#pragma mark -
#pragma mark LocationManagerDelegate
#pragma mark -
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // 这里是演示locationManager怎么用.如果想要无偏移,应该将这部分也放到 mapView:didUpdateUserLocation: 里.
    CLLocation *latestLocation = self.mapView.userLocation.location;
    // 定位所在城市
    [self locateUserCity:latestLocation];
}

// 确定用户位置
- (void)locateUserCity:(CLLocation *)location
{
    // 第一种方式
    // 使用 CLGeocoder 的话,会根据用户设置的 Local 的不同,返回不同的字符串,因此并不可靠.
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placeMarks, NSError *error){
        if (error != nil) {
            NSLog(@"不能反地理编码%@, error:%@",[NSString stringFromCLCoordinate:location.coordinate], [error localizedDescription]);
            return;
        }
        
        // CLPlacemark *placeMark = [placeMarks lastObject];
        // NSLog(@"定位到了 %@ 省, %@ 市, %@ 区, %@ 路, %@ 号", placeMark.administrativeArea, placeMark.locality, placeMark.subLocality, placeMark.thoroughfare, placeMark.subThoroughfare);
        
        //        NSDictionary *addressDic = placeMark.addressDictionary;
        //        NSLog(@"定位到了 %@ 省, %@ 市, %@ 路", [addressDic objectForKey:(NSString *)kABPersonAddressStateKey],
        //              [addressDic objectForKey:(NSString *)kABPersonAddressCityKey], [addressDic objectForKey:(NSString *)kABPersonAddressStreetKey]);
    }];
    
    // 第二种方式
    // 通过百度的 reverseGeocode Web API 来进行
#define BAIDU_MAP_KEY @"1867400960779E7D273503F1383B6DDC20040E83"
    NSString *requestURL= [NSString stringWithFormat:@"http://api.map.baidu.com/geocoder?location=%f,%f&output=json&key=%@",
                           location.coordinate.latitude, location.coordinate.longitude, BAIDU_MAP_KEY];
    NSURLRequest *urlRequest= [NSURLRequest requestWithURL:[NSURL URLWithString:requestURL] cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:60];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    NSLog(@"新的朝向 trueHeading:%f, magneticHeading:%f", newHeading.trueHeading, newHeading.magneticHeading);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位时出错");
    if (error.code == kCLErrorDenied) {
        NSLog(@"用户拒绝定位");
        // 这时就不要再更新位置了
        [self.locationManager stopUpdatingLocation];
    } else if (error.code == kCLErrorLocationUnknown) {
        NSLog(@"找不到用户位置");
    }
}

#pragma mark -
#pragma mark NSURLConnectionDataDelegate
#pragma mark -
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.reverseGeoData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"接收到数据");
    [self.reverseGeoData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"请求完毕");
    NSError *error = nil;
    NSDictionary *reverseDic = [NSJSONSerialization JSONObjectWithData:self.reverseGeoData options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"收到的数据不是JSON数据");
        return;
    }
    
    NSString *resultStatus = [reverseDic objectForKey:@"status"];
    if (![resultStatus isEqualToString:@"OK"]) {
        NSLog(@"请求失败,状态码:%@", resultStatus);
        return;
    }
    
    NSString *cityName = [reverseDic valueForKeyPath:@"result.addressComponent.city"];
    NSLog(@"用户所在城市: %@", cityName);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"请求失败 %@", [error localizedDescription]);
}

#pragma mark -
- (void)viewWillDisappear:(BOOL)animated
{
    // 在适当的地方停止更新.
    [self.locationManager stopUpdatingLocation];
    [self.locationManager stopUpdatingHeading];
}
@end
