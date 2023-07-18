import SwiftUI

typealias ActionSheetButton = ActionSheet.Button

public struct EmailLink<Content: View>: View {
    @State private var showAlert = false
    
    private let label: Content
    private let clients: [URLSchemes: EmailClient]
    
    public init(to: String, subject: String = "", body: String = "", color: UIColor = .systemBlue, @ViewBuilder label: () -> Content) {
        // Ensure Info.plist includes required keys
        Self.checkInfoDictionary()
        
        // Set properties
        self.label = label()
        self.clients =  [
            .Gmail: EmailClient(
                name: "Gmail",
                scheme: .Gmail,
                host: "co",
                queryItems: [
                    URLQueryItem(name: "to", value: to),
                    URLQueryItem(name: "subject", value: subject),
                    URLQueryItem(name: "body", value: body)
                ]
            ),
            .Outlook: EmailClient(
                name: "Outlook",
                scheme: .Outlook,
                host: "compose",
                queryItems: [
                    URLQueryItem(name: "to", value: to),
                    URLQueryItem(name: "subject", value: subject),
                    URLQueryItem(name: "body", value: body)
                ]
            ),
            .Yahoo: EmailClient(
                name: "Yahoo",
                scheme: .Yahoo,
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
                scheme: .Spark,
                host: "compose",
                queryItems: [
                    URLQueryItem(name: "recipient", value: to),
                    URLQueryItem(name: "subject", value: subject),
                    URLQueryItem(name: "body", value: body)
                ]
            ),
            .AirMail: EmailClient(
                name: "Airmail",
                scheme: .AirMail,
                host: "compose",
                queryItems: [
                    URLQueryItem(name: "to", value: to),
                    URLQueryItem(name: "subject", value: subject),
                    URLQueryItem(name: "plainBody", value: body)
                ]
            ),
            .Default: EmailClient(
                name: "Default",
                scheme: .Default,
                path: to,
                queryItems: [
                    URLQueryItem(name: "subject", value: subject),
                    URLQueryItem(name: "body", value: body)
                ]
            )
        ]
        
        // Force color for ActionSheet
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = color
    }

    public var body: some View {
        Button(action: {
            let availableClients = getAvailableClients()

            if availableClients.count > 2 {
                showAlert = true
            } else {
                // Only open first found available client.
                for client in availableClients {
                    if UIApplication.shared.canOpenURL(client.value.url) {
                        UIApplication.shared.open(client.value.url)
                        break
                    }
                }
            }
        }) {
            label
        }
        .actionSheet(isPresented: $showAlert) {
            ActionSheet(
                title: Text("Multiple Apps Found"),
                message: Text("Which app do you want to use to send this email?"),
                buttons: actionSheetButtons()
            )
        }
    }
    
    private func actionSheetButtons() -> [ActionSheetButton] {
        var buttons = [ActionSheetButton]()
        
        for client in getAvailableClients() {
            buttons.append(.default(
                Text(clients[client]?.name ?? "")
            , action: {
                if let url = clients[client]?.url {
                    UIApplication.shared.open(url)
                }
            }))
        }
        
        buttons.append(.cancel())
        
        return buttons
    }
    
    private func getAvailableClients() -> [URLSchemes] {
        var availableClients = [URLSchemes]()
        
        for scheme in URLSchemes.allCases {
            if let url = URL(string: client.value.url), UIApplication.shared.canOpenURL(url) {
                availableClients.append(scheme)
            }
        }
        
        return availableClients
    }
    
    private static func checkInfoDictionary() {
        if let schemes = Bundle.main.infoDictionary?["LSApplicationQueriesSchemes"] as? Array<String> {
            // Bundle exists, check values
            for requiredScheme in URLSchemes.requiredSchemes() {
                if !schemes.contains(requiredScheme) {
                    fatalError("Your Info.plist is missing \"\(requiredScheme)\" for \"LSApplicationQueriesSchemes\".")
                }
            }
        } else {
            // Check individual schemes
            fatalError("Your Info.plist is missing \"LSApplicationQueriesSchemes\".")
        }
    }
}
