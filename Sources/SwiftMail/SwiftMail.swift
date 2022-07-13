import SwiftUI

public struct SwiftMail<Content: View>: View {
    @State private var showAlert = false
    
    private let label: Content
    private let to: String
    private let subject: String?
    private let mailBody: String?
    
    // require info.plist passed in order to error check for schemes
    private let info: Bundle
    
//    @State private var subject: String?
//    @State private var emailBody: String?
    
//    public let alert = Alert(title: Text("Swift Mail"))
    
//    @Binding private var swiftMailAlert: Bool
//
//    enum URLSchemes: String, CaseIterable {
//        case GMail = "googlegmail://",
//             Outlook = "ms-outlook://",
//             Yahoo = "ymail://",
//             Spark = "readdle-spark://",
//             AirMail = "airmail://",
//             Default = "mailto:"
//    }
    
    public init(to: String, subject: String? = nil, body: String? = nil, @ViewBuilder label: () -> Content) {
        self.to = to
        self.subject = subject
        self.mailBody = body
        self.label = label()
        
       
    }
    
    public var body: some View {
        Button(action: {
            showAlert = true
            var nsDictionary: NSDictionary?
        }) {
            label
        }
        .actionSheet(isPresented: $showAlert) {
                ActionSheet(title: Text("Multiple Email Apps"),
                            message: Text("Choose an app to open"),
                            buttons: [
                                .cancel(),
                                .destructive(
                                    Text("Overwrite Current Workout")
                                ),
                                .default(
                                    Text("Append to Current Workout")
                                )
                            ]
                )
            }
//        .alert("Send email with", isPresented: $showAlert) {
//            Button("Gmail", action: {})
//            Button("Outlook", action: {})
//            Button("Spark", role: .destructive, action: {})
//            Button("Apple Mail", role: .cancel, action: {})
//        }
    }
    
    
//    public var url: URL? {
//        // Encode URLS
//        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//
//        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
//        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)")
//        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
//        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
//        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
//
//        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
//            return gmailUrl
//        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
//            return outlookUrl
//        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
//            return yahooMail
//        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
//            return sparkUrl
//        }
//
//        return defaultUrl
//    }
////
//    private func composeUrl() {
//
//    }
//
//    public func openUrl() {
//        UIApplication.shared.open(URL(string: "https://youtube.com")!)
//    }
//
//    public func getAvailableClients() -> [String] {
//        var availableClients = [String]()
//
//        for scheme in URLSchemes.allCases {
//            if let url = URL(string: scheme.rawValue), UIApplication.shared.canOpenURL(url) {
//                availableClients.append(url.absoluteString)
//            }
//        }
//
//        swiftMailAlert = true
//
//        return availableClients
//    }
//
//    public func test() {
//
//    }
}


// If multiple found, ask which to open in
