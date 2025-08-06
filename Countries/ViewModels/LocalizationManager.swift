import SwiftUI

class LocalizationManager: ObservableObject {
    
    @Published var layoutDirection: LayoutDirection = .leftToRight
    @Published var id: UUID = UUID()
    @AppStorage("selectedLanguage") var selectedLanguage: String = "en" {
        didSet {
            Bundle.setLanguage(language: selectedLanguage)
            layoutDirection = (selectedLanguage == "ur") ? .rightToLeft : .leftToRight
            id = UUID()
        }
    }
}

    
    
