# FlyingViewsAnimation

## Description
**FlyingViewsAnimation** is a customizable view that will allow you to decorate your iOS application with animation with a continuous stream of flying views distributed randomly throughout the background.

## Usage example in UIKit
Below is an example of the most basic use and customization of FlyingViewsAnimation view.

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let animatedView = AnimatedView()
        animatedView.set(item: { UIImageView(image: UIImage(systemName: "snowflake")) })
        animatedView.set(colors: [.red, .blue,.green])
        animatedView.set(angle: 60)
        animatedView.setItem(size: 10)
        animatedView.frame = self.view.bounds

        self.view.addSubview(animatedView)
        
        animatedView.start()
    }
}
```

To stop the animation and disappear all moving views, call:
```swift
animatedView.stop()
```

## Requirements

iOS 15+, Swift 5.5

## Installation

**FlyingViewsAnimation** is available through CocoaPods. To install it, simply add the following line to your Podfile:
```ruby
pod "FlyingViewsAnimation"
```

## License

**FlyingViewsAnimation** is available under the BSD-3 license. See the LICENSE file for more info.
