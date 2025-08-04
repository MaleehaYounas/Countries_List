
import Foundation

struct Country: Codable, Identifiable {
    let id: UUID = UUID()
    let name: Name
    let tld: [String]?
    let cca2: String
    let ccn3, cioc: String?
    let independent: Bool
    let unMember: Bool
    let currencies: [String: Currency]
    let capital, altSpellings: [String]
    let region: Region
    let subregion: String
    let languages: [String: String]
    let latlng: [Double]
    let landlocked: Bool
    let borders: [String]?
    let area: Double
    let cca3: String
    let flag: String
    let population: Int
    let gini: [String: Double]?
    let fifa: String?
    let capitalInfo: CapitalInfo
    let timezones: [String]
    let continents: [Region]
    let flags: Flags
 
}


struct CapitalInfo: Codable {
    let latlng: [Double]
}

enum Region: String, Codable {
    case africa = "Africa"
    case americas = "Americas"
    case asia = "Asia"
    case europe = "Europe"
    case northAmerica = "North America"
    case oceania = "Oceania"
    case southAmerica = "South America"
}

struct Currency: Codable {
    let symbol, name: String
}

struct Eng: Codable {
    let f, m: String
}


struct Flags: Codable {
    let png: String
    let svg: String
    let alt: String?
}


struct Name: Codable {
    let common, official: String
    //let nativeName: [String: Translation]
}








//let maps: Maps
// let coatOfArms: CoatOfArms
// let startOfWeek: StartOfWeek
//let car: Car
//let translations: [String: Translation]
//let demonyms: Demonyms
//let idd: Idd
//let status: Status
// let postalCode: PostalCode



// MARK: - Car
//struct Car: Codable {
//    let signs: [String]
//    let side: Side
//}

//enum Side: String, Codable {
//    case sideLeft = "left"
//    case sideRight = "right"
//}

// MARK: - CoatOfArms
//struct CoatOfArms: Codable {
//    let png: String?
//    let svg: String?
//}


// MARK: - Demonyms
//struct Demonyms: Codable {
//    let eng, fra: Eng
//}



// MARK: - Idd
//struct Idd: Codable {
//    let root: String
//    let suffixes: [String]
//}

// MARK: - Maps
//struct Maps: Codable {
//    let googleMaps, openStreetMaps: String
//}



// MARK: - Translation
//struct Translation: Codable {
//    let official, common: String
//}

// MARK: - PostalCode
//struct PostalCode: Codable {
//    let format, regex: String?
//}

//enum StartOfWeek: String, Codable {
//    case monday = "monday"
//    case saturday = "saturday"
//    case sunday = "sunday"
//}

//enum Status: String, Codable {
//    case officiallyAssigned = "officially-assigned"
//    case userAssigned = "user-assigned"
//}

