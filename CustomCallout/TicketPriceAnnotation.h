//
//  TicketPriceAnnotation.h
//  CustomCallout
//
//  Created by admin on 12/18/12.
//  Copyright (c) 2012 iboxpay. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface TicketPriceAnnotation : MKPointAnnotation
// 票价
@property (nonatomic, assign) double price;
@end
