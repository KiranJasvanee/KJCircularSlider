# KJCurveSlider

[![Twitter: @KiranJasvanee](https://img.shields.io/badge/contact-@kiranjasvanee-blue.svg?style=flat)](https://twitter.com/Kiranjasvanee)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/KiranJasvanee/KJCurveSlider/blob/master/LICENSE)
[![Issues](https://img.shields.io/github/issues/KiranJasvanee/KJCurveSlider.svg)](https://github.com/KiranJasvanee/KJCurveSlider/issues)
[![Forks](https://img.shields.io/github/forks/KiranJasvanee/KJCurveSlider.svg)](https://github.com/KiranJasvanee/KJCurveSlider)
[![Stars](https://img.shields.io/github/stars/KiranJasvanee/KJCurveSlider.svg)](https://github.com/KiranJasvanee/KJCurveSlider)
[![Language](https://img.shields.io/badge/Language-Swift-yellow.svg)](https://github.com/KiranJasvanee/KJCurveSlider)


## Preview
Slide your progress through curve!

![KJCurveSlider](Gif/CurveSlider.gif)  

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 3.0.1 or later
- iOS 10.1 or later

## CocoaPods

KJCurveSlider is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "KJCurveSlider"
```

## Usage

KJCurveSlider can be used via code or interface builder. You can add two or more KJCurveSlider's in single view.

* If configuring via code, use the traditional init methods and properties.

* If using Interface Builder, add UIView on your interface builder, add KJCurveSlider in 'Class' at Identity inspector of added UIView.

Use following properties to edit design layout.

```swift 
// declare instance of KJCurveSlider by connecting to UIView outlet at interface builder
@IBOutlet weak var curveSliderLarge: KJCurveSlider!
```

```swift 
// use showPrecision boolean property to allow or not a precisions in percentage value.
curveSliderLarge.showPrecision = true

// use sliderWidth property value to apply width in curve
curveSliderLarge.sliderWidth = 2.0

// use sliderColor property value to apply color in curve
curveSliderLarge.sliderColor = UIColor.black

// use sliderSelectedAreaWidth property value to apply width in selected curved area
curveSliderLarge.sliderSelectedAreaWidth = 10.0

// use sliderSelectedAreaWidth property value to apply color in selected curved area
curveSliderLarge.sliderSelectedAreaColor = UIColor.orange

// use sliderCapColor property value to apply cap color
curveSliderLarge.sliderCapColor = UIColor.green

// use sliderCapColor boolean property value to weather fill or not a cap with cap color
curveSliderLarge.sliderCapFillColor = true

// use KJCurveDelegate, a delegate property to receive processed percentage value by using it's protocol method.
curveSliderLarge.KJCurveDelegate = self
``` 

Method

```swift
// use this protocol method to receive slider values
func getPercentage(curveSliderInstance: KJCurveSlider, percentValue: Float) {
        
        // use your declared instance for comparision, when you want use particular slider values at the time of two or more KJCurveSlider's available in single view.
        // access of specific small slider values
        if curveSliderInstance == curveSliderSmall {
            labelPercentForSmallerCurveSlider.text = "\(percentValue)%"
        }
    }
```

## Author

Kiran Jasvanee, kiran.jasvanee@yahoo.com, Skype: KiranJasvanee

## License

KJCurveSlider is available under the MIT license. See the LICENSE file for more info.
