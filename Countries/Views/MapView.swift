import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var mapViewModel = MapViewModel()
    var coordinates: [Double]
    
    var body: some View {
        Map(
            coordinateRegion: $mapViewModel.region,
            interactionModes: .all,
            showsUserLocation: true,
            annotationItems: mapViewModel.markerCoordinate.map { [MapPin(coordinate: $0)] } ?? []
        ) { pin in
            MapMarker(coordinate: pin.coordinate, tint: .red)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onAppear {
            mapViewModel.setRegionAndMarker(from: coordinates)
        }
    }
}

