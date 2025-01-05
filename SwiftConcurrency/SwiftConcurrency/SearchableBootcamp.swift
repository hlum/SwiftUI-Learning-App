//
//  SearchableBootcamp.swift
//  SwiftConcurrency
//
//  Created by Hlwan Aung Phyo on 8/12/24.
//

import SwiftUI
import Combine

struct Restaurant: Identifiable, Hashable{
    let id : String
    let title : String
    let cuisine : CuisineOption
}

enum CuisineOption :String{
    case american,italian,japanese,burmese
}

final class RestaurantManager{
    func getAllRestaurants() async throws -> [Restaurant] {
        
        return [
            Restaurant(id: "1", title: "Burger Shack", cuisine: .american),
            Restaurant(id: "2", title: "Pasta Palace", cuisine: .italian),
            Restaurant(id: "3", title: "Sushi Heaven", cuisine: .japanese),
            Restaurant(id: "4", title: "Suzen", cuisine: .burmese)
            
        ]
    }
}

@MainActor
final class SearchableBootcampModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchScope:SearchScopeOption = .all
    @Published private(set) var allRestaurants: [Restaurant] = []
    @Published private(set) var filteredRestaurants: [Restaurant] = []
    @Published private(set) var allSearchScopes:[SearchScopeOption] = []
    
    
    
    private var cancellables  = Set<AnyCancellable>()
    
    let manager = RestaurantManager()
    
    var isSearching:Bool{
        !searchText.isEmpty
    }
    
    enum SearchScopeOption:Hashable{
        case all
        case cuisine(option:CuisineOption)
        
        var title:String{
            switch self{
            case .all:
                return "All"
            case .cuisine(option: let option):
                return option.rawValue.capitalized
            }
        }
    }
    
    init(){
        addSubscribers()
    }
    
    private func addSubscribers(){
        
        $searchText
            .combineLatest($searchScope)
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] searchText,searchScope in
                self?.filterRestaurants(searchText: searchText,currentSearchScope: searchScope)
            }
            .store(in: &cancellables)
    }
    
    var showSuggestions:Bool{
        searchText.count < 5
    }
    
    func getSearchSuggestion() -> [String] {
        guard showSuggestions else{ return [] }
        var suggestion : [String] = []
        
        let search = searchText.lowercased()
        if search.contains("pa"){
            suggestion.append("Pasta")
        }
        if search.contains("su"){
            suggestion.append("Sushi")
        }
        if search.contains("Su"){
            suggestion.append("Suzen")
        }
        if search.contains("bu"){
            suggestion.append("Burger")
        }
        suggestion.append(CuisineOption.italian.rawValue.capitalized)
        suggestion.append(CuisineOption.american.rawValue.capitalized)

        suggestion.append(CuisineOption.japanese.rawValue.capitalized)

        suggestion.append(CuisineOption.burmese.rawValue.capitalized)
        
        return suggestion
    }
    
    func getRestaurantSuggestion()->[Restaurant]{
        guard showSuggestions else{ return [] }
        var suggestion : [Restaurant] = []
        
        let search = searchText.lowercased()
        if search.contains("ita"){
            suggestion.append(contentsOf:allRestaurants.filter({$0.cuisine == .italian}))
        }
        if search.contains("jap"){
            suggestion.append(contentsOf:allRestaurants.filter({$0.cuisine == .japanese}))
        }
        if search.contains("am"){
            suggestion.append(contentsOf:allRestaurants.filter({$0.cuisine == .american}))
        }
        if search.contains("bu"){
            suggestion.append(contentsOf:allRestaurants.filter({$0.cuisine == .burmese}))
        }
        return suggestion
    }
    
    
    private func filterRestaurants(searchText:String,currentSearchScope:SearchScopeOption){
        guard !searchText.isEmpty else{
            filteredRestaurants = []
            searchScope = .all
            return
        }
        //Filter on the searchScope
        var restaurantsInScope = allRestaurants
        switch currentSearchScope{
            case .all:
            restaurantsInScope = allRestaurants
        case .cuisine(option: let option):
            restaurantsInScope = allRestaurants.filter({ $0.cuisine == option })
        }
        
        //Filter on the searchText
        let search = searchText.lowercased()
        filteredRestaurants = restaurantsInScope.filter({ restaurant in
            
            let titleContainsSearch = restaurant.title.lowercased().contains(search)
            let cuisineContainsSearch = restaurant.cuisine.rawValue.lowercased().contains(search)
            
            return (titleContainsSearch || cuisineContainsSearch)
        })
    }
    
    
    func loadRestaurants() async {
        do{
            allRestaurants = try await manager.getAllRestaurants()
            let allCuisines = Set(allRestaurants.map{$0.cuisine})
            allSearchScopes = [.all] + allCuisines.map({ option in
                SearchScopeOption.cuisine(option: option)
            })
        }catch{
            print(error.localizedDescription)
        }
    }
}

struct SearchableBootcamp: View {
    @StateObject private var viewModel = SearchableBootcampModel()
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing:20){
                    ForEach(viewModel.isSearching ? viewModel.filteredRestaurants : viewModel.allRestaurants, id: \.self) { restaurant in
//                        restaurantRow(restaurant: restaurant)
                        NavigationLink(value: restaurant) {
                            restaurantRow(restaurant: restaurant)
                        }
                    }
                }
                .padding()
//                Text("ViewModel is Searching: \(viewModel.isSearching)")
//                SearchChildView()
            }
            .searchable(text:$viewModel.searchText, placement: .automatic,prompt: Text("Search..."))
            .searchScopes($viewModel.searchScope, scopes: {
                ForEach(viewModel.allSearchScopes,id:\.self){scope in
                    Text(scope.title)
                        .tag(scope)
                }
            })
            .searchSuggestions({
                ForEach(viewModel.getSearchSuggestion(),id:\.self){ suggestion in
                    Text(suggestion)
                        .searchCompletion(suggestion)
                }
                ForEach(viewModel.getRestaurantSuggestion(),id:\.self){ suggestion in
                    NavigationLink(value: suggestion) {
                        Text(suggestion.title)
                    }
                }

            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Restaurants")
            .task{
                await viewModel.loadRestaurants()
            }
            .navigationDestination(for: Restaurant.self) { restaurant in
                Text(restaurant.title.uppercased())
            }
        }
    }
    private func restaurantRow(restaurant:Restaurant) -> some View{
        VStack(alignment: .leading,spacing: 10) {
            Text(restaurant.title)
                .font(.headline)
            Text(restaurant.cuisine.rawValue.capitalized)
                .font(.caption)
        }
        .padding()
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(Color.black.opacity(0.05))
    }
}
//
//struct SearchChildView:View{
//    @Environment(\.isSearching) private var isSearching
//    var body: some View{
//        Text("Child is searching \(isSearching.description)")
//    }
//}

#Preview {
    NavigationStack{
        SearchableBootcamp()
    }
}
