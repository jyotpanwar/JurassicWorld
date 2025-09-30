//
//  PredatorMapView.swift
//  JDApex Predators
//
//  Created by Jyotsna Daiyya on 26/04/25.
//

import SwiftUI
import MapKit

struct PredatorMapView: View {
    
    @State var mapCameraPosition: MapCameraPosition
    @State var isMapSatelite = false
    @State var selection : ApexPredators?
    
    var body: some View {
        
        let predators = Predators().predators

        ZStack(alignment: Alignment.bottomTrailing) {
            Map(position: $mapCameraPosition){
                ForEach(predators) { predator in
                    Annotation(predator.name, coordinate: predator.clLocationCoordinate) {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .scaleEffect(x: -1)
                            .shadow(color: Color.init(.shadow), radius: 8)
                            .onTapGesture {
                                selection = predator
                            }
                    }
                }
            }
            .mapStyle(isMapSatelite ? MapStyle.hybrid : .standard())
            .mapStyle(.standard(elevation: MapStyle.Elevation.realistic))
            Button {
                isMapSatelite.toggle()
            }label: {
                Image(systemName: isMapSatelite ? "globe.americas" : "globe.americas.fill")
            }
            .font(.largeTitle)
            .background(.ultraThinMaterial)
            .shadow(radius: 4)
            .cornerRadius(6)
            .padding()
        }
        .toolbarBackground(.automatic)
        .sheet(item: $selection, content: { predator in
            Text("\(predator.name)")
        })
    }
}

#Preview {
    
    let predator = Predators().predators[2]
    PredatorMapView(mapCameraPosition:.camera(MapCamera(centerCoordinate:
                                                            predator.clLocationCoordinate,
                                                        distance: 1000,
                                                        heading: 250,
                                                        pitch: 80)), selection: predator)
}

