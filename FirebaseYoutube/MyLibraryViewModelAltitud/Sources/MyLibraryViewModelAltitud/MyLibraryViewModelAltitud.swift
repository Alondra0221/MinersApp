// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import CoreLocation

public class viewModelAltitud: NSObject, ObservableObject{
    
    public var locationManager : CLLocationManager?
    @Published public var altitude : Double = 0.0
    
    public init (locationManager: CLLocationManager = CLLocationManager()){
        super.init()
        self.locationManager = locationManager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
}

extension viewModelAltitud : CLLocationManagerDelegate{
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
        switch manager.authorizationStatus{
        case .notDetermined:
            print("Location authorization no determined")
        case .restricted:
            print("Restricted")
        case .denied :
            print("Denied")
        case .authorizedAlways:
            manager.requestLocation()
            print("always granted")
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
            print("when in use granted")
        @unknown default :
            print("Unkowen")
        }
    }
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        locations.forEach{ location in
            self.altitude = location.altitude
        }
    }
}

