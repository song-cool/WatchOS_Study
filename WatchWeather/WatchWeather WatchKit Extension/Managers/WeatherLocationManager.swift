//
//  WeatherLocationManager.swift
//  WatchWeather WatchKit Extension
//
//  Created by 송시원 on 2022/08/10.
//

import Foundation
import CoreLocation

final class WeatherLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    // 가장 최신 위치 데이터를 받아오게하는 프로토콜임
    
    @Published var cityName = "Seoul"
    @Published var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.231, longitude: -122.2322)
    
    private var locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.requestAlwaysAuthorization()
        // 계속 사용하는동안 위치를 트레킹하는걸 허용해주는 역할을함.
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return}
        coordinate = location.coordinate
        
        
    }
    
    private func getCityForCoordinates(location: CLLocationCoordinate2D) {
        let url = URL(string: "https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=\(location.latitude)&longitude=\(location.longitude)&localityLanguage=en")!
        NetworkManager<CityModel>().fetch(for: url) { (result) in
            switch result {
            case .failure(let err):
                print(err.localizedDescription)
            case .success(let cityData):
                self.cityName = "\(cityData.city), \(cityData.countryCode)"
            }
        }
    }
}
