# BUKChartView

[![CI Status](http://img.shields.io/travis/monzy613/BUKChartView.svg?style=flat)](https://travis-ci.org/monzy613/BUKChartView)
[![Version](https://img.shields.io/cocoapods/v/BUKChartView.svg?style=flat)](http://cocoapods.org/pods/BUKChartView)
[![License](https://img.shields.io/cocoapods/l/BUKChartView.svg?style=flat)](http://cocoapods.org/pods/BUKChartView)
[![Platform](https://img.shields.io/cocoapods/p/BUKChartView.svg?style=flat)](http://cocoapods.org/pods/BUKChartView)

## Example

```objc

// show
BUKChartView *chartView = [BUKChartView new];
chartView.strokeWidth = 10.0f;
chartView.showDuration = 0.5f;
chartView.clearDuration = 0.5f;
NSArray *values = @[
                  [BUKChartItem itemWithDisplayColor:[UIColor yellowColor] percentage:25.0f],
                  [BUKChartItem itemWithDisplayColor:[UIColor blackColor] percentage:30.0f],
                  [BUKChartItem itemWithDisplayColor:[UIColor redColor] percentage:45.0f]
];
[chartView setValues:values animated:YES];

// clear
[chartView clearAnimated:YES];
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## SnapShots
![img](http://o7b20it1b.bkt.clouddn.com/chart.gif)
![img](http://o7b20it1b.bkt.clouddn.com/chart.png)
## Requirements

## Installation

BUKChartView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "BUKChartView"
```

## Author

monzy613, monzy613@gmail.com

## License

BUKChartView is available under the MIT license. See the LICENSE file for more info.

