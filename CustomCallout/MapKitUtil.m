//
//  NSString+Mapkit.m
//  CustomCallout
//
//  Created by HaiLee on 12-12-16.
//  Copyright (c) 2012年 iboxpay. All rights reserved.
//

#import "MapKitUtil.h"

NSString *NSStringFromCLLocationCoordinate2D(CLLocationCoordinate2D coordinate)
{
    return [NSString stringWithFormat:@"(%f, %f)", coordinate.latitude, coordinate.longitude];
}

@implementation MapKitUtil
@end
