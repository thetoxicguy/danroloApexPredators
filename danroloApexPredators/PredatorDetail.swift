//
//  PredatorDetail.swift
//  danroloApexPredators
//
//  Created by daniel.a.robles on 06/01/26.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    let predator: ApexPredator
    
    @State var position: MapCameraPosition
    
    @Namespace var namespace

    var body: some View {
//        We use (screen's) Geometry Reader for proper responsiveness among devices
        GeometryReader { geo in
            ScrollView {
                ZStack (alignment: .bottomTrailing) {
                    //                Background Image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            //                            Stop is the point where the gradient will start
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: .clear, location: 0.8),
                                    Gradient.Stop(color: .black, location: 1),
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        }

                    
                    //                Dinosaur Image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()

//                    Make use of the Geometry Reader
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3.7)
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                        .offset(y: 25)
                }
                
                //            Dinosaur Name
                VStack (alignment: .leading) {
                    Text(predator.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)

//                    Dinosaur Location
/* This link works because the navigation stack is working in the parent (ContentView)
 The steps to have this Map are:
 1. Import MapKit here and in the class and in the view
 2. Set the coordinates in a Class property to calculate lat and long in terms of
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
 3. Set a state here for the position in these terms.
 */
                    NavigationLink {
                        PredatorMap(position: .camera(MapCamera(
                            centerCoordinate: predator.location,
                            distance: 1000,
                            heading: 250,
                            pitch: 80
                        )))
                        .navigationTransition(.zoom(
//                            We give the id 1 in the namespace group
                            sourceID: 1, in: namespace
                            ))
                    } label: {
                        Map(position: $position) {
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.breathe)
                            }
                            .annotationTitles(.hidden)
                        }
                    }
                    .frame(height: 125)
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(alignment: .trailing) {
                        Image(systemName: "greaterthan")
                            .imageScale(.large)
                            .font(.title3)
                            .padding(.trailing, 5)
                    }
                    .overlay(alignment: .topLeading) {
                        Text("Current Location")
                            .padding([.leading, .bottom], 5)
                            .padding(.trailing, 8)
                            .background(.black.opacity(0.33))
                            .clipShape(.rect(bottomTrailingRadius: 10))
                    }
//                    We use the id 1 within the namespace group
                    .matchedTransitionSource(id: 1, in: namespace)

//                    Appearance in movies
                    Text("Appears in:")
                        .font(.title2)
                    ForEach (predator.movies, id: \.self) {
                        movie in
                        Text("• " + movie)
                            .font(.subheadline)
                    }

//                    Movie Moments (scenes)
                    Text("Movie Moments:")
                        .font(.title)
                        .padding(.top, 15)
                    ForEach (predator.movieScenes) {
                        scene in
                        Text("🎞️ " + scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                    }
                }
                .padding()
                .frame(width: geo.size.width, alignment: .leading)

//                Link to webpage
                Text("Learn more about \(predator.name)")
                    .font(.caption)
                
                Link(predator.link, destination: URL(string: predator.link)!)
                    .padding(.bottom, 25)
            }
        }
        .ignoresSafeArea()
        .toolbarBackground(.automatic)
    }
}

#Preview {
    let predator = Predators().apexPredators[7]
    
    NavigationStack {
        PredatorDetail(
            predator: predator,
            position: .camera(
                MapCamera(
                    centerCoordinate: predator.location,
                    distance: 30000
                )))
        .preferredColorScheme(.dark)
    }
}
