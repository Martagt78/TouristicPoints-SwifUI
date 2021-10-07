//
//  DetailsViewModel.swift
//  Touristics Points Swift
//
//  Created by Marta García on 13/9/21.
//

import SwiftUI
import MapKit

struct DetailViewModel: Identifiable, Hashable, Codable {
    
    var id: String
    var title: String
    var address: String
    var transport: String
    var email: String
    var geocoordinates: String
    var description: String
    var phone: String
    
//    let latitude: Double
//    let longitude: Double
    
}

