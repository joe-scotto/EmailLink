import SwiftUI

struct EmailClient {
    let name: String
    let scheme: String
    let host: String
    let path: String
    let to: URLQueryItem
    let subject: URLQueryItem
    let body: URLQueryItem
    
    // Issue with mail/compose and path
    // https://stackoverflow.com/questions/35960185/nsurlcomponents-builds-scheme-without
    
    var url: URL {
        var components = URLComponents()
        components.scheme = scheme.replacingOccurrences(of: "://", with: "")
            components.host = path
            components.queryItems = [
                to,
                subject,
                body
            ]
        
        guard let url = components.url else {
            fatalError("URL cannot be generated for \"\(name)\".")
        }
        
        return url
    }
}
