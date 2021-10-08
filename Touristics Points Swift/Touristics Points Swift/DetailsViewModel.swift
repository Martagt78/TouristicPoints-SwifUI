//
//  DetailsViewModel.swift
//  Touristics Points Swift
//
//  Created by Marta García on 13/9/21.
//

import SwiftUI
import MapKit

struct DetailViewModel: Identifiable, Hashable, Codable {
    
    let id: String
    let title: String
    let address: String
    let transport: String
    let email: String
    let geocoordinates: String
    let description: String
    let phone: String
    
//    let latitude: Double
//    let longitude: Double
    
}

