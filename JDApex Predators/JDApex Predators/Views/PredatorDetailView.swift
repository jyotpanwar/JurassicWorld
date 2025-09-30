//
//  PredatorDetailView.swift
//  JDApex Predators
//
//  Created by Jyotsna Daiyya on 26/04/25.
//

import SwiftUI
import MapKit

struct PredatorDetailView: View {
    
    var predator : ApexPredators
    @State var mapCameraPosition : MapCameraPosition
    @Namespace var animation : Namespace.ID
    
    var body: some View {
        
        GeometryReader { geo in
            ScrollView{
                ZStack(alignment: .bottomTrailing){
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [
                                Gradient.Stop(color: Color.clear, location: 0.8),
                                Gradient.Stop(color: Color.black, location: 1)],
                                           startPoint: UnitPoint.top,
                                           endPoint: UnitPoint.bottom)
                        }
                    NavigationLink(destination:
                                    Image(predator.image)
                                    .resizable()
                                    .scaledToFit())
                    {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width/1.5, height:
                                    geo.size.height/3.7)
                            .scaleEffect(x: -1)
                            .shadow(radius: 7)
                            .offset(y: 20)
                    }
                }
                VStack(alignment: .leading){
                    NavigationLink{
                        PredatorMapView(mapCameraPosition: .camera(MapCamera(centerCoordinate: predator.clLocationCoordinate, distance: 1000, heading: 250, pitch: 80)), selection: predator)
                            .navigationTransition(.zoom(sourceID: 1, in: animation))
                    }
                    label:{
                        Map(position: $mapCameraPosition){
                            Annotation(predator.name, coordinate: predator.clLocationCoordinate) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(Visibility.hidden)
                        }
                        .frame(height: 105)
                        .cornerRadius(10)
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .font(.largeTitle)
                        }
                        .overlay(alignment: .topLeading){
                            Text("Current location")
                                .font(.callout)
                                .padding(3)
                                .background(.black.opacity(0.30))
                                .clipShape(.rect(topLeadingRadius: 8, bottomTrailingRadius: 8))
                        }
                        .clipped()
                    }
                    .matchedTransitionSource(id: 1, in: animation)
                    Text(predator.name)
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Apperances in:")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.top)
                    ForEach(predator.movies, id: \.self){ movie in
                        Text("• "+movie)
                    }
                    
                    Text("Movie scenes:")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    ForEach(predator.movieScenes) { movieScene in
                        Text(movieScene.movie)
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.top, 5)
                        Text(movieScene.sceneDescription)
                    }
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .foregroundColor(.blue)
                }
                .padding()
                .frame(width: geo.size.width, alignment: .leading)
            }
        }
        .ignoresSafeArea()
        .toolbarBackgroundVisibility(.automatic)
    }
}

#Preview {
    
    let predator = Predators().predators[2]
    PredatorDetailView(predator: predator, mapCameraPosition: .camera(MapCamera(centerCoordinate: predator.clLocationCoordinate, distance: 30000 )))
    
}
