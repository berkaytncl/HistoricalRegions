//
//  LocationsView.swift
//  SwiftUIMapApp
//
//  Created by Berkay Tuncel on 17.10.2023.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    
    var body: some View {
        ZStack {
            Map(position: $viewModel.cameraPosition)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}
