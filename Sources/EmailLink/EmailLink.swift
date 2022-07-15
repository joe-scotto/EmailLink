import SwiftUI

typealias ActionSheetButton = ActionSheet.Button

public struct EmailLink<Content: View>: View {
    @State private var showAlert = false
    
    private let label: Content
    private let clients: [URLSchemes: EmailClient]
    
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
                queryItems: [
                    URLQueryItem(name: "to", value: to),
                    URLQueryItem(name: "subject", value: subject),
                    URLQueryItem(name: "body", value: body)
                ]
            )
        ]
    }

    public var body: some View {
        Button(action: {
            if getAvailableClients().count > 2 {
                showAlert = true
            } else {
                // Only open first found
                for client in clients {
                    if UIApplication.shared.canOpenURL(client.value.url) {
                        UIApplication.shared.open(client.value.url)
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
