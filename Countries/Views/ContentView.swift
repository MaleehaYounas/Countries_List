import SwiftUI

struct ContentView: View {
    
    @ObservedObject var network = Network()
    var body: some View {
        NavigationView {
            List(network.countiesList) { country in
                NavigationLink {
                    CountryDetailsView(country: country)
                } label: {
                    CountryRowView(country: country)
                }
            }
            .navigationTitle("Countries")
            .onAppear {
                network.getCountries()
            }
        }
    }
}
