import Foundation
import CoreLocation
import Combine
import SwiftUI

class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var servicesEnabled: Bool
    
    override init() {
        authorizationStatus = manager.authorizationStatus
        servicesEnabled = CLLocationManager.locationServicesEnabled()
        super.init()
        manager.delegate = self
    }
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
    func refreshStatus() {
        servicesEnabled = CLLocationManager.locationServicesEnabled()
        authorizationStatus = manager.authorizationStatus
    }
}
extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async {
            self.authorizationStatus = manager.authorizationStatus
            self.servicesEnabled = CLLocationManager.locationServicesEnabled()
        }
    }
    func locationManager(_manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
}

