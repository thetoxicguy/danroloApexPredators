//
//  Predators.swift
//  danroloApexPredators
//
//  Created by daniel.a.robles on 17/12/25.
//

import Foundation // Decoding tools for Swift UI

class Predators {
    var allApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
//        Access files in the project with Bundle.main.url
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
//            Encase the logic inside a do - catch, as a safe way to ensure the app will not crash if the data is unreachable
            do {
//                Try works here as await in JavaScript and expects a result or an error
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator] {
        return searchTerm.isEmpty
        ? apexPredators
        : apexPredators.filter {
            predator in
            predator.name.localizedCaseInsensitiveContains(searchTerm)
        }
    }
    
    func sort(by alphabeticalOrder: Bool) {
        apexPredators.sort { predator1, predator2 in
            if alphabeticalOrder {
                predator1.name < predator2.name
            } else {
                predator1.id < predator2.id
            }
        }
    }
    
    func filter(by type: APType) {
        if type == .all {
            apexPredators = allApexPredators
        } else {
            apexPredators = allApexPredators.filter { predator in
                predator.type == type
            }
        }
    }
}
