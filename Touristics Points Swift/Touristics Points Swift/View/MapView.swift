//
//  MapView.swift
//  Touristics Points Swift
//
//  Created by Marta García on 20/9/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    //para representar la region que sea o la ciudad, hay que darle cllocation
    //let geocoordinates: DetailViewModel
    
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 41.391926,
            longitude: 2.165208),
        span: MKCoordinateSpan(
            latitudeDelta: 0.2,
            longitudeDelta: 0.2))
    
    
    var body: some View {
        Map(coordinateRegion: $region, interactionModes: [.all], showsUserLocation: true, userTrackingMode: nil)
//        VStack {
//            Map(coordinateRegion: $region, annotationItems: [geocoordinates]) { item in
//                MapPin(coordinate: item.geocoordinates.coordinate, tint: Color.red)
//            }
//            
//        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
