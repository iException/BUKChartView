//
//  BUKViewController.m
//  BUKChartView
//
//  Created by monzy613 on 09/01/2016.
//  Copyright (c) 2016 monzy613. All rights reserved.
//

#import "BUKViewController.h"
#import "BUKChartView.h"

@interface BUKViewController ()

@property (nonatomic, strong) BUKChartView *chartView;

@end

@implementation BUKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.chartView];
}

- (IBAction)resetButtonPressed:(id)sender {
    [self.chartView clearAnimated:YES];
}

- (IBAction)animateButtonPressed:(id)sender {
    [self.chartView setValues:@[
                                [BUKChartItem itemWithDisplayColor:[UIColor yellowColor] percentage:25.0f],
                                [BUKChartItem itemWithDisplayColor:[UIColor blackColor] percentage:30.0f],
                                [BUKChartItem itemWithDisplayColor:[UIColor redColor] percentage:45.0f],
                                ] animated:YES];
}

- (IBAction)resizeButtonPressed:(id)sender {
    CGFloat width = ((CGFloat)rand() / RAND_MAX) * 100.0 + 200.0;
    self.chartView.frame = CGRectMake(0, 0, width, width);
    self.chartView.center = self.view.center;
}

- (IBAction)changeStrokeButtonPressed:(id)sender
{
    CGFloat strokeWidth = ((CGFloat)rand() / RAND_MAX) * 20.0 + 10.0;
    self.chartView.strokeWidth = strokeWidth;
}

- (BUKChartView *)chartView
{
    if (!_chartView) {
        _chartView = [[BUKChartView alloc] initWithFrame:CGRectMake(0, 0, 300.0f, 300.0f)];
        _chartView.center = self.view.center;
        _chartView.strokeWidth = 10.0f;
    }
    return _chartView;
}

@end
