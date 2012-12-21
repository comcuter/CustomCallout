//
//  BaseCalloutView.h
//  CustomCallout
//
//  Created by admin on 12/19/12.
//  Copyright (c) 2012 iboxpay. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface BaseCalloutView : MKAnnotationView
// BaseView 根据这个来相应调整背景的高度
@property (nonatomic, assign) float contentHeight;

@end
