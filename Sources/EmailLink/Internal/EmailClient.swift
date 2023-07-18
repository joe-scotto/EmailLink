import SwiftUI

struct EmailClient {
    let name: String
    let scheme: URLSchemes
    let host: String?
    let path: String
    let queryItems: [URLQueryItem]

    init(name: String, scheme: URLSchemes, host: String? = nil, path: String = "", queryItems: [URLQueryItem]) {
        self.name = name
        self.scheme = scheme
        self.host = host
        self.path = path
        self.queryItems = queryItems
    }

    var url: URL {
        var components = URLComponents()

        components.scheme = scheme.formattedScheme()
        components.host = host
        components.path = path
        components.queryItems = queryItems

        // Ensure URL is generated
        guard let url = components.url else {
            fatalError("URL cannot be generated for \"\(name)\".")
        }

        return url
    }

    static func allClients(to: String, subject: String, body: String) -> [EmailClient] {
        [
            EmailClient(
                name: "Gmail",
                scheme: .Gmail,
                host: "co",
                queryItems: [
                    URLQueryItem(name: "to", value: to),
                    URLQueryItem(name: "subject", value: subject),
                    URLQueryItem(name: "body", value: body)
                ]
            ),
            EmailClient(
                name: "Outlook",
                scheme: .Outlook,
                host: "compose",
                queryItems: [
                    URLQueryItem(name: "to", value: to),
                    URLQueryItem(name: "subject", value: subject),
                    URLQueryItem(name: "body", value: body)
                ]
            ),
            EmailClient(
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
            EmailClient(
                name: "Spark",
                scheme: .Spark,
                host: "compose",
                queryItems: [
                    URLQueryItem(name: "recipient", value: to),
                    URLQueryItem(name: "subject", value: subject),
                    URLQueryItem(name: "body", value: body)
                ]
            ),
            EmailClient(
                name: "Airmail",
                scheme: .AirMail,
                host: "compose",
                queryItems: [
                    URLQueryItem(name: "to", value: to),
                    URLQueryItem(name: "subject", value: subject),
                    URLQueryItem(name: "plainBody", value: body)
                ]
            ),
            EmailClient(
                name: "Default",
                scheme: .Default,
                path: to,
                queryItems: [
                    URLQueryItem(name: "subject", value: subject),
                    URLQueryItem(name: "body", value: body)
                ]
            )
        ]
    }
}

