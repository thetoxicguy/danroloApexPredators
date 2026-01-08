//
//  PredatorMap.swift
//  danroloApexPredators
//
//  Created by daniel.a.robles on 08/01/26.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    let predators = Predators()

    @State var position: MapCameraPosition
    @State var satellite = false
    
    var body: some View {
        Map(position: $position) {
            ForEach(predators.apexPredators) { predator in
                Annotation(
                    predator.name,
                    coordinate: predator.location
                ) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                }
            }
        }
        .mapStyle(satellite
                  ? .imagery(elevation: .realistic)
                  : .standard(elevation: .realistic)
        )
        .overlay(alignment: .bottomTrailing) {
            Button {satellite.toggle()} label: {
                Image(systemName: "globe.americas.fill")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(3)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 7))
                    .shadow(radius: 3)
                    .padding()
                    
            }
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    PredatorMap(position: .camera(MapCamera(
        centerCoordinate: Predators().apexPredators[2].location,
        distance: 1000,
        heading: 250,
        pitch: 80
    )))
    .preferredColorScheme(.dark)
}
