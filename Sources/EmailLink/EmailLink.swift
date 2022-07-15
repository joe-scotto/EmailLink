import SwiftUI
import UIKit

typealias ActionSheetButton = ActionSheet.Button

public struct EmailLink<Content: View>: View {
    @State private var showAlert = false
    
    private let label: Content
    private let to: String
    private let subject: String?
    private let mail: String?
    private let links: [URLSchemes: (appName: String, url: URL)]
    
    private var gmailLink: URL? {
        return "fdsafa"
    }
    
    enum URLSchemes: String, CaseIterable {
        case Gmail = "googlegmail://",
             Outlook = "ms-outlook://",
             Yahoo = "ymail://",
             Spark = "readdle-spark://",
             AirMail = "airmail://"
    }
    
    public init(to: String, subject: String? = nil, body: String? = nil, @ViewBuilder label: () -> Content) {
        // Ensure Info.plist includes required schemes
        guard (Bundle.main.infoDictionary?["LSApplicationQueriesSchemes"]) != nil else {
            fatalError("Your Info.plist is missing \"LSApplicationQueriesSchemes\". Please refer to the EmailLink documentation for more details.")
        }
        
        
        // Set properties
        self.to = to
        self.subject = subject?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        self.mail = body?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        self.label = label()
        
        
        
        
        self.links = [
            .Gmail: (appName: "GMail", url: URL(string: "googlegmail://co?to=\(self.to)&subject=\(self.subject)&body=\(self.mail)")!)
        ]
    }
    
    private func generateLinks() -> [URLSchemes: URL] {
        let links = [URLSchemes: URL]()
        
        for scheme in URLSchemes.allCases {
            
        }
        
        return links
    }
    
    public var body: some View {
        Button(action: {
            if getAvailableClients().count > 1 {
                showAlert = true
            }
        }) {
            label
        }
        .actionSheet(isPresented: $showAlert) {
            ActionSheet(
                title: Text("Multiple Clients Found"),
                message: Text("Which app do you want to use to send this email?"),
                buttons: actionSheetButtons()
            )
        }
    }
    
    func actionSheetButtons() -> [ActionSheetButton] {
        var buttons = [ActionSheetButton]()
        
        for client in getAvailableClients() {
            buttons.append(.default(
                Text(client.rawValue)
            , action: {
                print(client)
            }))
        }
        
        buttons.append(.cancel())
        buttons.append(.default(
            Text("Use Default")
        ))
        
        return buttons
    }
    
    private func getAvailableClients() -> [URLSchemes] {
        // Needs to check for Mail app individually as mailto: is always available
        
        var availableClients = [URLSchemes]()
        
        for scheme in URLSchemes.allCases {
            if let url = URL(string: scheme.rawValue), UIApplication.shared.canOpenURL(url) {
                availableClients.append(scheme)
            }
        }
        
        
        return availableClients
    }
    
    private func generateLinks() -> [(app: String, url: URL)] {
        return [(app: "Spark", url: URL(string: "daf")!)]
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
}
