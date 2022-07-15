import SwiftUI

struct EmailClient {
    let name: String
    let scheme: String
    let host: String
    let path: String
    let queryItems: [URLQueryItem]
    
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
        
        guard let url = components.url else {
            fatalError("URL cannot be generated for \"\(name)\".")
        }
        
        return url
    }
}
