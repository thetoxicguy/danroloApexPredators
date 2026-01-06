//
//  ContentView.swift
//  danroloApexPredators
//
//  Created by daniel.a.robles on 16/12/25.
//

import SwiftUI

struct ContentView: View {
//    Call the Predators class and it initializes with the .apexPredators property
    let predators = Predators()
    
    @State var seartchText = ""
    @State var alphabeticallyOrdered: Bool = false
    @State var currentType = APType.all
    
    var filteredPredators: [ApexPredator] {
        predators.filter(by: currentType)
        predators.sort(by: alphabeticallyOrdered)
        return predators.search(for: seartchText)
    }

    var body: some View {
        NavigationStack {
            List(filteredPredators) { predator in
                NavigationLink {
                    PredatorDetail(predator: predator)
                } label: {
                    HStack {
                        // Dinosaur image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        VStack(alignment: .leading) {
                            // Name
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            // Type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $seartchText)
            .autocorrectionDisabled()
            .animation(.default, value: seartchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabeticallyOrdered.toggle()
                        }
                    } label: {
                        Image( systemName: alphabeticallyOrdered
                               ? "film"
                               : "textformat"
                        )
                        .symbolEffect(.bounce, value: alphabeticallyOrdered)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentType.animation()) {
                            ForEach(APType.allCases) { type in
                                Label(type.rawValue, systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .symbolEffect(.bounce, value: true)
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
