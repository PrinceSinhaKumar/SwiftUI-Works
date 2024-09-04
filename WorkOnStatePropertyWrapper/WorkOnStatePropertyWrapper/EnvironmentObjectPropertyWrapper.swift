//
//  EnvironmentObjectPropertyWrapper.swift
//  WorkOnStatePropertyWrapper
//
//  Created by  Prince Shrivastav on 30/08/24.
//

import SwiftUI

class WeatherInfo: ObservableObject {
    @Published var currentWeather: CurrentWeather?
    @Published var forecast: [Forecast]?
    
    init(currentWeather: CurrentWeather? = nil, forecast: [Forecast]? = nil) {
        self.currentWeather = currentWeather
        self.forecast = forecast
    }
}

class CurrentWeather: ObservableObject {
    var temp: String
    init(temp: String) {
        self.temp = temp
    }
}

class Forecast: ObservableObject {
    var id = UUID()
    var hummidity: String
    init(id: UUID = UUID(), hummidity: String) {
        self.id = id
        self.hummidity = hummidity
    }
}

struct EnvironmentObjectPropertyWrapper: View {
    @StateObject var weatherInfoData: WeatherInfo = WeatherInfo(currentWeather: CurrentWeather(temp: "30"), forecast: [Forecast(hummidity: "45")])
    var body: some View {
        TabView {
            CurrentWeatherView()
                .tabItem { Label("Current", systemImage: "sun.max") }
            ForecastView()
                .tabItem { Label("Forecast", systemImage: "cloud.sun.rain") }
        }
        .environmentObject(weatherInfoData)
    }
}

#Preview {
    EnvironmentObjectPropertyWrapper()
}

struct CurrentWeatherView: View {
    @EnvironmentObject var currentWeather: WeatherInfo
    var body: some View {
        HStack {
            Text(currentWeather.currentWeather?.temp ?? "")
        }
    }
}
struct ForecastView: View {
    @EnvironmentObject var forecast: WeatherInfo
    var body: some View {
        HStack {
            Text(forecast.forecast?.first?.hummidity ?? "")
        }
    }
}
