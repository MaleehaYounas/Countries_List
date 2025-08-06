import Foundation
import MapKit

class MapViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion()
    @Published var markerCoordinate: CLLocationCoordinate2D?

    func setRegionAndMarker(from coordinates: [Double]) {
        guard coordinates.count == 2 else { return }
        let lat = coordinates[0]
        let lon = coordinates[1]
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        markerCoordinate = location
        region = MKCoordinateRegion(
            center: location,
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    }
}
