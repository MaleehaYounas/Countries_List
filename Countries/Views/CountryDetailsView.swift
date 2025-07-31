import SwiftUI

struct CountryDetailsView: View {
    @Environment(\.dismiss) var dismiss
    var country: Country

    var body: some View {
        Form {
            ImageSection
            NameSection
            GeographySection
            PopulationSection
            LanguageSection
            CurrencySection
            CodeSection
            TimeSection
        }
        .navigationTitle(country.name.common)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    
    var ImageSection:some View{
        Section {
            HStack {
                Spacer()
                AsyncImage(url: URL(string: country.flags.png)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 110)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                } placeholder: {
                    Color.gray
                        .frame(width: 160, height: 110)
                }
                
                Spacer()
            }
            .listRowBackground(Color.clear)
        }

    }
    var NameSection:some View{
        Section(header: Text("Name")) {
            Text("Common: \(country.name.common)")
            Text("Official: \(country.name.official)")
        }
    }
    
    var GeographySection:some View{
        Section(header: Text("Geography")) {
            Text("Region: \(country.region.rawValue)")
            Text("Subregion: \(country.subregion)")
            Text("Area: \(country.area, specifier: "%.2f") km²")
            ForEach(country.capital, id: \.self) { cap in
                Text("Capital: \(cap)")
            }
            if let borders = country.borders {
                Text("Borders: \(borders.joined(separator: ", "))")
            }
            Text("Landlocked: \(country.landlocked ? "Yes" : "No")")
            Text("Latitude, Longitude: \(country.latlng.map { String(format: "%.2f", $0) }.joined(separator: ", "))")
        }
    }
    
    var PopulationSection:some View{
        Section(header: Text("Population & Society")) {
            Text("Population: \(country.population)")
            Text("Independent: \(country.independent ? "Yes" : "No")")
            Text("UN Member: \(country.unMember ? "Yes" : "No")")
            Text("Alt Spellings: \(country.altSpellings.joined(separator: ", "))")
        }
    }
    
    var LanguageSection:some View{
        Section(header: Text("Languages")) {
            ForEach(country.languages.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                Text("\(key.uppercased()): \(value)")
            }
        }
    }
    
    var CurrencySection:some View{
        Section(header: Text("Currencies")) {
            ForEach(country.currencies.sorted(by: { $0.key < $1.key }), id: \.key) { code, currency in
                Text("\(code): \(currency.name) (\(currency.symbol))")
            }
        }
    }
    
    var CodeSection:some View{
        
        Section(header: Text("Codes")) {
            Text("CCA2: \(country.cca2)")
            Text("CCA3: \(country.cca3)")
            if let ccn3 = country.ccn3 {
                Text("CCN3: \(ccn3)")
            }
            if let cioc = country.cioc {
                Text("CIOC: \(cioc)")
            }
            if let fifa = country.fifa {
                Text("FIFA: \(fifa)")
            }
        }
    }
    
    var TimeSection:some View{
        
        Section(header: Text("Time & Location")) {
            Text("Time Zones: \(country.timezones.joined(separator: ", "))")
            Text("Continents: \(country.continents.map { $0.rawValue }.joined(separator: ", "))")
            Text("Capital Coordinates: \(country.capitalInfo.latlng.map { String(format: "%.2f", $0) }.joined(separator: ", "))")
        }
    }
}
