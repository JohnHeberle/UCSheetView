# UnifiedComponents - SheetView (Work in Progress)

### UnifiedComponents
UnifiedComponents aims to isolate code I have found helpful in personal projects and make it publicly available.

### SheetView
Apple provides [PageSheet](https://developer.apple.com/documentation/uikit/uimodalpresentationstyle/pagesheet) as a modal presentation style. However, PageSheet is designed to "present simple content or tasks" ([HIG](https://developer.apple.com/design/human-interface-guidelines/sheets)) and Apple suggests "for complex or prolonged user flows, consider alternatives to sheets" ([HIG](https://developer.apple.com/design/human-interface-guidelines/sheets)). This results in limitations for using the sheet as a display mechanism for long-lived views.

PageSheet's primary limitation is it is always presented from the bottom of the user's screen. Apple does not provide the functionality to configure the sheet to be used similarly to a UIView. Existing packages resolve this issue. However, I found these implementations lacked the same level of user responsiveness as Apple's PageSheet. Specifically, existing implementations did not contain the spring dampening or out-of-detent bounds spring panning that makes PageSheet feel incredibly natural.

UCSheetView aims to resolve this by providing a configurable UIView subclass that reacts to user input similarly to PageSheet.

### ToDos
- Add Tests
  - SheetDetentsModel
  - SheetHeightModifierModel
  - SheetViewModel
  - UCSheetView
- Add Features
  - Make configuration to sheet expand from top instead of bottom
  - Make configuration to dismiss the sheet
  - Make configuration to allow detent heights to be setrelative to safe area
