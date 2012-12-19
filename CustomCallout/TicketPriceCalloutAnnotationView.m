//
//  TicketPriceCalloutAnnotationView.m
//  CustomCallout
//
//  Created by admin on 12/19/12.
//  Copyright (c) 2012 iboxpay. All rights reserved.
//

#import "TicketPriceCalloutAnnotationView.h"

@implementation TicketPriceCalloutAnnotationView
- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImage *bgImage = [UIImage imageNamed:@"bg_controlview"];
        CGRect frame = self.frame;
        frame.size = bgImage.size;
        self.frame = frame;
        NSLog(@"callout view frame:%@", NSStringFromCGRect(self.frame));
        
        self.opaque = NO;
        
        self.centerOffset = CGPointMake(0, -80);
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"bg_controlview"] drawInRect:rect];
}

@end
