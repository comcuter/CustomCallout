//
//  BaseCalloutView.m
//  CustomCallout
//
//  Created by admin on 12/19/12.
//  Copyright (c) 2012 iboxpay. All rights reserved.
//

#import "BaseCalloutView.h"

@implementation BaseCalloutView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // 点击 callout Annotation View 不再弹出 callout.
        self.enabled = NO;
        // 背景色透明
        self.opaque = NO;
        // 设置 centerOffset,调整其到合适的位置
        self.centerOffset = CGPointMake(0, -80);
        
        // 设置 self.frame 的默认值.
        self.contentHeight = 60;
    }
    return self;
}

- (void)setAnnotation:(id<MKAnnotation>)annotation
{
    [super setAnnotation:annotation];
    // 此处可能会根据 annotation 的内容来调整 contentHeight.
    [self setNeedsDisplay];
}

- (void)setContentHeight:(float)contentHeight
{
    if(_contentHeight != contentHeight) {
        _contentHeight = contentHeight;
        // 在这里根据 contentHeight 来调整 self.frame 的高度.
        // 由于这里只是一张图片,故未做调整.
        UIImage *bg_controlView = [UIImage imageNamed:@"bg_controlview"];
        CGRect frame = self.frame;
        frame.size = CGSizeMake(bg_controlView.size.width, bg_controlView.size.height);
        self.frame = frame;
        
        // 然后重新画背景
        [self setNeedsDisplay];
    }
}

// 在此处画背景
- (void)drawRect:(CGRect)rect
{
    NSLog(@"CalloutView drawRect:(CGRect)rect");
    [[UIImage imageNamed:@"bg_controlview"] drawInRect:rect];
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self.superview bringSubviewToFront:self];
}
@end
