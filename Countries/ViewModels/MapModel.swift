import Foundation
import MapKit

struct MapPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
