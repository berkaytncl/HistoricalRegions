//
//  LocationsViewModel.swift
//  SwiftUIMapApp
//
//  Created by Berkay Tuncel on 17.10.2023.
//

import SwiftUI
import MapKit

class LocationsViewModel: ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location]
    
    // Current location on map
    @Published var mapLocation: Location {
        didSet {
            updateCameraPosition(location: mapLocation)
        }
    }
    
    @Published var cameraPosition: MapCameraPosition = MapCameraPosition.region(MKCoordinateRegion())
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        
        mapLocation = locations.first!
        updateCameraPosition(location: mapLocation)
    }
    
    private func updateCameraPosition(location: Location) {
        withAnimation(.easeInOut) {
            cameraPosition = MapCameraPosition.region(MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan
            ))
        }
    }
}
