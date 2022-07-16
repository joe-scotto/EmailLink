enum URLSchemes: String, CaseIterable {
    case Gmail = "googlegmail://",
         Outlook = "ms-outlook://",
         Yahoo = "ymail://",
         Spark = "readdle-spark://",
         AirMail = "airmail://",
         Default = "mailto:"
    
    func formattedScheme() -> String {
        self.rawValue
            .replacingOccurrences(of: ":", with: "")
            .replacingOccurrences(of: "//", with: "")
    }
    
    static func requiredSchemes() -> [String] {
        [
            Self.Gmail.formattedScheme(),
            Self.Outlook.formattedScheme(),
            Self.Yahoo.formattedScheme(),
            Self.Spark.formattedScheme(),
            Self.AirMail.formattedScheme()
        ]
    }
}
