//
//  PredatorDetail.swift
//  danroloApexPredators
//
//  Created by daniel.a.robles on 06/01/26.
//

import SwiftUI

struct PredatorDetail: View {
    let predator: ApexPredator

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

//                    Appearance in movies
                    Text("Appears in:")
                        .font(.title3)
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
    }
}

#Preview {
    PredatorDetail(predator: Predators().apexPredators[7])
        .preferredColorScheme(.dark)
}
