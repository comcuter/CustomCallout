//
//  TicketPriceCalloutAnnotation.m
//  CustomCallout
//
//  Created by admin on 12/19/12.
//  Copyright (c) 2012 iboxpay. All rights reserved.
//

#import "TicketPriceCalloutAnnotation.h"

@implementation TicketPriceCalloutAnnotation
- (id)initWithTicketPriceAnnotation:(TicketPriceAnnotation *)annotation
{
    self =[super init];
    if (self) {
        self.basicAnnotation = annotation;
    }
    
    return self;
}

- (void)setBasicAnnotation:(TicketPriceAnnotation *)basicAnnotation
{
    if (_basicAnnotation != basicAnnotation) {
        _basicAnnotation = basicAnnotation;
        self.coordinate = _basicAnnotation.coordinate;
        _basicAnnotation.calloutAnnotation = self;
    }
}
@end
