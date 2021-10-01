//
//  PointsViewModel.swift
//  Touristics Points Swift
//
//  Created by Marta García on 13/9/21.
//

import SwiftUI


struct PointsViewModel: Codable, Identifiable, Hashable {
    
    let id = UUID()
    var list: [PointViewModel]
    
}

struct PointViewModel: Codable, Identifiable, Hashable {
    
    let id: String
    let title: String
    let geocoordinates: String
    
}








