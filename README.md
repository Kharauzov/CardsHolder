![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
[![License](https://img.shields.io/badge/license-mit-blue.svg)](https://doge.mit-license.org)

## Sense
I created this project to demonstrate the power of **child view controllers** in iOS development. But in order to avoid boring and simple interfaces in this concept, I was using interactive views and custom transitions 😎
Please check attached video below, demonstrating how it works.

* This project contains only pure Swift❤️
* No third-party frameworks and Pods.

## Presentation
<p align="left">
<img src="https://github.com/Kharauzov/CardsHolder/blob/master/VisualFiles/cards_holder.gif" width="450px" height="338px"/>
</p>

### Key things:

1. `UIPanGestureRecognizer` for dragging cards.
2. `CADisplayLink` for accurate observing of frames changes in animations.
3. `UIView.animate{}` blocks for most of the animations.
4. `CABasicAnimation` for shadow layer.
5. `UIViewControllerTransitioningDelegate` for custom transition to Details scene.
6. All UI is made **programmatically**, thus it’s reusable. No xibs, no storyboards.

### Structure of the screen

<p align="left">
<img src="https://github.com/Kharauzov/CardsHolder/blob/master/VisualFiles/screen1.png" width="266px" height="495px"/>
</p>

Here is a structure of main screen.<br/>
ProfileViewController - as a parent view controller, subclassed from `CardsHolderViewController`. It contains such child view controllers:<br/>

1. ProfileShortInfoViewController (top part of the screen)
2. ProfileActivityViewController (activity card)
3. RecommendationsViewController (recommended card)

<p align="left">
<img src="https://github.com/Kharauzov/CardsHolder/blob/master/VisualFiles/screen2.png" width="266px" height="495px"/>
</p>

If you open recommended card, there will be such state for the screen:<br/>
Fully visible RecommendationsViewController, that contains tableView with cells, each of which holds child view controller subclassed from `RecommendationsSliderViewController`.


### Feedback
If you have any questions or suggestions, feel free to open issue just at this project.

### License
CardsHolder and all its classes are available under the MIT license. See the LICENSE file for more info.
