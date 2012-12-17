//
//  CMUserCircle.h
//  CustomCallout
//
//  Created by HaiLee on 12-12-16.
//  Copyright (c) 2012年 iboxpay. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface CMMutableCircle : NSObject<MKOverlay>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) CLLocationDistance radius;
@property (nonatomic, readonly) MKMapRect boundingMapRect;
// 更新 Overlay 所需移动的最小距离
@property (nonatomic, assign) CLLocationDistance minimumDeltaMeters;

- (id)initWithCenterCoordinate:(CLLocationCoordinate2D)coordinate radius:(CLLocationDistance)radius;
@end
