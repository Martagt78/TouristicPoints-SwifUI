//
//  MapView.swift
//  Touristics Points Swift
//
//  Created by Marta García on 20/9/21.
//

import SwiftUI
import MapKit

//struct MapView: View {
//
//    @State var pointDetail: DetailViewModel?
//
//    //para representar la region que sea o la ciudad, hay que darle cllocation
//    @State var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(
//            latitude: 41.3879,
//            longitude:  2.16992),
//        span: MKCoordinateSpan(
//            latitudeDelta: 0.075,
//            longitudeDelta: 0.075))
//
//    var body: some View {
//         //Map(coordinateRegion: $region, interactionModes: [.all], showsUserLocation: true, userTrackingMode: nil).ignoresSafeArea(.all)
//        VStack {
//            //crear modelo de tipo mkanotation y pasarselo a annotationItem
//            let coor = pointDetail?.geocoordinates.split(separator: ",")
//
//            Map(coordinateRegion: $region, annotationItems: pointDetail) { place in
//                MapPin(coordinate: place , tint: Color.red)
//            }
//        }
//    }
//}

struct MapMarker: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))

    let annotations = [
        MapMarker(coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)),
        MapMarker(coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508)),
        MapMarker(coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5)),
        MapMarker(coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667))
    ]

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: annotations) {
            MapPin(coordinate: $0.coordinate)
        }
        .frame(width: 400, height: 300)
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()

    }
}
