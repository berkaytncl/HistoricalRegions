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
    @Published private(set) var locations: [Location]
    
    // Current location on map
    @Published private(set) var mapLocation: Location {
        didSet {
            updateCameraPosition(location: mapLocation)
        }
    }
    
    // Current camera position on map
    @Published var cameraPosition: MapCameraPosition = MapCameraPosition.region(MKCoordinateRegion())
    private let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // Show list of locations
    @Published private(set) var showLocationsList: Bool = false
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        
        mapLocation = locations.first!
        updateCameraPosition(location: mapLocation)
    }
    
    private func updateCameraPosition(location: Location) {
        withAnimation(.easeInOut) {
            self.cameraPosition = MapCameraPosition.region(MKCoordinateRegion(
                center: location.coordinates,
                span: self.mapSpan
            ))
        }
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }
    
    func changeMapLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPressed() {
        guard let currentIndex = locations.firstIndex(of: mapLocation) else { return }
        let nextIndex = (currentIndex + 1) % locations.count
        changeMapLocation(location: locations[nextIndex])
    }
}
