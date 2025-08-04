import SwiftUI
import MapKit

struct CountryDetailsView: View {
    @Environment(\.dismiss) var dismiss
    var country: Country
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ImageSection
                Text("Name").font(.headline)
                NameSection

                Text("Geography").font(.headline)
                GeographySection

               
                Text("Population & Society").font(.headline)
                PopulationSection

                Text("Languages").font(.headline)
                LanguageSection

                Text("Currencies").font(.headline)
                CurrencySection

                Text("Time & Location").font(.headline)
                TimeSection
            }
            .padding()
        }
        .navigationTitle(country.name.common)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var ImageSection: some View {
        AsyncImage(url: URL(string: country.flags.png)) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 5))
        } placeholder: {
            Color.gray
                .frame(width: 300, height: 180)
        }
    }

    private var NameSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Common: \(country.name.common)")
            Text("Official: \(country.name.official)")
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.gray.opacity(0.2)))
    }

    private var GeographySection: some View {
        VStack(alignment: .leading, spacing: 4) {
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

            NavigationLink(
                destination: MapView(coordinates: country.latlng),
                label: {
                    Text("Show Map")
                        .foregroundColor(.white)
                        .padding(6)
                        .background {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(.blue)
                        }
                }
            )
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.gray.opacity(0.2)))
    }

    private var PopulationSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Population: \(country.population)")
            Text("Independent: \(country.independent ? "Yes" : "No")")
            Text("UN Member: \(country.unMember ? "Yes" : "No")")
            Text("Alt Spellings: \(country.altSpellings.joined(separator: ", "))")
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 12)
            .fill(Color.gray.opacity(0.2)))
    }

    private var LanguageSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(country.languages.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                Text("\(key.uppercased()): \(value)")
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 12)
            .fill(Color.gray.opacity(0.2)))
    }

    private var CurrencySection: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(country.currencies.sorted(by: { $0.key < $1.key }), id: \.key) { code, currency in
                Text("\(code): \(currency.name) (\(currency.symbol))")
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 12)
            .fill(Color.gray.opacity(0.2)))
    }

    private var TimeSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Time Zones: \(country.timezones.joined(separator: ", "))")
            Text("Continents: \(country.continents.map { $0.rawValue }.joined(separator: ", "))")
            Text("Capital Coordinates: \(country.capitalInfo.latlng.map { String(format: "%.2f", $0) }.joined(separator: ", "))")
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 12)
            .fill(Color.gray.opacity(0.2)))
    }
    
    
    
}
