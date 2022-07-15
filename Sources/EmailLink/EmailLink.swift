import SwiftUI

typealias ActionSheetButton = ActionSheet.Button

public struct EmailLink<Content: View>: View {
    @State private var showAlert = false
    
    private let label: Content
    private let clients: [URLSchemes: EmailClient]
    
    enum URLSchemes: String, CaseIterable {
        case Gmail = "googlegmail://",
             Outlook = "ms-outlook://",
             Yahoo = "ymail://",
             Spark = "readdle-spark://",
             AirMail = "airmail://"
    }
    
    public init(to: String, subject: String = "", body: String = "", @ViewBuilder label: () -> Content) {
        // Ensure Info.plist includes required schemes
        guard (Bundle.main.infoDictionary?["LSApplicationQueriesSchemes"]) != nil else {
            fatalError("Your Info.plist is missing \"LSApplicationQueriesSchemes\". Please refer to the EmailLink documentation for more details.")
        }
        
        // Set properties
        self.label = label()
        self.clients =  [
            .Gmail: EmailClient(
                name: "Gmail",
                scheme: URLSchemes.Gmail.rawValue,
                host: "co",
                queryItems: [
                    URLQueryItem(name: "to", value: to),
                    URLQueryItem(name: "subject", value: subject),
                    URLQueryItem(name: "body", value: body)
                ]
            ),
            .Outlook: EmailClient(
                name: "Outlook",
                scheme: URLSchemes.Outlook.rawValue,
                host: "compose",
                queryItems: [
                    URLQueryItem(name: "to", value: to),
                    URLQueryItem(name: "subject", value: subject),
                    URLQueryItem(name: "body", value: body)
                ]
            ),
            .Yahoo: EmailClient(
                name: "Yahoo",
                scheme: URLSchemes.Yahoo.rawValue,
                host: "mail",
                path: "/compose",
                queryItems: [
                    URLQueryItem(name: "to", value: to),
                    URLQueryItem(name: "subject", value: subject),
                    URLQueryItem(name: "body", value: body)
                ]
            ),
            .Spark: EmailClient(
                name: "Spark",
                scheme: URLSchemes.Spark.rawValue,
                host: "compose",
                queryItems: [
                    URLQueryItem(name: "recipient", value: to),
                    URLQueryItem(name: "subject", value: subject),
                    URLQueryItem(name: "body", value: body)
                ]
            ),
            .AirMail: EmailClient(
                name: "Airmail",
                scheme: URLSchemes.AirMail.rawValue,
                host: "compose",
                queryItems: [
                    URLQueryItem(name: "to", value: to),
                    URLQueryItem(name: "subject", value: subject),
                    URLQueryItem(name: "plainBody", value: body)
                ]
            )
        ]
        
        // Try to open first found app
        // If that app cannot open, use mailto:
        // If multiple are found show prompt
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
                Text(clients[client]?.name ?? "")
            , action: {
                print(clients[client]?.url ?? "")
                UIApplication.shared.open(clients[client]?.url ?? URL(string: "")!)
            }))
        }
        
        buttons.append(.cancel())
        buttons.append(.default(
            Text("Open Default")
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
}
