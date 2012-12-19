//
//  TicketPriceCalloutAnnotation.h
//  CustomCallout
//
//  Created by admin on 12/19/12.
//  Copyright (c) 2012 iboxpay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TicketPriceAnnotation.h"

@interface TicketPriceCalloutAnnotation : MKPointAnnotation
// 保存其需要的基本信息.
@property (nonatomic, strong) TicketPriceAnnotation *basicAnnotation;

- (id)initWithTicketPriceAnnotation:(TicketPriceAnnotation *)annotation;
@end
