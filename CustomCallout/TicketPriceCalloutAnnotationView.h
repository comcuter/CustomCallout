//
//  TicketPriceCalloutAnnotationView.h
//  CustomCallout
//
//  Created by admin on 12/19/12.
//  Copyright (c) 2012 iboxpay. All rights reserved.
//

#import "BaseCalloutView.h"

@interface TicketPriceCalloutAnnotationView : BaseCalloutView
// 其所在的 mapView
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *accessory;
- (IBAction)calloutButtonClick:(id)sender;
@end
