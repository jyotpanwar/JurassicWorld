//
//  APType.swift
//  JDApex Predators
//
//  Created by Jyotsna Daiyya on 23/04/25.
//

import SwiftUI

enum APType : String, Decodable, Identifiable, CaseIterable {
    
    var id : APType{
        return self
    }
    
    case all, land, air, sea, movies
 
    var backgroud : Color {
        switch self {
        case .land:
            return .brown
        case .air:
            return .teal
        case .sea:
            return .blue
        case .all:
            return .gray
        case .movies:
            return .gray
        }
    }
    
    var iconName : String {
        switch self {
        case .land:
            return "leaf.fill"
        case .air:
            return "wind"
        case .sea:
            return "drop.fill"
        case .all:
            return "square.stack.3d.up.fill"
        case .movies:
            return "film"
        }
    }
}

