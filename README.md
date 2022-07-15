# EmailLink
A package to handle opening email links in the default app.

# Platforms
Tested on iOS 16.0 but should work on iOS 13 and up.

# Setup
1. Add the package to your Swift Package Dependencies
2. Whitelist the URL schemes in your `Info.plist`. 
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

# Schemes
EmailLink supports the most common iOS email clients. You can choose whichever ones you want however, it is recommended to add all of them for the best support. **You must included "LSApplicationueriesSchemes"** otherwise a fatal error will be thrown. Other mail clients not listed here will not work with SwiftMail, please create a pull request with new suggestions along with their matching schemes.
    
    The default `mailto:` scheme is not required to work as this is the built-in iOS mail client link.

1. **Airmail** - airmail://
2. **Gmail** - googlegmail://
3. **Yahoo** - ymail://
4. **Spark** - readdle-spark://
5. **Outlook** - ms-outlook:// 
