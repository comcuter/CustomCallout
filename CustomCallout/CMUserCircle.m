//
//  CMUserCircle.m
//  CustomCallout
//
//  Created by HaiLee on 12-12-16.
//  Copyright (c) 2012年 iboxpay. All rights reserved.
//

#import "CMUserCircle.h"

@implementation CMUserCircle
@synthesize coordinate = _coordinate;
@synthesize radius = _radius;
@synthesize boundingMapRect = _boundingMapRect;
@synthesize minimumDeltaMeters = _minimumDeltaMeters;

// 同一经度上，纬度相差 1 的两个点之间的距离
#define METERS_PER_LATITUDE 111111

- (id)initWithCenterCoordinate:(CLLocationCoordinate2D)coordinate radius:(CLLocationDistance)radius
{
    self = [super init];
    if (self) {
        _coordinate = coordinate;
        _radius = radius;
        _minimumDeltaMeters = 10.0;
        
        [self updateBoundingMapRect];
    }
    return self;
}

- (void)updateBoundingMapRect
{
    // 设置 boundingMapRect
    MKMapPoint centerPoint = MKMapPointForCoordinate(self.coordinate);
    double radiusPoints = MKMapPointsPerMeterAtLatitude(self.coordinate.latitude) * self.radius;
    
    _boundingMapRect = MKMapRectMake(centerPoint.x - radiusPoints, centerPoint.y - radiusPoints, 2 * radiusPoints, 2 * radiusPoints);
    MKMapRect worldRect = MKMapRectMake(0, 0, MKMapSizeWorld.width, MKMapSizeWorld.height);
    _boundingMapRect = MKMapRectIntersection(_boundingMapRect, worldRect);
}

- (void)setCoordinate:(CLLocationCoordinate2D)coordinate
{
    MKMapPoint oldCenter = MKMapPointForCoordinate(_coordinate);
    MKMapPoint newCenter = MKMapPointForCoordinate(coordinate);
    if (MKMetersBetweenMapPoints(oldCenter, newCenter) < self.minimumDeltaMeters) {
        NSLog(@"移动距离比较小，不用更新");
        return;
    }
    
    if (_coordinate.latitude != coordinate.latitude && _coordinate.longitude != coordinate.longitude) {
        _coordinate = coordinate;
        [self updateBoundingMapRect];
    }
}

- (void)setRadius:(CLLocationDistance)radius
{
    if (_radius != radius) {
        _radius = radius;
        [self updateBoundingMapRect];
    }
}
@end
