//
//  Location.swift
//  SwiftUIMapApp
//
//  Created by Berkay Tuncel on 17.10.2023.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {
    var id: String { name + cityName }
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    
    // Equatable
    static func == (lhs: Location, rhs: Location) -> Bool { lhs.id == rhs.id }
}
