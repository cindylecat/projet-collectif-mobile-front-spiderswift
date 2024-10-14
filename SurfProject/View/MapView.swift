//
//  MapView.swift
//  SurfProject
//
//  Created by Bertrand MARIE on 30/08/2024.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct MapView: View {
    @State private var cameraPosition: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 46.915052, longitude: -2.041419),
        span: MKCoordinateSpan(latitudeDelta: 2.1, longitudeDelta: 0.9)
    ))
    @State var isShowingSpotInfos = false //save pin action on tap
    @State private var selectedSpot: SurfSpotDetail? //optional type -> can do a [SurfSpot] type
    
    @ObservedObject var viewModel = SurfSpotDetailViewModel()
    var PinModel = PinView(risk: "")
    
    var body: some View {
        
        Map(position: $cameraPosition) {
            ForEach(viewModel.surfSpotDetails, id: \.id) { spot in
                Annotation(spot.name, coordinate: CLLocationCoordinate2D(latitude: spot.latitude, longitude: spot.longitude)) {
                        Button(action: {
                        isShowingSpotInfos.toggle() //on-off effect sheet
                        selectedSpot = spot //simple spot selector
                    }) {
                        PinView(risk: spot.risk)
                    } //end of button action
                } //end of Annotation
            } //end of loop
        } //end of map
        
        .sheet(isPresented: $isShowingSpotInfos) {
            if let spot = selectedSpot {
                VStack { //sheet view info of spot
                    Text(spot.name).font(.title).fontWeight(.bold)
                    Text("Ville: \(spot.city)")
                    Text("Latitude: \(spot.latitude)")
                    Text("Longitude: \(spot.longitude)")
                    HStack {
                        Text("Difficulté:")
                        Text(spot.risk)
                            .foregroundColor(PinModel.colorBackPin())
                            .   fontWeight(.bold)
                    }
                } //end of sheet view info of spot
                .presentationDetents([.medium, .large])
                .presentationBackground(.thinMaterial)
            } else {
                Text("No Spot Selected")
                    .presentationDetents([.medium, .large])
                    .presentationBackground(.thinMaterial)
            } //end of spot condition
        } //end of sheet isShowingSpotInfos
        
        ZStack {
            Rectangle()
                .frame(width: 1000, height: 80)
                .foregroundColor(.blue)
                .padding(-6)
            HStack {
                Circle()
                    .frame(width: 43, height: 43)
                    .foregroundColor(.white)
                    .overlay {
                        Image(systemName: "surfboard.fill")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                Text("SpiderSurf Open !")
                    .foregroundColor(.white)
            }
        }
    } //end body
} //end struct

#Preview {
    MapView()
}
