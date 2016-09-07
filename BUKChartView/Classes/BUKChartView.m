//
//  BUKChartView.m
//  ChartView
//
//  Created by Monzy Zhang on 01/09/2016.
//  Copyright © 2016 MonzyZhang. All rights reserved.
//

#import "BUKChartView.h"
@import QuartzCore;

static const CGFloat kFullPercantage = 100.0f;
static const CGFloat kDefaultStrokeWidth = 6.0f;
static const CGFloat kDefaultAnimationDuration = 0.25f;
static NSString *const kClearAnimationLayerKey = @"animationLayer";

@interface BUKChartItem ()

@property (nonatomic, strong) UIColor *displayColor;
@property (nonatomic, assign) CGFloat percentage;

@end

@interface BUKChartView () <CAAnimationDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) NSMutableArray<CAShapeLayer *> *fans;
@property (nonatomic, strong) NSMutableArray<BUKChartItem *> *values;

@end


@implementation BUKChartItem

+ (instancetype)itemWithDisplayColor:(UIColor *)displayColor percentage:(CGFloat)percentage
{
    BUKChartItem *item = [BUKChartItem new];
    item.displayColor = displayColor;
    item.percentage = percentage;
    return item;
}

@end

@implementation BUKChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _strokeWidth = kDefaultStrokeWidth;
        _showDuration = kDefaultAnimationDuration;
        _clearDuration = kDefaultAnimationDuration;
        [self addObserver:self forKeyPath:NSStringFromSelector(@selector(frame)) options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:NSStringFromSelector(@selector(bounds)) options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(frame))];
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(bounds))];
}

#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self && ([keyPath isEqualToString:NSStringFromSelector(@selector(frame))] || [keyPath isEqualToString:NSStringFromSelector(@selector(bounds))])) {
        [self reloadAnimated:NO];
    }
}

#pragma mark - public
- (void)setValues:(NSArray<BUKChartItem *> *)values animated:(BOOL)animated
{
    // clear
    [self.values removeAllObjects];
    for (CAShapeLayer *fan in self.fans) {
        [fan removeFromSuperlayer];
    }
    [self.fans removeAllObjects];

    // add
    CGFloat sum = 0.0;
    for (BUKChartItem *value in values) {
        CAShapeLayer *fan = [self fanWithStartPercent:sum percentage:value.percentage displayColor:value.displayColor animated:animated];
        [self.layer addSublayer:fan];
        [self.fans addObject:fan];
        [self.values addObject:value];
        sum += value.percentage;
    }
}

- (void)reloadAnimated:(BOOL)animated
{
    NSArray *values = [self.values copy];
    [self clearAnimated:NO];
    [self setValues:values animated:animated];
}

- (void)clearAnimated:(BOOL)animated
{
    [self.fans enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull fan, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!animated) {
            [fan removeFromSuperlayer];
            return;
        }
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
        pathAnimation.duration = self.clearDuration;
        pathAnimation.fromValue = @(1.0f);
        pathAnimation.toValue = @(0.0f);
        pathAnimation.delegate = self;
        [pathAnimation setValue:fan forKey:kClearAnimationLayerKey];
        fan.strokeEnd = 0.0;
        [fan addAnimation:pathAnimation forKey:NSStringFromSelector(@selector(strokeEnd))];
    }];
    if (!animated) {
        [self.fans removeAllObjects];
    }
    [self.values removeAllObjects];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CAShapeLayer *layer = [anim valueForKey:kClearAnimationLayerKey];
    if (layer) {
        [layer removeFromSuperlayer];
        [self.fans removeObject:layer];
    }
}

#pragma mark - private
- (CAShapeLayer *)fanWithStartPercent:(CGFloat)startPercent percentage:(CGFloat)percentage displayColor:(UIColor *)displayColor animated:(BOOL)animated
{
    CAShapeLayer *fan = [CAShapeLayer layer];
    fan.frame = self.bounds;
    fan.fillColor = [UIColor clearColor].CGColor;
    fan.strokeColor = displayColor.CGColor;
    fan.lineWidth = self.strokeWidth;

    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat startAngle = [self angleFromPercentage:startPercent];
    CGFloat endAngle = [self angleFromPercentage:(startPercent + percentage)];
    CGFloat radius = (CGRectGetWidth(self.bounds) - self.strokeWidth) / 2.0;

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];

    fan.path = path.CGPath;

    if (animated) {
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
        pathAnimation.duration = self.showDuration;
        pathAnimation.fromValue = @(0.0f);
        pathAnimation.toValue = @(1.0f);
        [fan addAnimation:pathAnimation forKey:NSStringFromSelector(@selector(strokeEnd))];
    }

    return fan;
}

- (CGFloat)angleFromPercentage:(CGFloat)percentage
{
    return percentage * M_PI * 2.0 / kFullPercantage - M_PI_2;
}

#pragma mark - setters
- (void)setStrokeWidth:(CGFloat)strokeWidth
{
    _strokeWidth = strokeWidth;
    [self reloadAnimated:NO];
}

#pragma mark - getter
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
    }
    return _detailLabel;
}

- (NSMutableArray<CAShapeLayer *> *)fans
{
    if (!_fans) {
        _fans = [NSMutableArray new];
    }
    return _fans;
}

- (NSMutableArray<BUKChartItem *> *)values
{
    if (!_values) {
        _values = [NSMutableArray new];
    }
    return _values;
}
@end
