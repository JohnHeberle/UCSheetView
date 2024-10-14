# UnifiedComponents - SheetView

### UnifiedComponents
UnifiedComponents aims to isolate code I have found helpful in personal projects and make it publicly available.

### SheetView
Apple provides [PageSheet](https://developer.apple.com/documentation/uikit/uimodalpresentationstyle/pagesheet) as a modal presentation style. However, PageSheet is designed to "present simple content or tasks" ([HIG](https://developer.apple.com/design/human-interface-guidelines/sheets)) and Apple suggests "for complex or prolonged user flows, consider alternatives to sheets" ([HIG](https://developer.apple.com/design/human-interface-guidelines/sheets)). This results in limitations for using the sheet as a display mechanism for long-lived views.

PageSheet's primary limitation is it is always presented from the bottom of the user's screen. Apple does not provide the functionality to configure the sheet to be used similarly to a UIView. Existing packages resolve this issue. However, I found these implementations lacked the same level of user responsiveness as Apple's PageSheet. Specifically, existing implementations did not contain the spring dampening or out-of-detent bounds spring panning that makes PageSheet feel incredibly natural.

UCSheetView aims to resolve this by providing a configurable UIView subclass that reacts to user input similarly to PageSheet.

| Bottom Sheet | Sheet Above Subview |
|-|-|
|![Bottom Sheet Recording](https://github.com/user-attachments/assets/9757647e-392d-4170-aaa1-92997bc1dc70)|![Sheet Above Subview Recording](https://github.com/user-attachments/assets/1a7cac45-96f0-4663-b706-3b5c9bb848a0)|

### Usage
UCSheetView's implementation is based on a UCSheetView.Configuration object passed to it on init. Specify all of the desired values for your project here.

Definitions:
- detent: The height at which the sheet view will rest when changing between heights.

UCSheetView.Configuration:
- (REQUIRED) detents [SheetDetent]: An array of user-specified detents. Each detent must have a distinct identifier of the following type (.default, .xSmall, .small, .medium, .large, .xLarge). A detent will be ignored if it has the same identifier as an existing detent. SheetDetent uses the height of the container to resolve detent heights at runtime. A detent with a resolved height greater than the container's height or less than the minimum sheet height will be clamped to these values, respectively. The detents are specified via the following static initializers.
  - .fractional(identifier: Identifier, divisor: CGFloat): Creates a detent at `container height / divisor`. 
  - .absolute(identifier: Identifier, height: CGFloat): Creates a detent with an absolute height of `height`. 
  - .absolute(identifier: Identifier, offsetFromTop offset: CGFloat): Creates a detent with an absolute height of `container height - offset`.
 - largestUnDimmedDetentIdentifier: The largest detent with no dimming. The sheet's background view begins to dim at any height greater than the resolved height of this detent.
 - maxDimmingAlpha: The maximum alpha the background view will dim to.
 - backgroundColor: The background color of the sheet.
 - grabberColor: The color of the drag indicator at the top of the sheet (i.e. grabber).
 - cornerRadius: The corner radius of the sheet.
 - shadowColor: The color of the shadow behind the sheet.
 - shadowOpacity: The opacity of the shadow behind the sheet.
 - shadowRadius: The radius of the shadow behind the sheet.

UCSheetView:
- init(frame: CGRect = .zero, contentView: UIView, sheetConfiguration: Configuration): The contentView is the UIView passed into the sheet view for display. The sheetConfiguration is the configuration object outlined above.

### Example
```swift
import UCSheetView

private lazy var sheet: UCSheetView = {
  let detents: [SheetDetent] = [
    .absolute(identifier: .default, height: 100),
    .fractional(identifier: .medium, divisor: 2),
  ]
  let sheetConfiguration = UCSheetView.Configuration(detents: detents, maxDimmingAlpha: 0.8, shadowRadius: 40)
  let sheet = UCSheetView(contentView: UIView(), sheetConfiguration: sheetConfiguration)
  sheet.translatesAutoresizingMaskIntoConstraints = false
  return sheet
}()
```
