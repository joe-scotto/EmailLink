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
	    <string>googlegmail</string>
	    <string>ms-outlook</string>
	    <string>readdle-spark</string>
	    <string>ymail</string>
	    <string>airmail</string>
	</array>
    ```
3. Add the component where you want to use it
    ```swift
    EmailLink("contact@example.com") {
        Text("Contact Us")
    }    
    ```
# Parameters
Below are the parameters available on `EmailLink`. 

| Parameter      | Type                  | Required  | Note
|----------------|-----------------------|-----------|---------------------------------|
| to             | String                | Yes       | Where to send the email         |
| subject        | String                | No        | Subject to populate             |
| body           | String                | No        | Email body to populate          |
| color          | UIColor               | No        | Color for `ActionSheet` buttons |
| label          | View                  | Yes       | View to show as the `EmailLink` | 

# Schemes
In order for EmailLink to work, you must include **LSApplicationQueriesSchemes** along with the associated values in your `Info.plist`. The most common iOS email clients are supported. If an email client is not listed here, it will default to the built-in iOS `mailto:` scheme which will use the system default app. 

# Issues
The main reason for this package is to deal with the buggy iOS implementation of the default mail app where sometimes it will not actually try to open. Therefore, it is possible that the `mailto:` scheme may or may not work depending on if that iOS version is working with the default app setting. This shouldn't be an issue as EmailLink handles most clients however, I wanted to mention it in case this issue arrises. 

# License
MIT License

Copyright (c) 2022 Joe Scotto

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

