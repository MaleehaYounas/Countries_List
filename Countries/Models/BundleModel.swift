import Foundation
import ObjectiveC.runtime

extension Bundle {
    private static var bundle: Bundle!
    static func setLanguage(language: String) {
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        bundle = path != nil ? Bundle(path: path!) : Bundle.main
    }
    static func localizedBundle() -> Bundle {
        return bundle ?? Bundle.main
    }
}
extension String {
    var localized: String{
        return Bundle.localizedBundle().localizedString(forKey: self, value: nil, table: nil)
    }
}

