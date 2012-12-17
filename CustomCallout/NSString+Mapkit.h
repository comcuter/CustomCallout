//
//  NSString+Mapkit.h
//  CustomCallout
//
//  Created by HaiLee on 12-12-16.
//  Copyright (c) 2012年 iboxpay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface NSString (Mapkit)
+ (NSString *)stringFromCLCoordinate:(CLLocationCoordinate2D)coordinate;
@end
