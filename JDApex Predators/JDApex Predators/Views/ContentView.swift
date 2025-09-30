//
//  ContentView.swift
//  JDApex Predators
//
//  Created by Jyotsna Daiyya on 23/04/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    var predators = Predators()
    
    var filterredDino : [ApexPredators] {
        predators.filter(by: selectedFilterItem)
        predators.filter(byMovie: movieSelected)
        predators.sort(by: alphabetic)
        return predators.filter(by: searchText)
    }
    
    @State var searchText = ""
    @State var alphabetic = false
    @State var selectedFilterItem : APType = APType.all
    @State var movieSelected : String = "All"
    
    var body: some View {
        
        NavigationStack{
            List {
                ForEach(filterredDino) { predator in
                    NavigationLink{
                        PredatorDetailView(predator: predator, mapCameraPosition: .camera(MapCamera(centerCoordinate: predator.clLocationCoordinate, distance: 30000)))
                    }
                    label:{
                        DinasourRow(predator: predator)
                    }
                }
                .onDelete { indexSet in
                    delete(indexSet)
                }
            }
            .overlay(content: {
                if(filterredDino.count == 0){
                    ContentUnavailableView.init("No data found", image: "magnifyingglass", description: Text("Please retry search or filter."))
                }
            })
            .navigationTitle("Dinosaurs")
            .searchable(text: $searchText, prompt: "Search")
            .disableAutocorrection(true)
            .animation(Animation.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        withAnimation {
                            alphabetic.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetic ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetic)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu{
                        Picker("Filter", selection: $selectedFilterItem.animation(.interactiveSpring)) {
                            ForEach(APType.allCases) { type in
                                if(type == .movies){
                                    Menu{
                                        Picker("Movies", selection: $movieSelected) {
                                            ForEach(predators.allMovies, id: \.self) { dino in
                                                Text(dino)
                                            }
                                        }
                                    }label:{
                                        Label(type.rawValue.capitalized, systemImage: type.iconName)
                                    }
                                }
                                else{
                                    Label(type.rawValue.capitalized, systemImage: type.iconName)
                                }
                            }
                        }
                    }label:{
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
    }
    
    func delete(_ indexSet : IndexSet){
        
        var predatorsToRemove = [Int]()
        
        for index in indexSet{
            predatorsToRemove.append(filterredDino[index].id)
        }
        
        predators.allPredators.removeAll { predator in
            predatorsToRemove.contains(predator.id)
        }
    }
}

struct DinasourRow : View {
    
    var predator : ApexPredators
    
    var body: some View {
        HStack{
            Image(predator.image)
                .resizable()
                .frame(width: 100, height: 100)
                .shadow(color: .init(.shadow), radius: 1)
            VStack(alignment: .leading){
                Text(predator.name)
                    .fontWeight(.bold)
                Text(predator.type.rawValue.capitalized)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.horizontal, 13)
                    .padding(.vertical, 5)
                    .background(predator.type.backgroud)
                    .clipShape(.capsule)
            }
        }
    }
}

#Preview {
    ContentView()
}
