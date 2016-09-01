//
//  BUKChartView.h
//  ChartView
//
//  Created by Monzy Zhang on 01/09/2016.
//  Copyright © 2016 MonzyZhang. All rights reserved.
//

@import UIKit;

@interface BUKChartItem: NSObject

@property (nonatomic, strong, readonly) UIColor *displayColor;
@property (nonatomic, assign, readonly) CGFloat percentage;

+ (instancetype)itemWithDisplayColor:(UIColor *)displayColor percentage:(CGFloat)percentage;

@end

@interface BUKChartView : UIView

@property (nonatomic, assign) CGFloat strokeWidth;
@property (nonatomic, assign) NSTimeInterval showDuration;
@property (nonatomic, assign) NSTimeInterval clearDuration;

/*
 * all values's sum should be equal to 100.0
 */
- (void)setValues:(NSArray<BUKChartItem *> *)values animated:(BOOL)animated;

- (void)clearAnimated:(BOOL)animated;

@end
