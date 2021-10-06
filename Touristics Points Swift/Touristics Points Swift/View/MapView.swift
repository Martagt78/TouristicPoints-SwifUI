//
//  MapView.swift
//  Touristics Points Swift
//
//  Created by Marta García on 20/9/21.
//

import SwiftUI
import MapKit

struct MapView: View {
  
    @State var pointDetail: DetailViewModel?
    
    //para representar la region que sea o la ciudad, hay que darle cllocation
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 41.391926,
            longitude: 2.165208),
        span: MKCoordinateSpan(
            latitudeDelta: 0.2,
            longitudeDelta: 0.2))
    
    var body: some View {
       // coordinates.append(pointDetail?.geocoordinates.split(separator: ","));
        //convertir cada string de coordinates  a double y pasar como coordenadas.
        
        
        Map(coordinateRegion: $region, interactionModes: [.all], showsUserLocation: true, userTrackingMode: nil).ignoresSafeArea(.all)
//        VStack {
//            //crear modelo de tipo mkanotation y pasarselo a annotationItem
//            Map(coordinateRegion: $region, annotationItems: [pointDetail]) { place in
//                MapPin(coordinate: coordinates, tint: Color.red)
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
