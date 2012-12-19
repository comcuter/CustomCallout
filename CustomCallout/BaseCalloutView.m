//
//  BaseCalloutView.m
//  CustomCallout
//
//  Created by admin on 12/19/12.
//  Copyright (c) 2012 iboxpay. All rights reserved.
//

#import "BaseCalloutView.h"

@implementation BaseCalloutView

- (void)setAnnotation:(id<MKAnnotation>)annotation
{
    [super setAnnotation:annotation];
    [self setNeedsDisplay];
}
@end
