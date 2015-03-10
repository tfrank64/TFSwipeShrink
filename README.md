[![Build Status](https://travis-ci.org/tfrank64/TFSwipeShrink.svg?branch=v0.1-alpha)](https://travis-ci.org/tfrank64/TFSwipeShrink)
TFSwipeShrink
=============

A UIView subclass that mimics the video player panning in the the current YouTube iOS and Android apps.

## Example

<p align="center">
    <img src="https://github.com/tfrank64/TFSwipeShrink/raw/master/RepoImages/swipShrinkAnimation.gif" alt="Screenshot" height="605" width="340"/>
</p>

### Installation

Copy the `TFSwipeShrinkView.swift` file into your Xcode project and you are ready.

### Usage

View `ExampleViewController.swift` to see an example of adding a video on top of a `TFSwipeShrinkView`.

1. Create a UIView in storyboard giving it a custom class of `TFSwipeShrinkView`. I suggest placing it at the top of your viewcontroller just as the YouTube app does.
2. In the viewcontroller implementing your TFSwipeShrinkView, within the `viewDidAppear` method call the `configureSizeAndPosition(parentViewFrame: CGRect)` on your swipe shrink object.

From here, everything should just work. It is up to you the developer to **add whatever you want on top of the swipe shrink view, such as a video or an image.**
In it's default state, you should have something that looks like this.
<p align ="center">
<img src="https://github.com/tfrank64/TFSwipeShrink/raw/master/RepoImages/maxvideo.png" alt="Screenshot" height="605" width="340"/>
</p>

## Author

Created by Taylor Franklin
([tfrank64](https://twitter.com/tfrank64))

### TODO

* Create a secondary view below shrink view, similar to YouTube app.

### Contributing

Feel free to fork the repo and open a pull request. Using fairly normal convention, make changes in your forked repo, then submit a pull request.

To view some of the original Objective-C code for this project, check out the `ObjCSwipeShrink` directory.

## License
TFSwipeShrink is licensed under the [MIT license.](https://github.com/tfrank64/TFSwipeShrink/blob/master/LICENSE.md)
