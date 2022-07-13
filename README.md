# SwiftMail
A package to handle opening email links in the default app.

# Platforms
Tested on iOS 15.4 but should work on iOS 13 and up.

# Setup
1. Add the package to your Swift Package Dependencies
2. Whitelist the URL schemes in your `Info.plist`. **Please keep this in mind when updating the package.**
```
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>googlegmail</string>
    <string>ms-outlook</string>
    <string>readdle-spark</string>
    <string>ymail</string>
    <string>airmail</string>
</array>
```
