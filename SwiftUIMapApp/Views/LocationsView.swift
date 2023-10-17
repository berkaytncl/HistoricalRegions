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
            mapLayer.ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                    .padding()
                Spacer()
                locationPreviewCard
            }
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}

extension LocationsView {
    private var header: some View {
        VStack {
            Button(action: viewModel.toggleLocationsList) {
                Text(viewModel.mapLocation.name + ", " + viewModel.mapLocation.cityName)
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundStyle(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: viewModel.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: viewModel.showLocationsList ? -180 : 0))
                    }
            }
            .buttonStyle(.plain)
            
            if viewModel.showLocationsList {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    private var mapLayer: some View {
        Map(position: $viewModel.cameraPosition) {
            ForEach(viewModel.locations) { location in
                Annotation(
                    location.name + ", " + location.cityName,
                    coordinate: location.coordinates,
                    anchor: .bottom
                ) {
                    LocationMarkerView()
                        .scaleEffect(viewModel.mapLocation == location ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            viewModel.changeMapLocation(location: location)
                        }
                }
            }
        }
    }
    
    private var locationPreviewCard: some View {
        ForEach(viewModel.locations) { location in
            if viewModel.mapLocation == location {
                LocationPreviewCardView(location: location)
                    .shadow(color: .black.opacity(0.3), radius: 20)
                    .padding()
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)))
            }
        }
    }
}
