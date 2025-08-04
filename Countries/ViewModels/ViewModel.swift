//
//  CountryViewModel.swift
//

import Foundation
import MapKit

class ViewModel: ObservableObject {
    @Published var countriesList: [Country] = []
    @Published var isLoading = false
    @Published var errorMessage: Error? = nil
    @Published var results: [Country] = []
    private let network = Network()
    private var url:String = "https://restcountries.com/v3.1/independent?status=true"
    
    @Published var region =  MKCoordinateRegion()
    
    
    func loadCountries() {
        isLoading = true
        
        network.fetchData(from: url) { (result: Result<[Country], Error>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let data):
                    self.countriesList = data
                case .failure(let error):
                    self.errorMessage=error
                  
                }
            }
        }
    }
    
    func getSearchResults(input: String) -> [Country] {
        var searchResults: [Country] = []
        let lowercasedInput = input.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        for i in 0..<countriesList.count {
            let commonName = countriesList[i].name.common.lowercased()
            let officialName = countriesList[i].name.official.lowercased()
            
            if commonName.hasPrefix(lowercasedInput) || officialName.hasPrefix(lowercasedInput) {
                searchResults.append(countriesList[i])
            }
        }
        return searchResults
    }
    
    
    func getRegion(coordinates: [Double])-> MKCoordinateRegion {
       region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: coordinates[0], longitude: coordinates[1]),
        span: MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8)
        )
        return region
    }
  
}

        
        

