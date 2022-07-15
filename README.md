# EmailLink
A SwiftUI component to make handling of email links better. Not only will EmailLink use the correct default client, it will also prompt the user to select which to use if they have multiple installed.

# Platforms
Tested on iOS 16.0 but should work on iOS and iPadOS 13.0 and up.

# Setup
1. Add the package to your Swift Package Dependencies
2. Whitelist the URL schemes in your `Info.plist`. Refer to the **Schemes** section for more information.
	```
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
    ```
    EmailLink("contact@example.com") {
        Text("Contact Us")
    }    
    ```
# Parameters
You can add some additional parameters in order to pre-populate the email client when opening. 
```
EmailLink("contact@example.com", subject: "subject", body: "body") {
    Text("Contact Us")
}
```

# Label
The label parameter accepts anything that conforms to `View`. You can pass practically any SwiftUI component in order to make your link look however you want.

# Schemes
In order for EmailLink to work, you must include **LSApplicationQueriesSchemes** along with the associated values in your `Info.plist`. The most common iOS email clients are supported. If an email client is not listed here, it will default to the built-in iOS `mailto:` scheme which will use the system default app.
