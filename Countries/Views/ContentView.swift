import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @FocusState private var isInputActive: Bool
    @State private var searchInput: String = ""
    @State private var isSortedAlphabetically = false
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text("Error: \(error.localizedDescription)")
                            .foregroundColor(.red)
                            .padding()
                        Button("Retry") {
                            viewModel.loadCountries()
                        }
                    }
                } else {
                    VStack {
                        searchTextField

                        if !searchInput.isEmpty && viewModel.results.isEmpty {
                            noSearchResults
                        } else {
                            if !searchInput.isEmpty {
                                searchResultsSection
                            } else {
                                List(displayedCountries) { country in
                                    NavigationLink {
                                        CountryDetailsView(country: country, viewModel: viewModel)
                                    } label: {
                                        CountryRowView(country: country)
                                    }
                                }
                                .listStyle(.inset)
                            }
                        }

                        Spacer()
                    }
                }
            }
            .navigationTitle("Countries")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isInputActive = false
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    sortButton
                }
            }
        }
        .onAppear {
            viewModel.loadCountries()
        }
    }

    private var searchResultsSection: some View {
        List(sortedResults) { country in
            NavigationLink {
                CountryDetailsView(country: country, viewModel: viewModel)
            } label: {
                CountryRowView(country: country)
            }
        }
        .listStyle(.inset)
    }

    private var noSearchResults: some View {
        VStack {
            ContentUnavailableView("No matching countries found", systemImage: "magnifyingglass.circle")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }


    private var searchTextField: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)

                TextField("Search", text: $searchInput)
                    .focused($isInputActive)
                    .onChange(of: searchInput) {
                        viewModel.results = viewModel.getSearchResults(input: searchInput)
                    }

                if !searchInput.isEmpty {
                    Button(action: {
                        searchInput = ""
                        viewModel.results = []
                        isInputActive = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemGray5))
            )
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
        }
    }

    private var displayedCountries: [Country] {
        if isSortedAlphabetically {
            return viewModel.countriesList.sorted { $0.name.common < $1.name.common }
        } else {
            return viewModel.countriesList
        }
    }

    private var sortedResults: [Country] {
        if isSortedAlphabetically {
            return viewModel.results.sorted { $0.name.common < $1.name.common }
        } else {
            return viewModel.results
        }
    }
    
    private var sortButtonFilled:some View{
        Image(systemName: "arrow.up.arrow.down.circle.fill")
            .resizable()
            .frame(width:20, height: 20)
    }
    private var sortButtonUnfilled:some View{
        Image(systemName:"arrow.up.arrow.down")
            .resizable()
            .frame(width:15, height: 15)
    }
    private var sortButton:some View{
        Button(action: {
            isSortedAlphabetically.toggle()
        }) {
            if isSortedAlphabetically{
                sortButtonFilled
            }
            else{
                sortButtonUnfilled
            }
                
        }
    }
}
