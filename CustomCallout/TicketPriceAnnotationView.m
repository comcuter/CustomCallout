//
//  TicketPriceAnnotationView.m
//  CustomCallout
//
//  Created by admin on 12/18/12.
//  Copyright (c) 2012 iboxpay. All rights reserved.
//

#import "TicketPriceAnnotationView.h"
#import "TicketPriceAnnotation.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation TicketPriceAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        // Set frame.
        UIImage *image = [UIImage imageNamed:@"bg_price"];
        CGRect frame = self.frame;
        frame.size = image.size;
        self.frame = frame;
        // 因为图片只是其 frame 的一部分,因此 opaque要设置成 NO;
        self.opaque = NO;
        self.centerOffset = CGPointMake(0, -image.size.height / 2);
    }
    
    return self;
}

- (void)setAnnotation:(id<MKAnnotation>)annotation
{
    [super setAnnotation:annotation];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // 画图片
    [[UIImage imageNamed:@"bg_price"] drawAtPoint:CGPointZero];
    
    // 画文字
    double price = 0;
    if ([self.annotation isKindOfClass:[TicketPriceAnnotation class]]) {
        price = ((TicketPriceAnnotation *)self.annotation).price;
    }
    NSString *rmbSymbol = @"￥";
    NSString *priceString = [NSString stringWithFormat:@"%.0f", price];
    
    [[UIColor whiteColor] set];
    [rmbSymbol drawInRect:CGRectMake(10, 3, 49, 31) withFont:[UIFont systemFontOfSize:15.0]];
    [priceString drawInRect:CGRectMake(23, 3, 49, 31) withFont:[UIFont systemFontOfSize:15.0]];
}
@end
