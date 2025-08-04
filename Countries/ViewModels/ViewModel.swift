//
//  CountryViewModel.swift
//

import Foundation

class ViewModel: ObservableObject {
    @Published var countriesList: [Country] = []
    @Published var isLoading = false
    @Published var errorMessage: Error? = nil
    
    private let network = Network()
    private var url:String = "https://restcountries.com/v3.1/independent?status=true"
    
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
  
}

        
        

