//
//  ApexPredator.swift
//  danroloApexPredators
//
//  Created by daniel.a.robles on 17/12/25.
//

// Decodable is to stand out that we are going ro fill data from an external data source
// Identifiable is basically to be able to use it in loops (like providing the key for react by setting "id:")
import SwiftUI
import MapKit

struct ApexPredator: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: APType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    struct MovieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
}

enum APType: String, Decodable, CaseIterable, Identifiable { // Assign the raw values by setting "String" instead of just .type
    case all
    case land
    case air
    case sea
    
    var id: APType { self }
    
    var background: Color {
        switch self {
        case .all: .gray // This color will not show in any case, it is just to be exhaustive with the cases
        case .land: .brown
        case .air: .teal
        case .sea: .blue
        }
    }
    
    var icon: String {
        switch self {
        case .all: "square.stack.3d.up.fill"
        case .land: "leaf.fill"
        case .air: "wind"
        case .sea: "drop.fill"
        }
    }
}
