//
//  MapView.swift
//  Touristics Points Swift
//
//  Created by Marta García on 20/9/21.
//

import SwiftUI
import MapKit

struct MapMarker: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    
    @State var pointDetail: DetailViewModel?
    
    //para representar la region que sea o la ciudad, hay que darle cllocation
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 41.3879,
            longitude:  2.16992),
        span: MKCoordinateSpan(
            latitudeDelta: 0.04,
            longitudeDelta: 0.04))
    
    var body: some View {
        VStack {
            let coor = pointDetail?.geocoordinates.split(separator: ",")
            if let latitudeString = coor?[0] as? NSString, let longitudeString = coor?[1] as? NSString {
                let latitude = latitudeString.doubleValue
                let longitude = longitudeString.doubleValue
                
//                var region = MKCoordinateRegion(
//                        center: CLLocationCoordinate2D(
//                            latitude: latitude,
//                            longitude:  longitude),
//                        span: MKCoordinateSpan(
//                            latitudeDelta: 0.04,
//                            longitudeDelta: 0.04))
                
                let annotations = [
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                ]
                
                Map(coordinateRegion: $region, annotationItems: annotations) {
                    MapPin(coordinate: $0.coordinate , tint: Color.red)
                }
            }
        }
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
        
    }
}
