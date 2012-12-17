//
//  CMUserCircleView.m
//  CustomCallout
//
//  Created by HaiLee on 12-12-16.
//  Copyright (c) 2012年 iboxpay. All rights reserved.
//

#import "CMMutableCircleView.h"
#import "CMMutableCircle.h"

@implementation CMMutableCircleView

- (void)createPath
{
    CMMutableCircle *userCircle = (CMMutableCircle *)self.overlay;
    MKMapPoint centerPoint = MKMapPointForCoordinate(userCircle.coordinate);
    CGPoint cgCenterPoint = [self pointForMapPoint:centerPoint];
    CGFloat cgRadius = MKMapPointsPerMeterAtLatitude(userCircle.coordinate.latitude) * userCircle.radius;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, cgCenterPoint.x, cgCenterPoint.y, cgRadius, 0, 2 * M_PI, YES);
    
    self.path = path;
    CGPathRelease(path);
}
@end
