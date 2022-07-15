# EmailLink
A SwiftUI component to make handling of email links better. Not only will EmailLink use the correct default client, it will also prompt the user to select which to use if they have multiple installed.

# Platforms
Tested on iOS 16.0 but should work on iOS and iPadOS 13.0 and up.

# Setup
1. Add the package to your Swift Package Dependencies
2. Whitelist the URL schemes in your `Info.plist`. Refer to the [**Schemes**](#schemes) section for more information.
	```xml
    <key>LSApplicationQueriesSchemes</key>
	<array>
	    <string>googlegmail://</string>
	    <string>ms-outlook://</string>
	    <string>readdle-spark://</string>
	    <string>ymail://</string>
	    <string>airmail://</string>
	</array>
    ```
3. Add the component where you want to use it
    ```swift
    EmailLink("contact@example.com") {
        Text("Contact Us")
    }    
    ```
# Parameters
You can add some additional parameters in order to pre-populate the email client when opening. 
```swift
EmailLink("contact@example.com", subject: "subject", body: "body") {
    Text("Contact Us")
}
```

# Label
The label parameter accepts anything that conforms to `View`. You can pass practically any SwiftUI component in order to make your link look however you want.

# Schemes
In order for EmailLink to work, you must include **LSApplicationQueriesSchemes** along with the associated values in your `Info.plist`. The most common iOS email clients are supported. If an email client is not listed here, it will default to the built-in iOS `mailto:` scheme which will use the system default app.

# License
MIT License

Copyright (c) 2022 Joe Scotto

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
