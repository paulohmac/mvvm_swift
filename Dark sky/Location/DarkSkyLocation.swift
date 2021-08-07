//
//  DarkSkyLocation.swift
//  Classe que recupera do sensores do CoreLocation
//  a posição atual e retorna via NotificationCenter
//
//  Created by Paulo H.Machtura on 15/02/20.
//

import UIKit
import CoreLocation




class DarkSkyLocation: NSObject {
    var dataSend = false
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation?
    static let kLocationDidChangeNotification = "LocationDidChangeNotification"

    /*
    // MARK: - Singleton
    */
    static let shared = DarkSkyLocation()
      
    private override init() {
        super.init()
    }
    /// Inicia a geolocalização.
    ///
    func startLocationService(){
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()

        self.locationManager.startUpdatingLocation()
    }
    /// Finaliza a geolocalizao.
    ///
    func stopLocationService(){
        self.locationManager.stopUpdatingLocation()
    }
}

extension DarkSkyLocation: CLLocationManagerDelegate{
    /*
    // MARK: - Location implementation
    */
    /// Ao receber a atualização de posição, dispara uma mensagem via NotificationCenter

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        currentLocation = locations[0]
        DispatchQueue.main.async {
            if(!self.dataSend){
                NotificationCenter.default.post(name: Notification.Name(DarkSkyLocation.self.kLocationDidChangeNotification), object: self.currentLocation)
                self.dataSend = true
            }
        }
    }
}
 
