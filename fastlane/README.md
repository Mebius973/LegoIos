fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios screenshot_local
```
fastlane ios screenshot_local
```
Generate new localized screenshots locally
### ios screenshot
```
fastlane ios screenshot
```
Generate new localized screenshots
### ios beta
```
fastlane ios beta
```
Push app to beta
### ios get_current_build_number
```
fastlane ios get_current_build_number
```
Setup Build Number

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
