import SwiftUI

struct EmailClient {
    let name: String
    let scheme: String
    let host: String
    let path: String
    let queryItems: [URLQueryItem]
    
    // Issue with mail/compose and path
    // https://stackoverflow.com/questions/35960185/nsurlcomponents-builds-scheme-without
    
    init(name: String, scheme: String, host: String, path: String = "", queryItems: [URLQueryItem]) {
        self.name = name
        self.scheme = scheme
        self.host = host
        self.path = path
        self.queryItems = queryItems
    }
    
    var url: URL {
        var components = URLComponents()
        components.scheme = scheme.replacingOccurrences(of: "://", with: "")
            components.host = host
            components.path = path
            components.queryItems = queryItems
        
        print(components.url!)
        
        guard let url = components.url else {
            fatalError("URL cannot be generated for \"\(name)\".")
        }
        
        return url
    }
}
