//
//  Predators.swift
//  JDApex Predators
//
//  Created by Jyotsna Daiyya on 23/04/25.
//

import Foundation

class Predators{
    
    var allPredators : [ApexPredators] = []
    var predators : [ApexPredators] = []
    
    init () {
        decodeJsonData()
    }
    
    func decodeJsonData() {
        
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do{
                let data = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                predators = try jsonDecoder.decode([ApexPredators].self, from: data)
                allPredators = predators
            }
            catch{
                print("\(error) : Error while decoding json")
            }
        }
    }
    
    func filter(by searchText : String) -> [ApexPredators]{
        if searchText.isEmpty {
            return predators
        }
        else{
           return predators.filter { predator in
               predator.name.localizedCaseInsensitiveContains(searchText)
           }
        }
    }
    
    func sort(by alphabetical : Bool){
        predators.sort(by: { apexPredators1, apexPredators2 in
            if alphabetical{
                apexPredators1.name < apexPredators2.name
            }
            else{
                apexPredators1.id < apexPredators2.id
            }
        })
    }
    
    func filter(by type : APType){
        if type == APType.all{
            predators = allPredators
        }
        else{
            predators = allPredators.filter({ predator in
                predator.type == type
            })
        }
    }
    
    func filter(byMovie : String){
        if (byMovie == "All")
        {
            return
        }
        
        predators = allPredators.filter({ predator in
            predator.movies.contains(byMovie)
        })
    }
}

extension Predators{
    
    var allMovies : [String] {
        var newValue = Set<String>()
        for predator in allPredators {
            newValue = newValue.union(predator.movies)
        }
        newValue.insert("All")
        return Array(newValue).sorted()
    }
}
