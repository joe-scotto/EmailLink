import SwiftUI
import UIKit

typealias ActionSheetButton = ActionSheet.Button

public struct SwiftMail<Content: View>: View {
    @State private var showAlert = false
    
    private let label: Content
    private let to: String
    private let subject: String?
    private let mailBody: String?
    
    private var gmailUrl: URL {
        URL(string: "googlegmail://co?to=\(to)&subject=\(subject)&body=\(mailBody)")!
    }
    
//    private let infoDictionary: [String: Any]?
    
    // require info.plist passed in order to error check for schemes
//    private let info: Bundle
    
//    @State private var subject: String?
//    @State private var emailBody: String?
    
//    public let alert = Alert(title: Text("Swift Mail"))
    
//    @Binding private var swiftMailAlert: Bool
//
    
    enum URLSchemes: String, CaseIterable {
        case GMail = "googlegmail://",
             Outlook = "ms-outlook://",
             Yahoo = "ymail://",
             Spark = "readdle-spark://",
             AirMail = "airmail://",
             Default = "mailto:"
    }
    
    public init(to: String, subject: String? = nil, body: String? = nil, @ViewBuilder label: () -> Content) {
        // Ensure Info.plist includes required schemes
        guard (Bundle.main.infoDictionary?["LSApplicationQueriesSchemes"]) != nil else {
            fatalError("Your Info.plist is missing \"LSApplicationQueriesSchemes\". Please refer to the SwiftMail documentation for more details.")
        }
        
        // Set properties
        self.to = to
        self.subject = subject
        self.mailBody = body
        self.label = label()
    }
    
    public var body: some View {
        Button(action: {
            showAlert = true
        }) {
            label
        }
        .actionSheet(isPresented: $showAlert) {
            ActionSheet(
                title: Text("Multiple apps installed"),
                message: Text("Which app do you want to use to send your email?"),
                buttons: actionSheetButtons()
            )
        }
    }
    
    func actionSheetButtons() -> [ActionSheetButton] {
        var buttons = [ActionSheetButton]()
        
        for client in getAvailableClients() {
            buttons.append(ActionSheetButton.default(
                Text(client.rawValue)
            , action: {
                print(client)
            }))
        }
        
        return buttons
    }
    
    private func getAvailableClients() -> [URLSchemes] {
        var availableClients = [URLSchemes]()
        
        for scheme in URLSchemes.allCases {
            if let url = URL(string: scheme.rawValue), UIApplication.shared.canOpenURL(url) {
                availableClients.append(scheme)
            }
        }
        
        return availableClients
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
