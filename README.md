# RBSegmentedControl

[![Version](https://img.shields.io/cocoapods/v/RBSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/RBSegmentedControl)
[![License](https://img.shields.io/cocoapods/l/RBSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/RBSegmentedControl)
[![Platform](https://img.shields.io/cocoapods/p/RBSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/RBSegmentedControl)

**RBSegmentedControl** is SubClass of UIView that you can customize the colors. It supppots AutoLayout. So, you can use this on the UIStoryBoards.

## Requirements

- Swift 2.2 / Xcode 7.3
- iOS 8.0 or later (by CocoaPods) / iOS 7 (by copying the source files to your proj directory)

## Installation

RBSegmentedControl is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'RBSegmentedControl'
```

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Sample of simple handling.

```swift
class ViewController: UIViewController, RBSegmentedControlDelegate {
    @IBOutlet weak var segmentedControl: RBSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.addSegments("TITLE1", "TITLE2", "TITLE3")
        segmentedControl.delegate = self
    }
    
    func rb_segmentedControl(didChangedSelectedIndex index: Int) {
        print(index)
    }
}
```

### Basic Functions

- addSegments ... Adding segment titles by variable-length arguments.
- removeSegments ... Removing segments.

### Basic Property of RBSegmentedControl

- selectedSegmentTextColor
- segmentTextColor
- selectedSegmentBackgroundColor
- segmentBackgroundColor
- borderColor

## Author

[rb_de0](https://twitter.com/rb_de0), rebirth.de0@gmail.com

## License

RBSegmentedControl is available under the MIT license. See the LICENSE file for more info.
