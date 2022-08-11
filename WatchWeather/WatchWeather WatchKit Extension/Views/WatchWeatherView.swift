//
//  WatchWeatherView.swift
//  WatchWeather WatchKit Extension
//
//  Created by 송시원 on 2022/08/10.
//

import SwiftUI

struct WatchWeatherView: View {
    
    @ObservedObject private var locationManager = WeatherLocationManager()
    @ObservedObject private var weatherManager = WeatherManager()
    
    var body: some View {
        ZStack {
            OutlineView()
            VStack(alignment: .center, spacing: 0) {
                HStack {
                    Text(locationManager.cityName)
                        .lineLimit(1)
                        .minimumScaleFactor(0.005)
                    
                    Image(systemName:  " paperplane.fill")
                        .font(.caption)
                }
                Image(systemName:  weatherManager.weatherResponse.forecast.first?.conditions ?? "sun.min")
                    .font(.title)
                    .foregroundColor(.yellow)
                Text(weatherManager.weatherResponse.forecast.first?.description ?? "")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                Text("\(String(format: "%0.0f",weatherManager.weatherResponse.forecast.first?.temperature ?? 0.0))∘F")
                    .bold()
                    .font(.title)
            }
            .shadow(color: Color.white.opacity(0.2), radius: 2, x: -2, y: -2)
            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
        }
        .onReceive(locationManager.$cityName, perform: { _ in
            weatherManager.getWeather(for: WeatherCoordinates(lat: locationManager.coordinate.latitude, lon: locationManager.coordinate.longitude))
        })
    }
}

struct WatchWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WatchWeatherView()
    }
}
