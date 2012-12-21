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
        // 在此处设置内容区域的内容.
        
        // contentHeight 的默认值.
        self.contentHeight = 60;
        [[NSBundle mainBundle] loadNibNamed:@"TicketPriceCalloutAnnotationView" owner:self options:nil];
        self.contentView.frame = CGRectMake(10, 15, self.frame.size.width - 20, self.contentHeight);
        //self.contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)setContentHeight:(float)contentHeight
{
    [super setContentHeight:contentHeight];
    // 根据 contentHeight 来调整 contentView 的高度
    self.contentView.frame = CGRectMake(10, 15, self.frame.size.width - 20, self.contentHeight);
}

- (void)setAnnotation:(id<MKAnnotation>)annotation
{
    [super setAnnotation:annotation];
    self.label.text = @"Hello World";
    [self setNeedsDisplay];
}
- (IBAction)calloutButtonClick:(id)sender {
    if ([self.mapView.delegate respondsToSelector:@selector(mapView:annotationView:calloutAccessoryControlTapped:)]) {
        [self.mapView.delegate mapView:self.mapView annotationView:self calloutAccessoryControlTapped:self.accessory];
    }
}
@end
