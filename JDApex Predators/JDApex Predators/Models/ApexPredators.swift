//
//  ApexPredators.swift
//  JDApex Predators
//
//  Created by Jyotsna Daiyya on 23/04/25.
//

import MapKit

struct ApexPredators : Decodable, Identifiable
{
    let id : Int
    let name : String
    let type : APType
    let latitude : Double
    let longitude : Double
    let movies : [String]
    let movieScenes : [MovieScenes]
    let link : String
    
    var image : String {
        return name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var clLocationCoordinate : CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

